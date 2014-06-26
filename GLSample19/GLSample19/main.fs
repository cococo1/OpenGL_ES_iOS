//#version 120
varying lowp vec4 colorForFS;
uniform lowp vec4 fragModulationColor;

void main()
{
	gl_FragColor=colorForFS*fragModulationColor;
}
