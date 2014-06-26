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
    useHalfwayShader = false;
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

    
    if( ! prog1.compileShaderFromFile("perfrag.vs",GLSLShader::VERTEX) )
    {
        printf("Vertex shader failed to compile!\n%s",
               prog1.log().c_str());
        exit(1);
    }
    if( ! prog1.compileShaderFromFile("perfrag.fs",GLSLShader::FRAGMENT))
    {
        printf("Fragment shader failed to compile!\n%s",
               prog1.log().c_str());
        exit(1);
    }
    
//    if( ! prog1.compileShaderFromFile("pervert.vs",GLSLShader::VERTEX) )
//    {
//        printf("Vertex shader failed to compile!\n%s",
//               prog1.log().c_str());
//        exit(1);
//    }
//    if( ! prog1.compileShaderFromFile("pervert.fs",GLSLShader::FRAGMENT))
//    {
//        printf("Fragment shader failed to compile!\n%s",
//               prog1.log().c_str());
//        exit(1);
//    }
    
    glBindAttribLocation(prog1.getHandle(), 0, "VertexPosition");
    glBindAttribLocation(prog1.getHandle(), 1, "VertexNormal");
//    
//    glBindAttribLocation(perVertProg.getHandle(), 0, "VertexPosition");
//    glBindAttribLocation(perVertProg.getHandle(), 1, "VertexNormal");

    if( ! prog1.link() )
    {
        printf("Shader program failed to link!\n%s",
               prog1.log().c_str());
        exit(1);
    }
    
    
    
    
    if( ! prog2.compileShaderFromFile("halfway.vs",GLSLShader::VERTEX) )
    {
        printf("Vertex shader failed to compile!\n%s",
               prog2.log().c_str());
        exit(1);
    }
    if( ! prog2.compileShaderFromFile("halfway.fs",GLSLShader::FRAGMENT))
    {
        printf("Fragment shader failed to compile!\n%s",
               prog2.log().c_str());
        exit(1);
    }
    
    glBindAttribLocation(prog2.getHandle(), 0, "VertexPosition");
    glBindAttribLocation(prog2.getHandle(), 1, "VertexNormal");
    
    if( ! prog2.link() )
    {
        printf("Shader program failed to link!\n%s",
               prog2.log().c_str());
        exit(1);
    }
	prog1.use();
    glEnable(GL_DEPTH_TEST);
    
    plane = new VBOPlane(50.0f, 50.0f, 1, 1);
    teapot = new VBOTeapot(14, glm::mat4(1.0f));
    
    view = glm::lookAt(vec3(0.0f,3.0f,5.0f), vec3(0.0f,0.75f,0.0f), vec3(0.0f,1.0f,0.0f));
    projection = mat4(1.0f);
    
    angle = 0.957283f;
    
    prog1.setUniform("LightIntensity", vec3(0.9f,0.9f,0.9f) );
}


void Open:: update(int dt)
{
	angle += 0.001f;
    if( angle > TWOPI) angle -= TWOPI;

}

void Open::setMatrices()
{
    mat4 mv = view * model;
    prog1.setUniform("ModelViewMatrix", mv);
    prog1.setUniform("NormalMatrix",
                     mat3( vec3(mv[0]), vec3(mv[1]), vec3(mv[2]) ));
    prog1.setUniform("MVP", projection * mv);
}

void Open::render(float elapsedTime)
{
  	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
	prog1.setUniform("LightPosition", view * vec4(10.0f * cos(angle), 3.0f, 10.0f * sin(angle), 1.0f) );
	prog1.setUniform("Kd", 0.9f, 0.5f, 0.3f);
	prog1.setUniform("Ks", 0.95f, 0.95f, 0.95f);
	prog1.setUniform("Ka", 0.1f, 0.1f, 0.1f);
	prog1.setUniform("Shininess", 100.0f);
    
	model = mat4(1.0f);
	model *= glm::translate(vec3(0.0f,0.0f,0.0f));
	model *= glm::rotate(-90.0f, vec3(1.0f,0.0f,0.0f));
	setMatrices();
	teapot->render();
    
	prog1.setUniform("Kd", 0.7f, 0.7f, 0.7f);
	prog1.setUniform("Ks", 0.9f, 0.9f, 0.9f);
	prog1.setUniform("Ka", 0.1f, 0.1f, 0.1f);
	prog1.setUniform("Shininess", 180.0f);
    
	model = mat4(1.0f);
	model *= glm::translate(vec3(0.0f,-0.45f,0.0f));
	setMatrices();
	plane->render();
	
    
    

}

void Open::keyboard(unsigned char key, int x, int y)
{
	if(key==32)
	{
		useHalfwayShader=!useHalfwayShader;
		if(useHalfwayShader)
		{
			prog2.use();
		}
		else
		{
			prog1.use();
		}
		
		prog2.setUniform("LightIntensity", vec3(0.9f,0.9f,0.9f) );
        
	}
}


void Open:: reshape(int w, int h)
{
    projection = glm::perspective(60.0f, (float)w/h, 0.3f, 100.0f);
    
    

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

