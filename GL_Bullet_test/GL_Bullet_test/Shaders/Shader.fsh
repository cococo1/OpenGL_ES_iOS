//
//  Shader.fsh
//  GL_Bullet_test
//
//  Created by Maxim Chetrusca on 5/5/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//
//
//varying lowp vec4 colorVarying;
//
//void main()
//{
//    gl_FragColor = colorVarying;
//}

//#version 120

varying lowp vec3 Position;
varying lowp vec3 Normal;


//varying vec2 TexCoord;

//uniform sampler2D Tex1;



struct LightInfo {
     lowp vec4 Position;  // Light position in eye coords.
     lowp vec3 Intensity; // A,D,S intensity
};
uniform LightInfo Light;

struct MaterialInfo {
      lowp vec3 Ka;            // Ambient reflectivity
      lowp vec3 Kd;            // Diffuse reflectivity
      lowp vec3 Ks;            // Specular reflectivity
      lowp float Shininess;    // Specular shininess factor
};
uniform MaterialInfo Material;
//
void phongModel(  lowp vec3 pos, lowp vec3 norm, out lowp vec3 ambAndDiff, out lowp vec3 spec ) {
     lowp vec3 s = normalize(vec3(Light.Position) - pos);
     lowp vec3 v = normalize(-pos.xyz);
     lowp vec3 r = reflect( -s, norm );
     lowp vec3 ambient = Light.Intensity * Material.Ka;
     lowp float sDotN = max( dot(s,norm), 0.0 );
     lowp vec3 diffuse = Light.Intensity * Material.Kd * sDotN;
     spec = vec3(0.0);
    if( sDotN > 0.0 )
    spec = Light.Intensity * Material.Ks *
    pow( max( dot(r,v), 0.0 ), Material.Shininess );
    ambAndDiff = ambient + diffuse;
}

void main() {
    
    lowp vec3 ambAndDiff, spec;
    //    vec4 texColor = texture( Tex1, TexCoord );
    phongModel( Position, Normal, ambAndDiff, spec );
    gl_FragColor = vec4( ambAndDiff, 1.0 ) + vec4(spec,1.0);
    //    gl_FragColor = (vec4( ambAndDiff, 1.0 ) * texColor) + vec4(spec,1.0);
    
}