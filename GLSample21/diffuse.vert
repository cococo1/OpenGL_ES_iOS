//#version 120

attribute vec3 VertexPosition;
attribute vec3 VertexNormal;

varying vec3 LightIntensity;

uniform vec4 LightPosition; // Light position in eye coords.
uniform vec3 Kd;            // Diffuse reflectivity
uniform vec3 Ld;            // Diffuse light intensity

uniform mat4 ModelViewMatrix;
uniform mat3 NormalMatrix;
uniform mat4 MVP;

void main()
{
    vec3 tnorm = normalize( NormalMatrix * VertexNormal);
    vec4 cameraCoords = ModelViewMatrix * vec4(VertexPosition,1.0);
    vec3 s = normalize(vec3(LightPosition - cameraCoords));

    LightIntensity = Ld * Kd * max( dot( s, tnorm ), 0.0 );

    gl_Position = MVP * vec4(VertexPosition,1.0);
}
