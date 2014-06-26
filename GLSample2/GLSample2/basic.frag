//#version 120
void main(void)
{
	lowp float lerpValue = gl_FragCoord.y / 512.0;

	gl_FragColor = mix(vec4(1.0, 0.0, 0.0, 1.0),
        vec4(0.0, 1.0, 0.0, 1.0), lerpValue);;
}
