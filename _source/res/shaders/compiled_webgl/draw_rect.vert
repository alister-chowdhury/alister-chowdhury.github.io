#version 300 es
uniform highp vec4 inRectBounds;
void main()
{
    int _115;
    do
    {
        if (gl_VertexID < 3)
        {
            _115 = gl_VertexID;
            break;
        }
        _115 = gl_VertexID - 2;
        break;
    } while(false);
    float _116;
    if ((_115 & 1) == 0)
    {
        _116 = inRectBounds.x;
    }
    else
    {
        _116 = inRectBounds.z;
    }
    float _117;
    if ((_115 & 2) == 0)
    {
        _117 = inRectBounds.y;
    }
    else
    {
        _117 = inRectBounds.w;
    }
    gl_Position = vec4((vec2(_116, _117) * 2.0) - vec2(1.0), 0.0, 1.0);
}
