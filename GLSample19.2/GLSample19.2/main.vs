//#version 120

attribute vec4 VertexPosition;
attribute vec4 colorIn;


uniform mat4 cameraToClipMatrix;
uniform mat4 worldToCameraMatrix;
uniform mat4 modelToWorldMatrix;
uniform vec4 fragModulationColor;

varying vec4 colorForFS;

void main()
{
	vec4 temp = modelToWorldMatrix * VertexPosition;
    temp = worldToCameraMatrix * temp;
    gl_Position = cameraToClipMatrix * temp;
    colorForFS=colorIn;
}
