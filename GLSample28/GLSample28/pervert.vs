//#version 120

attribute vec3 VertexPosition;
attribute vec3 VertexNormal;

varying vec3 lightcolor;

uniform mat4 ModelViewMatrix;
uniform mat3 NormalMatrix;
uniform mat4 ProjectionMatrix;
uniform mat4 MVP;

uniform vec4 LightPosition;
uniform vec3 LightIntensity;

uniform vec3 Kd;            // Diffuse reflectivity
uniform vec3 Ka;            // Ambient reflectivity
uniform vec3 Ks;            // Specular reflectivity
uniform float Shininess;    // Specular shininess factor

vec3 ads(vec3 Normal, vec3 Position)
{
    vec3 s = normalize( vec3(LightPosition) - Position );
    vec3 v = normalize(vec3(-Position));
    vec3 r = reflect( -s, Normal );

    return
        LightIntensity * ( Ka +
          Kd * max( dot(s, Normal), 0.0 ) +
          Ks * pow( max( dot(r,v), 0.0 ), Shininess ) );
}


void main()
{
	lightcolor=ads(normalize( NormalMatrix * VertexNormal),vec3( ModelViewMatrix * vec4(VertexPosition,1.0) ));
    gl_Position = MVP * vec4(VertexPosition,1.0);
}
