#version 300 es
vec2 _49;
void main()
{
    vec2 _48;
    switch (gl_VertexID & 3)
    {
        case 0:
        {
            _48 = vec2(-4.0, -1.0);
            break;
        }
        case 1:
        {
            _48 = vec2(1.0, -1.0);
            break;
        }
        case 2:
        {
            _48 = vec2(1.0, 4.0);
            break;
        }
        default:
        {
            _48 = _49;
            break;
        }
    }
    gl_Position = vec4(_48, 0.0, 1.0);
}
