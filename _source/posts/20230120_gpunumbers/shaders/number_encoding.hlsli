#pragma once

// This contains logic for encoding and drawing numbers.
// The encoding logic is based off:
// https://github.com/alister-chowdhury/impl-function-ref/blob/master/generic/encode_number_for_gpu_rendering.inl
//
// The way this works is by packing a u32 with 8 characters (4 bits per character).
// This is useful because it requires a fixed amount of storage and max triangle count.
// If the number doesn't fit into the budget (8 characters), engineering notation is used instead.
//
// Unlike the C++ version, this only supports encoding 8 characters on the GPU.
// But does support sampling a uvec2 (for 16 characters).
//
// The drawing part uses a 5x6 1bpp font (30bits), with each character encoded into a
// uint that can be sampled from.
//
// Functions:
//  uint encodeNumber(uint value);
//  uint encodeNumber(int value);
//  uint encodeNumber(float value);
//
//  uint sampleEncodedDigit(uint encodedDigit, float2 uv);
//  uint sampleEncodedNumber(uint encodedNumber, float2 uv);
//  uint sampleEncodedNumber(uint2 encodedNumber, float2 uv);
//
// It's worth noting `sampleEncodedNumber` will scale the UV.x by 1.2
// to add a logical 1px padding.
// So you should be aiming to draw a box with an aspect ratio of 6:1


// GL = Y starts at the bottom
// DX = Y starts at the top
#ifndef Y_STARTS_AT_BOTTOM
#define Y_STARTS_AT_BOTTOM 0
#endif


// Encoding logic

#define GPU_NUMBER_ENCODING_E        10
#define GPU_NUMBER_ENCODING_DOT      11
#define GPU_NUMBER_ENCODING_PLUS     12
#define GPU_NUMBER_ENCODING_NEG      13
#define GPU_NUMBER_ENCODING_INVALID  14
#define GPU_NUMBER_ENCODING_EMPTY    15

#define INV_LN_10 0.434294481903251827651128918916605082294397005803666566

#define pow10(x)            pow(10, x)
#define floorLog10(x)       floor(log(x) * INV_LN_10)


#define GPU_NUMBER_ENCODING_DYNAMIC_INT     0
#define GPU_NUMBER_ENCODING_DYNAMIC_UINT    1
#define GPU_NUMBER_ENCODING_DYNAMIC_FLOAT   2


float fractInputReturnFloor(inout float x)
{
    float floored = floor(x);
    x -= floored;
    return floored;
}


struct RepBuffer
{
    uint    data;
    uint    index;

    static RepBuffer init()
    {
        RepBuffer repBuffer = (RepBuffer)0;
        return repBuffer;
    }

    void push(uint value)
    {
        data |= ((~value) & 15) << (4 * index++);
    }

    void pop(uint count)
    {
        if(count > index) { count = index; }
        uint mask = ~0;
        mask >>= ((count - index) * 4);
        data &= mask;
        index -= count;
    }

    uint remainingSpace()
    { 
        return 8 - index;
    }

    uint get()
    {
        return data;
    }
    
    static uint getZero()
    {
        RepBuffer repBuffer = RepBuffer::init();
        repBuffer.push(0);
        repBuffer.push(GPU_NUMBER_ENCODING_DOT);
        repBuffer.push(0);
        return repBuffer.get();
    }

    static uint getNan()
    {
        RepBuffer repBuffer = RepBuffer::init();
        repBuffer.push(GPU_NUMBER_ENCODING_INVALID);
        repBuffer.push(GPU_NUMBER_ENCODING_DOT);
        repBuffer.push(GPU_NUMBER_ENCODING_INVALID);
        return repBuffer.get();
    }

    static uint getPosInf()
    {
        RepBuffer repBuffer = RepBuffer::init();
        repBuffer.push(GPU_NUMBER_ENCODING_PLUS);
        repBuffer.push(9);
        repBuffer.push(GPU_NUMBER_ENCODING_E);
        repBuffer.push(GPU_NUMBER_ENCODING_PLUS);
        repBuffer.push(9);
        repBuffer.push(9);
        repBuffer.push(9);
        repBuffer.push(9);
        return repBuffer.get();
    }

    static uint getNegInf()
    {
        RepBuffer repBuffer = RepBuffer::init();
        repBuffer.push(GPU_NUMBER_ENCODING_NEG);
        repBuffer.push(9);
        repBuffer.push(GPU_NUMBER_ENCODING_E);
        repBuffer.push(GPU_NUMBER_ENCODING_PLUS);
        repBuffer.push(9);
        repBuffer.push(9);
        repBuffer.push(9);
        repBuffer.push(9);
        return repBuffer.get();
    }

};


