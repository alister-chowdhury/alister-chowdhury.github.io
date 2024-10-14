#include "rgbcx.h"
#include "bc7enc.h"
#include "compress_common.h"

// RGBA8 for all inputs [4x4]
uint8_t g_input_pixel_data[64];

// 8 bytes for BC1, BC4
// 16 bytes for everything else
uint8_t g_output_pixel_data[16];


extern "C" {


WASM_EXPORT void init()
{
    rgbcx::init(rgbcx::bc1_approx_mode::cBC1Ideal);
    bc7enc_compress_block_init();
}

WASM_EXPORT uint8_t* input_pixel_addr()
{
    return g_input_pixel_data;
}

WASM_EXPORT uint8_t* output_pixel_addr()
{
    return g_output_pixel_data;
}

// level : [0, 18]
WASM_EXPORT void bc1(uint32_t level)
{
    rgbcx::encode_bc1(level,
                      (void*)g_output_pixel_data,
                      g_input_pixel_data,
                      true, /* allow_3color */
                      false /* use_transparent_texels_for_black */
                      );
}

// level : [0, 18]
WASM_EXPORT void bc3(uint32_t level)
{
    rgbcx::encode_bc3_hq(level,
                         (void*)g_output_pixel_data,
                         g_input_pixel_data);
}

// level 0 - normal
// level 1 - hq
WASM_EXPORT void bc4(uint32_t level)
{
    if(level == 0u)
    {
        rgbcx::encode_bc4((void*)g_output_pixel_data,
                          g_input_pixel_data);
    }
    else
    {
        rgbcx::encode_bc4_hq((void*)g_output_pixel_data,
                             g_input_pixel_data);
    }
}

// level 0 - normal
// level 1 - hq
WASM_EXPORT void bc5(uint32_t level)
{
    if(level == 0u)
    {
        rgbcx::encode_bc5((void*)g_output_pixel_data,
                          g_input_pixel_data);
    }
    else
    {
        rgbcx::encode_bc5_hq((void*)g_output_pixel_data,
                             g_input_pixel_data);
    }
}

// level [0, 5]
WASM_EXPORT void bc7(uint32_t level)
{

    bc7enc_compress_block_params p;
    bc7enc_compress_block_params_init(&p);

    if(level > 4)
    {
        p.m_mode17_partition_estimation_filterbank = false;
        level = 4;
    }

    p.m_uber_level = level;

    bc7enc_compress_block((void*)g_output_pixel_data,
                          g_input_pixel_data, &p);
}


} // Extern "C"