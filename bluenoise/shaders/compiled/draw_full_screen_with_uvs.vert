#version 300 es
out vec2 uv;
vec2 _56;
void main()
{
    vec2 _55;
    switch (gl_VertexID & 3)
    {
        case 0:
        {
            _55 = vec2(-4.0, -1.0);
            break;
        }
        case 1:
        {
            _55 = vec2(1.0, -1.0);
            break;
        }
        case 2:
        {
            _55 = vec2(1.0, 4.0);
            break;
        }
        default:
        {
            _55 = _56;
            break;
        }
    }
    gl_Position = vec4(_55, 0.0, 1.0);
    uv = (_55 * 0.5) + vec2(0.5);
}
