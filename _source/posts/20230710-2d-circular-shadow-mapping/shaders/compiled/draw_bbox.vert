#version 300 es
uniform highp sampler2D lightBBox;
out vec3 vsToFsCol;
void main()
{
    int _105 = gl_VertexID & 1;
    int _108 = gl_VertexID / 2;
    int _114 = _108 / 4;
    vec4 _130 = texelFetch(lightBBox, ivec2(_114, 0), 0);
    vec2 _278;
    switch (_108 & 3)
    {
        case 0:
        {
            vec2 _277;
            if (_105 == 0)
            {
                _277 = _130.xy;
            }
            else
            {
                _277 = _130.zy;
            }
            _278 = _277;
            break;
        }
        case 1:
        {
            vec2 _276;
            if (_105 == 0)
            {
                _276 = _130.zy;
            }
            else
            {
                _276 = _130.zw;
            }
            _278 = _276;
            break;
        }
        case 2:
        {
            vec2 _275;
            if (_105 == 0)
            {
                _275 = _130.zw;
            }
            else
            {
                _275 = _130.xw;
            }
            _278 = _275;
            break;
        }
        case 3:
        {
            vec2 _274;
            if (_105 == 0)
            {
                _274 = _130.xw;
            }
            else
            {
                _274 = _130.xy;
            }
            _278 = _274;
            break;
        }
        default:
        {
            _278 = vec2(0.0);
            break;
        }
    }
    uint _200 = (uint(_114) * 5123u) + 9128u;
    uint _237 = ((_200 ^ 61u) ^ (_200 >> uint(16))) * 9u;
    uint _243 = (_237 ^ (_237 >> uint(4))) * 668265261u;
    float _255 = float((_243 ^ (_243 >> uint(15))) & 65535u) * 9.15541313588619232177734375e-05;
    vsToFsCol = clamp(vec3(abs(_255 - 3.0) - 1.0, 2.0 - abs(_255 - 2.0), 2.0 - abs(_255 - 4.0)), vec3(0.0), vec3(1.0));
    gl_Position = vec4((_278 * 2.0) - vec2(1.0), 0.0, 1.0);
}
