//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 colour;

void main()
{
    gl_FragColor = colour * texture2D( gm_BaseTexture, v_vTexcoord );
}
