//#version 120

varying lowp vec3 lightcolor;

void main() 
{
    gl_FragColor = vec4(lightcolor, 1.0);
}
