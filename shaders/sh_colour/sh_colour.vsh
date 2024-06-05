attribute vec3 in_Position;
attribute vec2 in_Textcoord0;
attribute vec4 in_Textcoord1;
varying vec2 v_vTexcoord;
varying vec4 v_vRepeat;
void main(){
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    v_vTexcoord = in_Textcoord0;
    v_vRepeat = in_Textcoord1;
}