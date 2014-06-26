//#version 120

varying highp vec3 Position;
varying highp vec3 Normal;
varying highp vec2 TexCoord;

uniform sampler2D BrickTex;
uniform sampler2D MossTex;

struct LightInfo {
  highp vec4 Position;  // Light position in eye coords.
  highp vec3 Intensity; // A,D,S intensity
};
uniform LightInfo Light;

struct MaterialInfo {
  highp vec3 Ka;            // Ambient reflectivity
  highp vec3 Kd;            // Diffuse reflectivity
  highp vec3 Ks;            // Specular reflectivity
  highp float Shininess;    // Specular shininess factor
};
uniform MaterialInfo Material;

void phongModel( highp vec3 pos, highp vec3 norm, out highp vec3 ambAndDiff, out highp vec3 spec ) {
    highp vec3 s = normalize(vec3(Light.Position) - pos);
   highp vec3 v = normalize(-pos.xyz);
   highp vec3 r = reflect( -s, norm );
   highp vec3 ambient = Light.Intensity * Material.Ka;
   highp float sDotN = max( dot(s,norm), 0.0 );
   highp vec3 diffuse = Light.Intensity * Material.Kd * sDotN;
    spec = vec3(0.0);
    if( sDotN > 0.0 )
        spec = Light.Intensity * Material.Ks *
               pow( max( dot(r,v), 0.0 ), Material.Shininess );
    ambAndDiff = ambient + diffuse;
}


void main() {
   highp vec3 ambAndDiff, spec;
   highp vec4 brickTexColor = texture2D( BrickTex, TexCoord );
   highp vec4 mossTexColor = texture2D( MossTex, TexCoord );
    phongModel(Position, Normal, ambAndDiff, spec );
     highp vec4 texColor = mix(brickTexColor, mossTexColor, mossTexColor.a);
    gl_FragColor = vec4(ambAndDiff, 1.0 ) * texColor + vec4(spec,1);
}
