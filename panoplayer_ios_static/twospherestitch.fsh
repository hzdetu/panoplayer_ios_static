precision highp float;
precision highp int;
precision lowp sampler2D;
precision lowp samplerCube;

varying highp float v_pos_y;
varying highp vec2 v_TexCoordinateA;
varying highp vec2 v_TexCoordinateB;

uniform float v_masksize;
uniform sampler2D u_TextureA;
uniform sampler2D u_TextureB;




void main() {
    highp vec4 colA = texture2D(u_TextureA, v_TexCoordinateA);
    highp vec4 colB = texture2D(u_TextureA, v_TexCoordinateB);

 

    colA.a = 1.0;
    colB.a = 1.0;

    float  yy = v_pos_y;
    float  masksize =v_masksize;
   	float  Midsize = 0.0;
    
    float alpha = 0.0;
    if(yy < Midsize - masksize){
       alpha = 0.0;
    }else if( yy > Midsize + masksize){
      alpha = 1.0;
    }else{
        
        float  index =  yy - (Midsize - masksize);
        float al =  index * 1.0 / (masksize * 2.0);
        alpha = al;
        
    }
      

    //alpha = 0.5;
    gl_FragColor = colA * alpha + colB * (1.0 - alpha);
    
}