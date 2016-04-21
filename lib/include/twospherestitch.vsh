attribute vec4 a_Position;
attribute vec2 a_TexCoordinateA;
attribute vec2 a_TexCoordinateB;

uniform mat4 u_MVPMatrix;


varying vec2 v_TexCoordinateA;
varying vec2 v_TexCoordinateB;
varying float v_pos_y;
 

void main() {
    gl_Position = u_MVPMatrix*a_Position;
    v_TexCoordinateA = a_TexCoordinateA ;
    v_TexCoordinateB = a_TexCoordinateB ;
    v_pos_y = a_Position.y;
 }
