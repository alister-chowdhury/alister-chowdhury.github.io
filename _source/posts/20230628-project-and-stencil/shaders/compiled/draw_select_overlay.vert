#version 300 es
uniform highp vec4 bbox;
out vec2 localNDC;
void main()
{
    int _111;
    do
    {
        if (gl_VertexID < 3)
        {
            _111 = gl_VertexID;
            break;
        }
        _111 = gl_VertexID - 2;
        break;
    } while(false);
    float _40 = float(_111 & 1);
    float _43 = float(_111 >> 1);
    localNDC = (vec2(_40, _43) * 2.0) - vec2(1.0);
    gl_Position = vec4(mix(bbox.x, bbox.z, _40), mix(bbox.y, bbox.w, _43), 0.0, 1.0);
}
