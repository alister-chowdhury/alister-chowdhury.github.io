#version 300 es
uniform highp sampler2D inVoidData;
uniform highp vec4 textureSizeAndInvSize;
uniform highp int updateSpan;
ivec2 _209;
void main()
{
    uint _41 = floatBitsToUint(texelFetch(inVoidData, ivec2(0), 0).y);
    uint _46 = uint(gl_VertexID);
    uint _50 = _46 % 6u;
    uint _192;
    if (_50 >= 3u)
    {
        _192 = _50 - 2u;
    }
    else
    {
        _192 = _50;
    }
    uint _55 = _46 / 6u;
    int _62 = int((_55 & 1u) << uint(1));
    int _66 = int(_55 & 2u);
    int _72 = int(_41 & 65535u);
    int _76 = int(_41 >> uint(16));
    int _203;
    if (float(_72) >= (textureSizeAndInvSize.x * 0.5))
    {
        _203 = -_62;
    }
    else
    {
        _203 = _62;
    }
    int _206;
    if (float(_76) >= (textureSizeAndInvSize.y * 0.5))
    {
        _206 = -_66;
    }
    else
    {
        _206 = _66;
    }
    int _195;
    if ((_192 & 1u) == 0u)
    {
        _195 = -updateSpan;
    }
    else
    {
        _195 = updateSpan + 1;
    }
    ivec2 _188 = _209;
    _188.x = _72 + _195;
    int _198;
    if ((_192 & 2u) == 0u)
    {
        _198 = -updateSpan;
    }
    else
    {
        _198 = updateSpan + 1;
    }
    ivec2 _191 = _188;
    _191.y = _76 + _198;
    gl_Position = vec4(((((vec2(_191) + vec2(0.5)) * textureSizeAndInvSize.zw) * 2.0) - vec2(1.0)) + vec2(float(_203), float(_206)), 0.0, 1.0);
}
