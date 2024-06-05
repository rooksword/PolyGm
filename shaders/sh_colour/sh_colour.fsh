//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vRepeat;

uniform vec4 colour;

void main()
{
    vec2 UV = v_vTexcoord - floor( v_vTexcoord / v_vRepeat.xy - v_vRepeat.zw ) * v_vRepeat.xy;
    gl_FragColor = colour * texture2D( gm_BaseTexture, UV);
}