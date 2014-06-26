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

    
    if( ! prog.compileShaderFromFile("multilight.vert",GLSLShader::VERTEX) )
    {
        printf("Vertex shader failed to compile!\n%s",
               prog.log().c_str());
        exit(1);
    }
    if( ! prog.compileShaderFromFile("multilight.frag",GLSLShader::FRAGMENT))
    {
        printf("Fragment shader failed to compile!\n%s",
               prog.log().c_str());
        exit(1);
    }
    
    glBindAttribLocation(prog.getHandle(), 0, "VertexPosition");
    glBindAttribLocation(prog.getHandle(), 1, "VertexNormal");
//    glBindAttribLocation(prog.getHandle(), 2, "VertexTexCoord");

    if( ! prog.link() )
    {
        printf("Shader program failed to link!\n%s",
               prog.log().c_str());
        exit(1);
    }
    
    prog.use();
	glEnable(GL_DEPTH_TEST);
    
    plane = new VBOPlane(10.0f, 10.0f, 100, 100);
    mesh = new VBOMesh("pig_triangulated.obj",true);
    
    // model *= glm::rotate(35.0f, vec3(0.0f,1.0f,0.0f));
    view = glm::lookAt(vec3(0.5f,0.75f,0.75f), vec3(0.0f,0.0f,0.0f), vec3(0.0f,1.0f,0.0f));
    projection = mat4(1.0f);
    
    prog.setUniform("lights[0].Intensity", vec3(0.0f,0.8f,0.8f) );
    prog.setUniform("lights[1].Intensity", vec3(0.0f,0.0f,0.8f) );
    prog.setUniform("lights[2].Intensity", vec3(0.8f,0.0f,0.0f) );
    prog.setUniform("lights[3].Intensity", vec3(0.0f,0.8f,0.0f) );
    prog.setUniform("lights[4].Intensity", vec3(0.8f,0.8f,0.8f) );
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

    
	static float ang=0; ang+=0.1f;

    
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	char name[20];
    float x, z;
    for( int i = 0; i < 5; i++ ) {
        sprintf(name,"lights[%d].Position", i);
//        NSLog(@"%s",name);
        x = 2.0 * cos((TWOPI / 5) * i * ang);
        z = 2.0 * sin((TWOPI / 5) * i * ang);
//        NSLog(@"%f %f",x,z);
        prog.setUniform(name, view * vec4(x, 1.2f, z + 1.0f, 1.0f) );
    }
    
    prog.setUniform("Kd", 0.4f, 0.4f, 0.4f);
    prog.setUniform("Ks", 0.9f, 0.9f, 0.9f);
    prog.setUniform("Ka", 0.1f, 0.1f, 0.1f);
    prog.setUniform("Shininess", 180.0f);
    
    model = mat4(1.0f);
    model *= glm::rotate(90.0f, vec3(0.0f,1.0f,0.0f));
    setMatrices();
    mesh->render();
    
    prog.setUniform("Kd", 0.1f, 0.1f, 0.1f);
    prog.setUniform("Ks", 0.9f, 0.9f, 0.9f);
    prog.setUniform("Ka", 0.1f, 0.1f, 0.1f);
    prog.setUniform("Shininess", 180.0f);
    
    model = mat4(1.0f);
    model *= glm::translate(vec3(0.0f,-0.45f,0.0f));
    setMatrices();
    plane->render();
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
    projection = glm::perspective(70.0f, (float)w/h, 0.3f, 100.0f);
    
    

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

