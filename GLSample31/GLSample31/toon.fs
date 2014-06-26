//#version 120

varying highp vec3 Position;
varying highp vec3 Normal;

struct LightInfo {
    highp vec4  position;
    highp vec3  intensity;
};
uniform LightInfo Light;

uniform highp vec3 Kd;            // Diffuse reflectivity
uniform highp vec3 Ka;            // Ambient reflectivity

const highp float levels = 3.0;
const highp float scaleFactor = 1.0 / levels;

highp vec3 toonShade( )
{
    highp vec3 s = normalize( Light.position.xyz - Position.xyz );
    highp vec3 ambient = Ka;
    highp float cosine = dot( s, Normal );
    highp vec3 diffuse = Kd * floor( cosine * levels ) * scaleFactor;

    return Light.intensity * (ambient + diffuse);
}

void main() {
    gl_FragColor = vec4(toonShade(), 1.0);
}