RepBuffer encodeWholeNumber(float x, bool isInteger)
{
    RepBuffer repBuffer = RepBuffer::init();

    if(x < 0)
    {
        x = -x;
        repBuffer.push(GPU_NUMBER_ENCODING_NEG);
    }

    int e10 = int(floorLog10(x));
    float d10 = pow10(-e10);

    // Scale down
    x *= d10;

    // Apply rounding logic
    x += 0.5f * pow10(-int(repBuffer.remainingSpace()) + 2);

    // Deal with really odd case
    // where we round up enough to
    // change our current number
    if(x >= 10.0f)
    {
        x *= 0.1f;
        ++e10;
    }

    // Numbers >= 1, will also omit 0 for decimal numbers
    if(e10 >= 0)
    {
        for(int i=0; i<=e10; ++i)
        {
            uint decimal = uint(fractInputReturnFloor(x));
            x *= 10.0f;
            repBuffer.push(decimal);
        }

        // stop on whole numbers or if we'd just write a single decimal place
        if(isInteger || (repBuffer.remainingSpace() <= 1))
        {
            return repBuffer;
        }
    }


    // Decimals
    {
        // Include decimal place as zero we wish to strip
        uint writtenZeroes = 1;
        repBuffer.push(GPU_NUMBER_ENCODING_DOT);

        // Fill in 0's
        for(int i=0; i<(-e10-1); ++i)
        {
            repBuffer.push(0);
            ++writtenZeroes;
        }

        // Use the remaining space for anything left
        uint budget = repBuffer.remainingSpace();

        // for(uint i=0; i<budget; ++i)
        while(budget--)
        {
            uint decimal = uint(fractInputReturnFloor(x));
            x *= 10.0f;
            if(decimal == 0)
            {
                ++writtenZeroes;
            }
            else
            {
                writtenZeroes = 0;
            }
            repBuffer.push(decimal);
        }

        // Clear trailing 0's and possibly the decimal place
        repBuffer.pop(writtenZeroes);
    }

    return repBuffer;
}


RepBuffer encodeWholeNumber(float x)
{
    return encodeWholeNumber(x, floor(x) == x);
}


RepBuffer encodeWholeNumber(int x)
{
    return encodeWholeNumber(float(x), true);
}


RepBuffer encodeWholeNumber(uint x)
{
    return encodeWholeNumber(float(x), true);
}


RepBuffer encodeEngNotation(float x)
{

    RepBuffer repBuffer = RepBuffer::init();

    if(x < 0)
    {
        x = -x;
        repBuffer.push(GPU_NUMBER_ENCODING_NEG);
    }

    int e10 = int(floorLog10(x));
    float d10 = pow10(-e10);

    // Scale down
    x *= d10;

    uint budget = repBuffer.remainingSpace();

    // X.e+X
    budget -= 5;
    if(abs(e10) >= 10)
    {
        budget -= 1;
    }

    // Apply rounding logic
    x += 0.5f * pow10(-int(budget));

    // Deal with really odd case
    // where we round up enough to
    // change our current number
    if(x >= 10.0f)
    {
        x *= 0.1f;
        // Even odder case where our budget decreases
        if(++e10 == 10)
        {
            budget -= 1;
        }
    }

    // First number and a dot
    {
        uint decimal = uint(fractInputReturnFloor(x));
        x *= 10.0f;
        repBuffer.push(decimal);
        repBuffer.push(GPU_NUMBER_ENCODING_DOT);
    }


    while(budget != 0)
    {
        uint decimal = uint(fractInputReturnFloor(x));
        x *= 10.0f;
        repBuffer.push(decimal);
        --budget;
    }

    repBuffer.push(GPU_NUMBER_ENCODING_E);
    repBuffer.push((e10 < 0) ? GPU_NUMBER_ENCODING_NEG : GPU_NUMBER_ENCODING_PLUS);

    if(e10 < 0)
    {
        e10 = -e10;
    }

    // NB: We only handle two digit exponents (which is fine for floats)
    if(e10 >= 10)
    {
        repBuffer.push(uint(e10 / 10));
    }

    repBuffer.push(uint(e10) % 10);

    return repBuffer;
}


bool requiresEngineerNotation(float value)
{
    // This is the maximum float we can represent as an integer.
    // before errors start emerging, (8000011 will output 8000012).
    // Found purely by brute force.
    const float maxValidFloat = 8000010.0f;
    if(value == 0 || value == -0) return false;
    if(value < 0)
    {
        value = -value;
        return !(value <= maxValidFloat && value >= 0.001);
    }
    return !(value <= maxValidFloat && value >= 0.0001);
}


bool requiresEngineerNotation(int value)
{
    if(value < 0)
    {
        value = -value;
        return !(value < 10000000);
    }
    return !(value < 100000000);
}


bool requiresEngineerNotation(uint value)
{
    return !(value < 100000000);
}


uint encodeNumber(uint value)
{
    if(value == 0) { return RepBuffer::getZero(); }
    RepBuffer buf;

    if(requiresEngineerNotation(value))
    {
        buf = encodeEngNotation(float(value));
    }
    else
    {
        buf = encodeWholeNumber(value);
    }
    return buf.get();
}


uint encodeNumber(int value)
{
    if(value == 0) { return RepBuffer::getZero(); }

    RepBuffer buf;

    if(requiresEngineerNotation(value))
    {
        buf = encodeEngNotation(float(value));
    }
    else
    {
        buf = encodeWholeNumber(value);
    }

    return buf.get();
}


