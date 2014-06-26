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

//inline float DegToRad(float fAngDeg)
//{
//	const float fDegToRad = 3.14159f * 2.0f / 360.0f;
//	return fAngDeg * fDegToRad;
//}

void Open::init()
{
    
    if( ! prog.compileShaderFromFile("diffuse.vert",GLSLShader::VERTEX) )
    {
        printf("Vertex shader failed to compile!\n%s",
               prog.log().c_str());
        exit(1);
    }
    if( ! prog.compileShaderFromFile("diffuse.frag",GLSLShader::FRAGMENT))
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
    
    torus = new VBOTorus(0.7f, 0.3f, 30, 30);
    
    model = mat4(1.0f);
    model *= glm::rotate(-35.0f, vec3(1.0f,0.0f,0.0f));
    model *= glm::rotate(35.0f, vec3(0.0f,1.0f,0.0f));
    view = glm::lookAt(vec3(0.0f,0.0f,2.0f), vec3(0.0f,0.0f,0.0f), vec3(0.0f,1.0f,0.0f));
    projection = mat4(1.0f);
    
    prog.setUniform("Kd", 1.0f, 0.0f, 0.0f);
    prog.setUniform("Ld", 1.0f, 1.0f, 1.0f);
    prog.setUniform("LightPosition", view * vec4(5.0f,5.0f,2.0f,1.0f) );

}
//used to calculate the camera position based on our spherical coordinates
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

//void Open:: setMatrices()
//{
//	const glm::vec3 &camPos = ResolveCamPosition();
//	worldToCameraMatrix = glm::lookAt(camPos, g_camTarget, glm::vec3(0.0f, 1.0f, 0.0f));
//    prog.setUniform("modelToWorldMatrix", modelToWorldMatrix);
//	prog.setUniform("worldToCameraMatrix", worldToCameraMatrix);
//	prog.setUniform("cameraToClipMatrix", cameraToClipMatrix);
//}


void Open::render(float elapsedTime)
{

//    NSLog(@"%f",elapsedTime);
    
//	float fXOffset = 0.0f, fYOffset = 0.0f;
//    ComputePositionOffsets(fXOffset, fYOffset,elapsedTime);
//    AdjustVertexData(fXOffset, fYOffset);
    
    static float angle=0;
	angle+=0.1f;
    
	glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClearDepthf(1.0);
//    glClearDepth(1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    mat4 mv = view * model;
    prog.setUniform("ModelViewMatrix", mv);
    prog.setUniform("NormalMatrix",
                    mat3( vec3(mv[0]), vec3(mv[1]), vec3(mv[2]) ));
    prog.setUniform("MVP", projection * mv);
    
    torus->render();
}


void Open:: reshape(int w, int h)
{
    projection = glm::perspective(60.0f, (float)w/h, 0.3f, 100.0f);
    
    
}

void Open::keyboard(unsigned char key, int x, int y)
{

}

void Open:: update(int dt)
{
//	glutTimerFunc(1,update,0);
//	glutPostRedisplay();
}

