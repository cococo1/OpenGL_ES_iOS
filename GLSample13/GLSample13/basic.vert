attribute vec4 vertexPosition;
attribute vec4 colorIn;

uniform mat4 cameraToClipMatrix;
uniform mat4 modelToCameraMatrix;

varying vec4 colorForFS;

void main()
{
	vec4 cameraPos = modelToCameraMatrix * vertexPosition;
    gl_Position = cameraToClipMatrix * cameraPos;
    colorForFS=colorIn;
}