uint encodeNumber(float value)
{
    if(value == 0)      { return RepBuffer::getZero(); }
    if(isnan(value))    { return RepBuffer::getNan(); }
    if(isinf(value))
    {
        if(value > 0)
        {
            return RepBuffer::getPosInf();
        }
        return RepBuffer::getNegInf();
    }

    RepBuffer buf;

    if(requiresEngineerNotation(value))
    {
        buf = encodeEngNotation(value);
    }
    else
    {
        buf = encodeWholeNumber(value);
    }
    return buf.get();
}



uint encodeNumberDynamic(uint data, uint numberEncodingType=GPU_NUMBER_ENCODING_DYNAMIC_INT)
{
    float encodingValue;
    bool useEngNotation;
    bool isInteger;

    if(numberEncodingType == GPU_NUMBER_ENCODING_DYNAMIC_INT)
    {
        int native = asint(data);
        useEngNotation = requiresEngineerNotation(native);
        encodingValue = float(native);
        isInteger = true;
    }
    else if(numberEncodingType == GPU_NUMBER_ENCODING_DYNAMIC_UINT)
    {
        useEngNotation = requiresEngineerNotation(data);
        encodingValue = float(data);
        isInteger = true;
    }
    else if (numberEncodingType == GPU_NUMBER_ENCODING_DYNAMIC_FLOAT)
    {
        encodingValue = asfloat(data);
        useEngNotation = requiresEngineerNotation(encodingValue);
        
        if(isnan(encodingValue))
        {
            return RepBuffer::getNan();
        }
        
        if(isinf(encodingValue))
        {
            if(encodingValue > 0)
            {
                return RepBuffer::getPosInf();
            }
            return RepBuffer::getNegInf();
        }

        isInteger = floor(encodingValue) == encodingValue;
    }
    else
    {
        // Assume decoded
        return data;
    }

    if(encodingValue == 0)
    {
        return RepBuffer::getZero();
    }

    RepBuffer buf;

    if(useEngNotation)
    {
        buf = encodeEngNotation(encodingValue);
    }
    else
    {
        buf = encodeWholeNumber(encodingValue, isInteger);
    }

    return buf.get();
}


//// Drawing logic

// .###. ..#.. .###. ##### #...# ##### .#### ##### .###. .###.
// #..## .##.. #...# ....# #...# #.... #.... ....# #...# #...#
// #.#.# ..#.. ...#. ..##. #...# ####. ####. ...#. .###. #...#
// ##..# ..#.. ..#.. ....# .#### ....# #...# ..#.. #...# .####
// #...# ..#.. .#... #...# ....# ....# #...# ..#.. #...# ....#
// .###. .###. ##### .###. ....# ####. .###. ..#.. .###. .###.
//
// ..... ..... ..... ..... ..... .....
// .###. ..... ..... ..... .#.#. .....
// #...# ..... ..#.. ..... ##### .....
// ##### ..... .###. .###. .#.#. .....
// #.... .##.. ..#.. ..... ##### .....
// .###. .##.. ..... ..... .#.#. .....

const static uint numberPixels[16] = {
#if !Y_STARTS_AT_BOTTOM
    0x1d19d72eu, 0x1c4210c4u, 0x3e22222eu, 0x1d18321fu,
    0x210f4631u, 0x1f083c3fu, 0x1d18bc3eu, 0x0842221fu,
    0x1d18ba2eu, 0x1d0f462eu, 0x1c1fc5c0u, 0x0c600000u,
    0x00471000u, 0x00070000u, 0x15f57d40u, 0x00000000u
#else
    0x1d9ace2eu, 0x0862108eu, 0x1d14105fu, 0x3f06422eu,
    0x2318fa10u, 0x3e17c20fu, 0x3c17c62eu, 0x3f041084u,
    0x1d17462eu, 0x1d18fa0eu, 0x00e8fc2eu, 0x000000c6u,
    0x00023880u, 0x00003800u, 0x00afabeau, 0x00000000u
#endif
};


uint sampleEncodedDigit(uint encodedDigit, float2 uv)
{
    if(uv.x < 0. || uv.y < 0. || uv.x >= 1. || uv.y >= 1.) return 0u;
    uint2 coord = uint2(uv * float2(5., 6.));
    return (numberPixels[encodedDigit] >> (coord.y * 5u + coord.x)) & 1u;
}


// 8 character variant
uint sampleEncodedNumber(uint encodedNumber, float2 uv)
{
    // Extract the digit ID by scaling the uv.x value by 8 and clipping
    // the relevant 4 bits.
    uv.x *= 8.0;
    uint encodedDigit = (encodedNumber >> (uint(uv.x) * 4u)) & 0xf;
    
    // Put the U in between then [0, 1.2] range, the extra 0.2 is add a
    // logical 1px padding.
    // (6/5, where 5 is the number of pixels on the x axis)
    uv.x = frac(uv.x) * 1.2;

    return sampleEncodedDigit(encodedDigit, uv);
}
