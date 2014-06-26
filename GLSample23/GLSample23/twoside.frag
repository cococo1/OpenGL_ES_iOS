//#version 120

varying lowp vec3 FrontColor;
varying lowp vec3 BackColor;

void main() {

    if( gl_FrontFacing ) {
        gl_FragColor = vec4(FrontColor, 1.0);
    } else {        
        gl_FragColor = vec4(BackColor, 1.0);
    }
}
