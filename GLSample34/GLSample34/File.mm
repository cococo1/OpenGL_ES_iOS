//
//  File.cpp
//  GLSampe1
//
//  Created by Maxim Chetrusca on 5/11/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//

#include "File.h"

////position of the camera in spherical coordinates
//static glm::vec3 g_sphereCamRelPos(67.5f, -46.0f, 5.0f);
////the position our camera looks at
//static glm::vec3 g_camTarget(0.0f, 0.4f, 0.0f);

Open::Open()
{
//    linearFiltering = false;
//    perspectiveFOVY=60;

//    enableDepthClamping = false;
//    blendingType = 0;
//        NSLog(@"Open created");
 
}

Open::~Open(){}
//
//inline float DegToRad(float fAngDeg)
//{
//	const float fDegToRad = 3.14159f * 2.0f / 360.0f;
//	return fAngDeg * fDegToRad;
//}

void Open::init()
{

    
    if( ! prog.compileShaderFromFile("multitex.vs",GLSLShader::VERTEX) )
    {
        printf("Vertex shader failed to compile!\n%s",
               prog.log().c_str());
        exit(1);
    }
    if( ! prog.compileShaderFromFile("multitex.fs",GLSLShader::FRAGMENT))
    {
        printf("Fragment shader failed to compile!\n%s",
               prog.log().c_str());
        exit(1);
    }
    

    
    glBindAttribLocation(prog.getHandle(), 0, "VertexPosition");
    glBindAttribLocation(prog.getHandle(), 1, "VertexNormal");
    glBindAttribLocation(prog.getHandle(), 2, "VertexTexCoord");
//    
//    glBindAttribLocation(perVertProg.getHandle(), 0, "VertexPosition");
//    glBindAttribLocation(perVertProg.getHandle(), 1, "VertexNormal");

    if( ! prog.link() )
    {
        printf("Shader program failed to link!\n%s",
               prog.log().c_str());
        exit(1);
    }
    
    
    prog.use();
    
	glEnable(GL_DEPTH_TEST);
    
    cube = new VBOCube();
    
    view = glm::lookAt(vec3(1.0f,1.25f,1.25f), vec3(0.0f,0.0f,0.0f), vec3(0.0f,1.0f,0.0f));
    projection = mat4(1.0f);
    
    angle = 0.0;
    
    prog.setUniform("Light.Intensity", vec3(1.0f,1.0f,1.0f) );
    
    
    
    
    glActiveTexture(GL_TEXTURE0);
    // Load brick texture file
    char texName[32];
	strcpy(texName, "brick1.jpg");
    tex1.LoadFromFile(texName);
    
    glBindTexture(GL_TEXTURE_2D, tex1.GetTextureHandle());
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    prog.setUniform("BrickTex", 0);
    
    glActiveTexture(GL_TEXTURE1);
    
    // Load moss texture file
    strcpy(texName, "moss.png");
    tex2.LoadFromFile(texName);
    
	glBindTexture(GL_TEXTURE_2D,tex2.GetTextureHandle());
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    prog.setUniform("MossTex", 1);
    
//    glActiveTexture(GL_TEXTURE0);
//    GLKTextureInfo *spriteTexture;
//    NSError *theError;
//    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"brick1" ofType:@"jpg"]; // 1
//    if (!filePath)
//    {
//        NSLog(@"No file for texture.");
//    }
//    
//    spriteTexture = [GLKTextureLoader textureWithContentsOfFile:filePath options:nil error:&theError]; // 2
//    
//    if (spriteTexture == nil)
//        NSLog(@"Error loading texture: %@", [theError localizedDescription]);
//   
//    textureHandle = spriteTexture.name;
//    glTexParameteri(textureHandle, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
//	glTexParameteri(textureHandle, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
//	glTexParameteri(textureHandle, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
//	glTexParameteri(textureHandle, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
//
//    glBindTexture(spriteTexture.target, spriteTexture.name); // 3
//    glEnable(spriteTexture.target); // 4
//    
//    
//    
//    
//
////	glBindTexture(0, textureHandle);
//
//	prog.setUniform("Tex1", 0);

}


void Open:: update(int dt)
{
	angle += 0.15f;
}

void Open::setMatrices()
{
    mat4 mv = view * model;
    prog.setUniform("ModelViewMatrix", mv);
    prog.setUniform("NormalMatrix",
                     mat3( vec3(mv[0]), vec3(mv[1]), vec3(mv[2]) ));
    prog.setUniform("MVP", projection * mv);
}

void Open::render(float elapsedTime)
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    prog.setUniform("Light.Position", vec4(0.0f,0.0f,0.0f,1.0f) );
    prog.setUniform("Material.Kd", 0.9f, 0.9f, 0.9f);
    prog.setUniform("Material.Ks", 0.95f, 0.95f, 0.95f);
    prog.setUniform("Material.Ka", 0.1f, 0.1f, 0.1f);
    prog.setUniform("Material.Shininess", 100.0f);
    
    model = mat4(1.0f);
	model *= glm::rotate(angle, vec3(0.0f,1.0f,0.0f));
    model *= glm::rotate(angle, vec3(1.0f,0.0f,0.0f));
    model *= glm::rotate(angle, vec3(0.0f,0.0f,1.0f));
    setMatrices();
    cube->render();
	

}

void Open::keyboard(unsigned char key, int x, int y)
{
//    
//	if(key==' ')
//	{
////        NSLog(@"key!");
//		linearFiltering=!linearFiltering;
//        
//		if(linearFiltering)
//		{
//			glTexParameteri(textureHandle, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
//			glTexParameteri(textureHandle, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
//		}
//		else
//		{
//			glTexParameteri(textureHandle, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
//			glTexParameteri(textureHandle, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
//		}
//	}
//    
//	if(key=='w' || key=='W')
//	{
//        NSLog(@"asda");
//		perspectiveFOVY-=1.0f;
//		projection = glm::perspective(perspectiveFOVY, (float)width/height, 0.3f, 100.0f);
//	}
//	if(key=='s' || key=='S')
//	{
//		perspectiveFOVY+=1.0f;
//		projection = glm::perspective(perspectiveFOVY, (float)width/height, 0.3f, 100.0f);
//	}
    
    

}


void Open:: reshape(int w, int h)
{
    projection = glm::perspective(60.0f, (float)w/h, 0.3f, 100.0f);
//    width=w;
//	height=h;
    
    

}

//void special (int key, int x, int y)
//{
//    
//    if(key == GLUT_KEY_UP)
//        anglex+=5.0f;
//    
//    if(key == GLUT_KEY_DOWN)
//        anglex-=5.0f;
//    
//    if(key == GLUT_KEY_LEFT)
//        anglez+=5.0f;
//    
//    if(key == GLUT_KEY_RIGHT)
//        anglez-=5.0f;
//    
//    
//    glutPostRedisplay ();
//}

