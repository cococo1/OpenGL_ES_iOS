
varying lowp vec4 color;

void main()
{
	lowp vec4 fragColor = color;
	fragColor.a = gl_FragCoord.y/512.0;
	gl_FragColor = fragColor;
}