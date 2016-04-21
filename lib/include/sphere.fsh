precision mediump float;
uniform sampler2D u_Texture;
varying vec2 v_TexCoordinate;

uniform bool forward;
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
        gl_FragColor = texture2D(u_Texture, v_TexCoordinate);
    }
}
