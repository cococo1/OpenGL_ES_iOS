//#version 120

attribute vec3 VertexPosition;

uniform mat4 cameraToClipMatrix;
uniform mat4 worldToCameraMatrix;
uniform mat4 modelToWorldMatrix;

void main()
{
    vec4 temp = modelToWorldMatrix * vec4(VertexPosition,1.0);
    temp = worldToCameraMatrix * temp;
    gl_Position = cameraToClipMatrix * temp;
}
