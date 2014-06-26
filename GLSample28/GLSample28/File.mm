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
    perFragmentLighting = true;
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

    
    if( ! perFragProg.compileShaderFromFile("perfrag.vs",GLSLShader::VERTEX) )
    {
        printf("Vertex shader failed to compile!\n%s",
               perFragProg.log().c_str());
        exit(1);
    }
    if( ! perFragProg.compileShaderFromFile("perfrag.fs",GLSLShader::FRAGMENT))
    {
        printf("Fragment shader failed to compile!\n%s",
               perFragProg.log().c_str());
        exit(1);
    }
    
    if( ! perVertProg.compileShaderFromFile("pervert.vs",GLSLShader::VERTEX) )
    {
        printf("Vertex shader failed to compile!\n%s",
               perVertProg.log().c_str());
        exit(1);
    }
    if( ! perVertProg.compileShaderFromFile("pervert.fs",GLSLShader::FRAGMENT))
    {
        printf("Fragment shader failed to compile!\n%s",
               perVertProg.log().c_str());
        exit(1);
    }
    
    glBindAttribLocation(perFragProg.getHandle(), 0, "VertexPosition");
    glBindAttribLocation(perFragProg.getHandle(), 1, "VertexNormal");
    
    glBindAttribLocation(perVertProg.getHandle(), 0, "VertexPosition");
    glBindAttribLocation(perVertProg.getHandle(), 1, "VertexNormal");

    if( ! perFragProg.link() )
    {
        printf("Shader program failed to link!\n%s",
               perFragProg.log().c_str());
        exit(1);
    }
    if( ! perVertProg.link() )
    {
        printf("Shader program failed to link!\n%s",
               perVertProg.log().c_str());
        exit(1);
    }
	perVertProg.use();
	perVertProg.setUniform("LightIntensity", vec3(0.9f,0.9f,0.9f) );
    
	perFragProg.use();
	perFragProg.setUniform("LightIntensity", vec3(0.9f,0.9f,0.9f) );
    
	glEnable(GL_DEPTH_TEST);
    
    plane = new VBOPlane(50.0f, 50.0f, 1, 1);
    teapot = new VBOTeapot(14, glm::mat4(1.0f));
    
    view = glm::lookAt(vec3(0.0f,3.0f,5.0f), vec3(0.0f,0.75f,0.0f), vec3(0.0f,1.0f,0.0f));
    projection = mat4(1.0f);
    
    angle = 0.957283;

    
    
}


void Open:: update(int dt)
{
	angle += 0.003f;
    if( angle > TWOPI) angle -= TWOPI;

}

void Open::setMatrices()
{
	if(perFragmentLighting)
	{
		mat4 mv = view * model;
		perFragProg.use();
		perFragProg.setUniform("ModelViewMatrix", mv);
		perFragProg.setUniform("NormalMatrix",
                               mat3( vec3(mv[0]), vec3(mv[1]), vec3(mv[2]) ));
		perFragProg.setUniform("MVP", projection * mv);
	}
	else
	{
		mat4 mv = view * model;
		perVertProg.use();
		perVertProg.setUniform("ModelViewMatrix", mv);
		perVertProg.setUniform("NormalMatrix",
                               mat3( vec3(mv[0]), vec3(mv[1]), vec3(mv[2]) ));
		perVertProg.setUniform("MVP", projection * mv);
	}
}

void Open::render(float elapsedTime)
{
    
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
	if(perFragmentLighting)
	{
		perFragProg.setUniform("LightPosition", view * vec4(10.0f * cos(angle), 3.0f, 10.0f * sin(angle), 1.0f) );
		perFragProg.setUniform("Kd", 0.9f, 0.5f, 0.3f);
		perFragProg.setUniform("Ks", 0.95f, 0.95f, 0.95f);
		perFragProg.setUniform("Ka", 0.1f, 0.1f, 0.1f);
		perFragProg.setUniform("Shininess", 100.0f);
	}
	else
	{
		perVertProg.setUniform("LightPosition", view * vec4(10.0f * cos(angle), 3.0f, 10.0f * sin(angle), 1.0f) );
		perVertProg.setUniform("Kd", 0.9f, 0.5f, 0.3f);
		perVertProg.setUniform("Ks", 0.95f, 0.95f, 0.95f);
		perVertProg.setUniform("Ka", 0.1f, 0.1f, 0.1f);
		perVertProg.setUniform("Shininess", 100.0f);
	}
    
    model = mat4(1.0f);
    model *= glm::translate(vec3(0.0f,0.0f,0.0f));
    model *= glm::rotate(-90.0f, vec3(1.0f,0.0f,0.0f));
    setMatrices();
    teapot->render();
    
	if(perFragmentLighting)
	{
		perFragProg.setUniform("Kd", 0.7f, 0.7f, 0.7f);
		perFragProg.setUniform("Ks", 0.9f, 0.9f, 0.9f);
		perFragProg.setUniform("Ka", 0.1f, 0.1f, 0.1f);
		perFragProg.setUniform("Shininess", 180.0f);
	}
	else
	{
		perVertProg.setUniform("Kd", 0.7f, 0.7f, 0.7f);
		perVertProg.setUniform("Ks", 0.9f, 0.9f, 0.9f);
		perVertProg.setUniform("Ka", 0.1f, 0.1f, 0.1f);
		perVertProg.setUniform("Shininess", 180.0f);
	}
    
    model = mat4(1.0f);
    model *= glm::translate(vec3(0.0f,-0.45f,0.0f));
    setMatrices();
    plane->render();
    

}

void Open::keyboard(unsigned char key, int x, int y)
{
	if(key==32)
	{
		perFragmentLighting=!perFragmentLighting;
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

