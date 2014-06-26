//#version 120

varying lowp vec3 FrontColor;
varying lowp vec3 BackColor;
varying lowp vec2 TexCoord;

void main() {
    const lowp float scale = 15.0;

    bvec2 toDiscard = greaterThan( fract(TexCoord * scale), vec2(0.2,0.2) );

    if( all(toDiscard) )
        discard;
    else {
        if( gl_FrontFacing )
           gl_FragColor = vec4(FrontColor, 1.0);
        else
           gl_FragColor = vec4(BackColor/6.0, 1.0);
    }
}
