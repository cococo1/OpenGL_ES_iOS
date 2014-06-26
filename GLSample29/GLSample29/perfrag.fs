//#version 120

varying highp vec3 Position;
varying highp vec3 Normal;

uniform highp vec4 LightPosition;
uniform highp vec3 LightIntensity;

uniform highp vec3 Kd;            // Diffuse reflectivity
uniform highp vec3 Ka;            // Ambient reflectivity
uniform highp vec3 Ks;            // Specular reflectivity
uniform highp float Shininess;    // Specular shininess factor

highp vec3 ads( )
{
    highp vec3  s = normalize( vec3(LightPosition) - Position );
    highp vec3  v = normalize(vec3(-Position));
    highp vec3  r = reflect( -s, Normal );

    return
        LightIntensity * ( Ka +
          Kd * max( dot(s, Normal), 0.0 ) +
          Ks * pow( max( dot(r,v), 0.0 ), Shininess ) );
}

void main() {
    gl_FragColor = vec4(ads(), 1.0);
}
