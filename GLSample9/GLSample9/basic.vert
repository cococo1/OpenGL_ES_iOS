attribute vec4 vertexPosition;
attribute vec4 colorIn;
uniform vec2 offset;
uniform mat4 perspectiveMatrix;
varying vec4 colorForFS;

void main()
{
	vec4 cameraPos = vertexPosition + vec4(offset.x, offset.y, 0.75, 0.0);
    gl_Position = perspectiveMatrix * cameraPos;
    colorForFS=colorIn;
}
