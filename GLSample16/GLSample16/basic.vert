attribute vec4 vertexPosition;
attribute vec4 colorIn;

uniform mat4 cameraToClipMatrix;
uniform mat4 modelToCameraMatrix;
//uniform vec3 offset;


varying vec4 colorForFS;

void main()
{
	vec4 cameraPos = modelToCameraMatrix * vertexPosition;
//    cameraPos+=vec4(offset.x, offset.y, offset.z, 0.0);
    gl_Position = cameraToClipMatrix * cameraPos;
    colorForFS=colorIn;
}
