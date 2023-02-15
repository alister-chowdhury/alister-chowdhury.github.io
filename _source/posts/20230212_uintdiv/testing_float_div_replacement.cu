

// Did apparently break my laptop...


// Theoretically *should* work up until 16777216



/*
uint fastUintDiv(uint a, uint b)
{
    // return uint(float(a) / float(b));                            // requires explicit fdiv, not rcp
    // return uint(asfloat(1 + asuint(float(a) * rcp(float(b)))));  // 36 cycles, works past 0xffff
    return uint(float(a) * rcp(float(b)) + asfloat(0x38000001));    // 32 cycles, works if x, y <= 65174
}





#define asfloat  uintBitsToFloat
#define asuint   floatBitsToUint
#define rcp(x)   (1./x)



// INTEL: (a <= 3981553, b <= 111602) 
// NVIDIA: (a <= VERY LARGE,  b <= 988)
uint fastUintDiv(uint a, uint b)
{
    return uint(asfloat(1u + asuint(float(a) * rcp(float(b)))));  // 36 cycles, works past 0xffff
}



uint fastUintDiv2(uint a, uint b)
{
    return uint(asfloat(2u + asuint(float(a) * rcp(float(b)))));  // 36 cycles, works past 0xffff
}








uint fasterUintDiv(uint a, uint b)
{
    return uint(float(a) * rcp(float(b)) + asfloat(0x38000001u));    // 32 cycles, works if x, y <= 65174
}




*/




/*

WEBGL ES


int fdiv(int a, int b)
{
    highp float x = float(a);
    highp float y = float(b);
    highp float z = (x ) / y;
    return int(z);
}




void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    
    ivec2 fc = ivec2(fragCoord ) + 1;
    //fc.x = iFrame;
    int f0 = fdiv(fc.x, fc.y);
    int f1 = fc.x / fc.y;
    
    float eq = float(f0 == f1);
    float lt = float(f0 < f1);
    float gt = float(f0 > f1);


    // Output to screen
    fragColor = vec4(vec3(lt, eq, gt),1.0);
    
    fragColor.xyz = vec3(eq);
    
}
*/


__global__ void t(int offsetx, int offsety, int* allocator, int* writeback)
{
    int x = blockDim.x * blockIdx.x + threadIdx.x + 1 + offsetx;
    int y = blockDim.y * blockIdx.y + threadIdx.y + 1 + offsety;
    int z0 = x / y;
    int z1 = int(float(x) / float(y));
    if(z0 != z1)
    {
        int k = atomicAdd(allocator, 1);
        // writeback[k*2 + 0] = x;
        // writeback[k*2 + 1] = y;
    }
}



#include <stdio.h>


// Have run to 8781824, and apparently no breakage.


int main(void)
{
    int* allocator;
    int* writeback;
    
    cudaMalloc(&allocator, sizeof(int));
    cudaMemset(allocator, 0, sizeof(int));
    cudaMalloc(&writeback, sizeof(int) * 1024 * 1024);

    dim3 block(32, 32);
    dim3 grid(1024, 1024);

    dim3 periteration (block.x * grid.x, block.y * grid.y);

    // for(int x=0; x<131072; ++x)
    // for(int y=0; y<131072; ++y)
    for(int x=0; x<131072; ++x)
    for(int y=0; y<=x; ++y)
    {
        int offsetx = periteration.x * x;
        int offsety = periteration.y * y;
        t<<<grid, block>>>(offsetx, offsety, allocator, writeback);

        int numNotOk;
        cudaMemcpy(&numNotOk, allocator, sizeof(int), cudaMemcpyDeviceToHost);


        printf("[%i, %i] => [%i, %i], num-invalid = %i\n", offsetx, offsety, offsetx + periteration.x, offsety + periteration.y, numNotOk);
        if(numNotOk)
        {
            goto escape;
        }

    }

    escape:
    return 0;

}