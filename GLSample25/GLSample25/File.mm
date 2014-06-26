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

    
    if( ! prog.compileShaderFromFile("discard.vert",GLSLShader::VERTEX) )
    {
        printf("Vertex shader failed to compile!\n%s",
               prog.log().c_str());
        exit(1);
    }
    if( ! prog.compileShaderFromFile("discard.frag",GLSLShader::FRAGMENT))
    {
        printf("Fragment shader failed to compile!\n%s",
               prog.log().c_str());
        exit(1);
    }
    
    glBindAttribLocation(prog.getHandle(), 0, "VertexPosition");
    glBindAttribLocation(prog.getHandle(), 1, "VertexNormal");
    glBindAttribLocation(prog.getHandle(), 2, "VertexTexCoord");

    if( ! prog.link() )
    {
        printf("Shader program failed to link!\n%s",
               prog.log().c_str());
        exit(1);
    }
    
    prog.use();

	glClearColor(0.0,0.0,0.25f,1.0);
    
    glEnable(GL_DEPTH_TEST);
    
    teapot = new VBOTeapot(13, mat4(1.0f));
    

    
    view = glm::lookAt(vec3(0.0f,0.0f,7.0f), vec3(0.0f,0.0f,0.0f), vec3(0.0f,1.0f,0.0f));
    
    projection = mat4(1.0f);
    
    prog.setUniform("Material.Kd", 0.9f, 0.5f, 0.3f);
    prog.setUniform("Light.Ld", 1.0f, 1.0f, 1.0f);
    prog.setUniform("Material.Ka", 0.9f, 0.5f, 0.3f);
    prog.setUniform("Light.La", 0.4f, 0.4f, 0.4f);
    prog.setUniform("Material.Ks", 0.8f, 0.8f, 0.8f);
    prog.setUniform("Light.Ls", 1.0f, 1.0f, 1.0f);
    
    prog.setUniform("Material.Shininess", 100.0f);
}


void Open:: update(int dt)
{
    //	glutTimerFunc(1,update,0);
    //	glutPostRedisplay();
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

    
	static float angle=0;
	angle+=0.025f;
    
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    vec4 lightPos = vec4(0.0f,0.0f,0.0f,1.0f);
    prog.setUniform("Light.Position", lightPos );
    
    model = mat4(1.0f);
    model *= glm::translate(vec3(0.0,-1.5,0.0));
    model *= glm::rotate(-90.0f, vec3(1.0f,0.0f,0.0f));
	model *= glm::rotate(angle, vec3(0.0f,0.0f,1.0f));
	model *= glm::rotate(angle, vec3(0.0f,1.0f,0.0f));
	model *= glm::rotate(angle, vec3(1.0f,0.0f,0.0f));
    setMatrices();
    teapot->render();
}

//void Open::keyboard(unsigned char key, int x, int y)
//{
//    if(key == 'w')
//        scale+=0.25f;
//    
//    if(key == 's')
//        scale-=0.25f;
//}


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

