#version 300 es
uniform highp usampler2D lightOBBox;
out vec3 vsToFsCol;
void main()
{
    int _105 = gl_VertexID & 1;
    int _108 = gl_VertexID / 2;
    int _114 = _108 / 4;
    uvec4 _130 = texelFetch(lightOBBox, ivec2(_114, 0), 0);
    vec2 _298;
    switch (_108 & 3)
    {
        case 0:
        {
            vec2 _297;
            if (_105 == 0)
            {
                _297 = unpackHalf2x16(_130.x);
            }
            else
            {
                _297 = unpackHalf2x16(_130.y);
            }
            _298 = _297;
            break;
        }
        case 1:
        {
            vec2 _296;
            if (_105 == 0)
            {
                _296 = unpackHalf2x16(_130.y);
            }
            else
            {
                _296 = unpackHalf2x16(_130.z);
            }
            _298 = _296;
            break;
        }
        case 2:
        {
            vec2 _295;
            if (_105 == 0)
            {
                _295 = unpackHalf2x16(_130.z);
            }
            else
            {
                _295 = unpackHalf2x16(_130.w);
            }
            _298 = _295;
            break;
        }
        case 3:
        {
            vec2 _294;
            if (_105 == 0)
            {
                _294 = unpackHalf2x16(_130.w);
            }
            else
            {
                _294 = unpackHalf2x16(_130.x);
            }
            _298 = _294;
            break;
        }
        default:
        {
            _298 = vec2(0.0);
            break;
        }
    }
    uint _212 = (uint(_114) * 5123u) + 9128u;
    uint _249 = ((_212 ^ 61u) ^ (_212 >> uint(16))) * 9u;
    uint _255 = (_249 ^ (_249 >> uint(4))) * 668265261u;
    float _267 = float((_255 ^ (_255 >> uint(15))) & 65535u) * 9.15541313588619232177734375e-05;
    vsToFsCol = clamp(vec3(abs(_267 - 3.0) - 1.0, 2.0 - abs(_267 - 2.0), 2.0 - abs(_267 - 4.0)), vec3(0.0), vec3(1.0));
    gl_Position = vec4((_298 * 2.0) - vec2(1.0), 0.0, 1.0);
}
