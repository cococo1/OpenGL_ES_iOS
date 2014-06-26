//#version 120

varying highp vec3 Position;
varying highp vec3 Normal;

struct SpotLightInfo {
    highp vec4  position;   // Position in eye coords
    highp vec3  intensity;
    highp vec3  direction;  // Direction of the spotlight in eye coords.
    highp float exponent;  // Angular attenuation exponent
    highp float cutoff;    // Cutoff angle (between 0 and 90)
};
uniform SpotLightInfo Spot;

uniform highp vec3 Kd;            // Diffuse reflectivity
uniform highp vec3 Ka;            // Ambient reflectivity
uniform highp vec3 Ks;            // Specular reflectivity
uniform highp float Shininess;    // Specular shininess factor

//layout( location = 0 ) out highp vec4 FragColor;

highp vec3 adsWithSpotlight( )
{
   highp vec3 s = normalize( vec3( Spot.position) - Position );
   highp vec3 spotDir = normalize( Spot.direction);
   highp float angle = acos( dot(-s, spotDir) );
   highp float cutoff = radians( clamp( Spot.cutoff, 0.0, 90.0 ) );
   highp vec3 ambient = Spot.intensity * Ka;

    if( angle < cutoff ) {
        highp float spotFactor = pow( dot(-s, spotDir), Spot.exponent );
       highp vec3 v = normalize(vec3(-Position));
       highp vec3 h = normalize( v + s );

        return
            ambient +
            spotFactor * Spot.intensity * (
              Kd * max( dot(s, Normal), 0.0 ) +
              Ks * pow( max( dot(h,Normal), 0.0 ), Shininess )
           );
    } else {
        return ambient;
    }
}

void main() {
    gl_FragColor = vec4(adsWithSpotlight(), 1.0);
}
