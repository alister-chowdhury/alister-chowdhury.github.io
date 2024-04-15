#version 460 core

#define USE_IMAGE_BUFFERS 0

#include "bn2common.glsli"


layout(binding = 0) uniform BufferToImageParams_
{
    ivec2 numTiles;
};


readonly IMAGESTORAGE_R32f(1, bnValue);


layout(location = 0) out float outBnValue;


void main()
{
    ivec2 writeCoord = ivec2(gl_FragCoord.xy);
    ivec2 tileId = writeCoord / TILE_SIZE;
    ivec2 innerCoord = writeCoord % TILE_SIZE;

    TileUpdateData tileData;
    tileData.tileIdOffset = ivec2(0);
    tileData.numTiles = numTiles;
    tileData.expMultiplier = 0;
    tileData.writeValue = 0;
    tileData.randomSeed = 0;

    bn_coord_t targetPixel = getFullResCoord(tileId, innerCoord, tileData);
    outBnValue = IMAGE_LOAD_R(bnValue, targetPixel);
}
