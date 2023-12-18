#version 300 es
uniform highp vec4 inRectBounds;
out vec2 ndc;
void main()
{
    int _116;
    do
    {
        if (gl_VertexID < 3)
        {
            _116 = gl_VertexID;
            break;
        }
        _116 = gl_VertexID - 2;
        break;
    } while(false);
    float _117;
    if ((_116 & 1) == 0)
    {
        _117 = inRectBounds.x;
    }
    else
    {
        _117 = inRectBounds.z;
    }
    float _118;
    if ((_116 & 2) == 0)
    {
        _118 = inRectBounds.y;
    }
    else
    {
        _118 = inRectBounds.w;
    }
    ndc = (vec2(_117, _118) * 2.0) - vec2(1.0);
    gl_Position = vec4(ndc, 0.0, 1.0);
}
