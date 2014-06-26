//#version 120

varying highp vec3 Position;
varying highp vec3 Normal;

struct LightInfo {
    highp vec4 position;
    highp vec3 intensity;
};
uniform LightInfo Light;

struct FogInfo {
  highp float maxDist;
  highp float minDist;
  highp vec3 color;
};
uniform FogInfo Fog;

uniform highp vec3 Kd;            // Diffuse reflectivity
uniform highp  vec3 Ka;            // Ambient reflectivity
uniform highp vec3 Ks;            // Specular reflectivity
uniform highp float Shininess;    // Specular shininess factor

highp vec3 ads( )
{
    highp vec3 s = normalize( Light.position.xyz - Position.xyz );
    highp vec3 v = normalize(vec3(-Position));
    highp vec3 h = normalize( v + s );

    highp vec3 ambient = Ka;
    highp vec3 diffuse = Kd * max(0.0, dot(s, Normal) );
    highp vec3 spec = Ks * pow( max( 0.0, dot( h, Normal) ), Shininess );

    return Light.intensity * (ambient + diffuse + spec);
}

void main() {
   highp float dist = abs( Position.z );
   highp float fogFactor = (Fog.maxDist - dist) /
                      (Fog.maxDist - Fog.minDist);
    fogFactor = clamp( fogFactor, 0.0, 1.0 );
   highp vec3 shadeColor = ads();
   highp vec3 color = mix( Fog.color, shadeColor, fogFactor );

    gl_FragColor = vec4(color, 1.0);
}
