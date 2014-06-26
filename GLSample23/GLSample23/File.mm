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
    
    if( ! prog.compileShaderFromFile("twoside.vert",GLSLShader::VERTEX) )
    {
        printf("Vertex shader failed to compile!\n%s",
               prog.log().c_str());
        exit(1);
    }
    if( ! prog.compileShaderFromFile("twoside.frag",GLSLShader::FRAGMENT))
    {
        printf("Fragment shader failed to compile!\n%s",
               prog.log().c_str());
        exit(1);
    }
    
    glBindAttribLocation(prog.getHandle(), 0, "VertexPosition");
    glBindAttribLocation(prog.getHandle(), 1, "VertexNormal");
    if( ! prog.link() )
    {
        printf("Shader program failed to link!\n%s",
               prog.log().c_str());
        exit(1);
    }
    
    prog.use();

	glClearColor(0.0,0.0,0.0,1.0);
    glEnable(GL_DEPTH_TEST);
    
    mat4 transform = glm::translate(mat4(1.0f),vec3(0.0f,1.5f,0.25f));
    teapot = new VBOTeapot(13, transform);
    
    view = glm::lookAt(vec3(2.0f,4.0f,2.0f), vec3(0.0f,0.0f,0.0f), vec3(0.0f,1.0f,0.0f));
    projection = mat4(1.0f);
    
    prog.setUniform("Material.Kd", 0.9f, 0.5f, 0.3f);
    prog.setUniform("Light.Ld", 1.0f, 1.0f, 1.0f);
    prog.setUniform("Material.Ka", 0.9f, 0.5f, 0.3f);
    prog.setUniform("Light.La", 0.4f, 0.4f, 0.4f);
    prog.setUniform("Material.Ks", 0.8f, 0.8f, 0.8f);
    prog.setUniform("Light.Ls", 1.0f, 1.0f, 1.0f);
    prog.setUniform("Material.Shininess", 100.0f);
}
////used to calculate the camera position based on our spherical coordinates
//glm::vec3 ResolveCamPosition()
//{
//	float phi = DegToRad(g_sphereCamRelPos.x);
//	float theta = DegToRad(g_sphereCamRelPos.y + 90.0f);
//    
//	float fSinTheta = sinf(theta);
//	float fCosTheta = cosf(theta);
//	float fCosPhi = cosf(phi);
//	float fSinPhi = sinf(phi);
//    
//	glm::vec3 dirToCamera(fSinTheta * fCosPhi, fCosTheta, fSinTheta * fSinPhi);
//	return (dirToCamera * g_sphereCamRelPos.z) + g_camTarget;
//}
//
//void Open:: setMatrices()
//{
//	const glm::vec3 &camPos = ResolveCamPosition();
//	worldToCameraMatrix = glm::lookAt(camPos, g_camTarget, glm::vec3(0.0f, 1.0f, 0.0f));
//    prog.setUniform("modelToWorldMatrix", modelToWorldMatrix);
//	prog.setUniform("worldToCameraMatrix", worldToCameraMatrix);
//	prog.setUniform("cameraToClipMatrix", cameraToClipMatrix);
//}
//


void Open:: update(int dt)
{
    //	glutTimerFunc(1,update,0);
    //	glutPostRedisplay();
}

void Open::render(float elapsedTime)
{

//    NSLog(@"%f",elapsedTime);
    
//	float fXOffset = 0.0f, fYOffset = 0.0f;
//    ComputePositionOffsets(fXOffset, fYOffset,elapsedTime);
//    AdjustVertexData(fXOffset, fYOffset);
    
	glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClearDepthf(1.0);
//    glClearDepth(1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    
	static float angle=0;
	angle+= 0.1f;
    if( angle > 360.0 ) angle -= 360.0;
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    
    vec4 worldLight = vec4(2.0f,4.0f,2.0f,1.0f);
    model = glm::rotate(angle, vec3(0.0f,1.0f,0.0f));
    prog.setUniform("Light.Position", view * model * worldLight );
    
    model = mat4(1.0f);
    model *= glm::translate(vec3(0.0,-1.0,0.0));
    model *= glm::rotate(-90.0f, vec3(1.0f,0.0f,0.0f));
	model *= glm::rotate(anglex, vec3(1.0f,0.0f,0.0f));
	model *= glm::rotate(anglez, vec3(0.0f,0.0f,1.0f));
    //model *= glm::rotate(140.0f, vec3(0.0f,1.0f,0.0f));
    
    
    mat4 mv = view * model;
    prog.setUniform("ModelViewMatrix", mv);
    prog.setUniform("NormalMatrix",
                    mat3( vec3(mv[0]), vec3(mv[1]), vec3(mv[2]) ));
    prog.setUniform("MVP", projection * mv);
    
    teapot->render();
}

void Open::keyboard(unsigned char key, int x, int y)
{
    anglex+=5.0f;

    if(key == 's')
        anglex-=5.0f;

    if(key == 'a')
        anglez+=5.0f;

    if(key == 'd')
        anglez-=5.0f;
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

