////
////  Shader.vsh
////  GL_Bullet_test
////
////  Created by Maxim Chetrusca on 5/5/13.
////  Copyright (c) 2013 Magicindie. All rights reserved.
////
//
//attribute vec4 VertexPosition;
//attribute vec3 VertexNormal;
//
//varying lowp vec4 colorVarying;
//
//uniform mat4 MVP;
//uniform mat3 NormalMatrix;
//
//void main()
//{
//    vec3 Normal = normalize(NormalMatrix * VertexNormal);
//    vec3 lightPosition = vec3(0.0, 0.0, 1.0);
//    vec4 diffuseColor = vec4(0.4, 0.4, 1.0, 1.0);
//    
//    float nDotVP = max(0.0, dot(Normal, normalize(lightPosition)));
//                 
//    colorVarying = diffuseColor * nDotVP;
//    
//    gl_Position = MVP * VertexPosition;
//}

//#version 120

attribute vec3 VertexPosition;
attribute vec3 VertexNormal;
//attribute vec2 VertexTexCoord;


varying lowp vec3 Position;
varying lowp vec3 Normal;
//varying vec2 TexCoord;

uniform mat4 ModelViewMatrix;
uniform mat3 NormalMatrix;
uniform mat4 ProjectionMatrix;
uniform mat4 MVP;

void main()
{
//    TexCoord = VertexTexCoord;
    Normal = normalize( NormalMatrix * VertexNormal);
    Position = vec3( ModelViewMatrix * vec4(VertexPosition,1.0) );
    
    gl_Position = MVP * vec4(VertexPosition,1.0);
}



