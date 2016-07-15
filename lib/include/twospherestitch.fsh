precision highp float;
precision highp int;
precision lowp sampler2D;
precision lowp samplerCube;

varying highp float v_pos_x;
varying highp vec2 v_TexCoordinateA;
varying highp vec2 v_TexCoordinateB;

uniform float v_masksize;
uniform sampler2D u_TextureA;
uniform sampler2D u_TextureB;



uniform bool forward;
uniform bool isYuv420;


uniform sampler2D SamplerY;
uniform sampler2D SamplerU;
uniform sampler2D SamplerV;
uniform mat3 colorConversionMatrix;


void main() {
    highp vec4 colA;
    highp vec4 colB;
    
    if(!isYuv420){
        colA = texture2D(u_TextureA, v_TexCoordinateA);
        colB = texture2D(u_TextureA, v_TexCoordinateB);
        
    }else{
        mediump vec3 yuv;
        mediump vec3 yuv2;
        
        
        // Subtract constants to map the video range start at 0
        yuv.x = (texture2D(SamplerY, v_TexCoordinateA).r - (16.0/255.0));
        yuv.y = (texture2D(SamplerU, v_TexCoordinateA).r - 0.5);
        yuv.z = (texture2D(SamplerV, v_TexCoordinateA).r - 0.5);
        colA =  vec4(colorConversionMatrix * yuv,1);
        
        
        
        // Subtract constants to map the video range start at 0
        yuv2.x = (texture2D(SamplerY, v_TexCoordinateB).r - (16.0/255.0));
        yuv2.y = (texture2D(SamplerU, v_TexCoordinateB).r - 0.5);
        yuv2.z = (texture2D(SamplerV, v_TexCoordinateB).r - 0.5);
        colB = vec4(colorConversionMatrix * yuv2,1);
    }
    
    colA.a = 1.0;
    colB.a = 1.0;
    
    float  yy = v_pos_x;
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