precision mediump float;
uniform sampler2D u_Texture;


//uniform sampler2D SamplerUV;

varying vec2 v_TexCoordinate;
uniform bool forward;
uniform bool isYuv420;


uniform sampler2D SamplerY;
uniform sampler2D SamplerU;
uniform sampler2D SamplerV;
uniform mat3 colorConversionMatrix;
void main(){
    
    if(forward)
    {
        highp vec4 colA = texture2D(u_Texture, v_TexCoordinate);
        

        if(v_TexCoordinate.y < 0.999 && v_TexCoordinate.y >0.001){
            gl_FragColor = texture2D(u_Texture, v_TexCoordinate);
        }else {
            //gl_FragColor  = vec4(0.0,0.0,0.0,0.5);
            //gl_FragColor = texture2D(u_Texture, v_TexCoordinate);
            float alpha = 0.0;
            gl_FragColor = colA * alpha + vec4(0.0,0.0,0.0,1) * (1.0 - alpha);
        }
    }
    else{
        if(!isYuv420){
            gl_FragColor = texture2D(u_Texture, v_TexCoordinate);
        }else{
            mediump vec3 yuv;
            lowp vec3 rgb;
            
            // Subtract constants to map the video range start at 0
            yuv.x = (texture2D(SamplerY, v_TexCoordinate).r - (16.0/255.0));
            yuv.y = (texture2D(SamplerU, v_TexCoordinate).r - 0.5);
            yuv.z = (texture2D(SamplerV, v_TexCoordinate).r - 0.5);
            rgb = colorConversionMatrix * yuv;
            gl_FragColor = vec4(rgb,1);
        }
        
    }
}
