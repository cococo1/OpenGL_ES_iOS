//
//  File.cpp
//  GLSampe1
//
//  Created by Maxim Chetrusca on 5/11/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//

#include "File.h"

//position of the camera in spherical coordinates
//static glm::vec3 g_sphereCamRelPos(67.5f, -46.0f, 5.0f);
////the position our camera looks at
//static glm::vec3 g_camTarget(0.0f, 0.4f, 0.0f);
//
//float angY=0,angX=0,angZ=0;
//glm::mat4 xRotMatrix, yRotMatrix, zRotMatrix;
//GLuint cubeVertexBufferObject;
//GLuint gimbalVertexBufferObject;
//glm::mat4 modelToWorldMatrix;
//glm::mat4 worldToCameraMatrix;
//glm::mat4 cameraToClipMatrix;
//

//GLSLProgram prog;


Open::Open()
{
    g_orientation = glm::fquat(1.0f, 0.0f, 0.0f, 0.0f);

//    enableDepthClamping = false;
//    blendingType = 0;
//        NSLog(@"Open created");
 
}

Open::~Open(){}

inline float DegToRad(float fAngDeg)
{
	const float fDegToRad = 3.14159f * 2.0f / 360.0f;
	return fAngDeg * fDegToRad;
}



void Open::init()
{
    
    if( ! prog.compileShaderFromFile("main.vs",GLSLShader::VERTEX) )
    {
        printf("Vertex shader failed to compile!\n%s",
               prog.log().c_str());
        exit(1);
    }
    if( ! prog.compileShaderFromFile("main.fs",GLSLShader::FRAGMENT))
    {
        printf("Fragment shader failed to compile!\n%s",
               prog.log().c_str());
        exit(1);
    }
    
    glBindAttribLocation(prog.getHandle(), 0, "vertexPosition");
    glBindAttribLocation(prog.getHandle(), 1, "colorIn");


    if( ! prog.link() )
    {
        printf("Shader program failed to link!\n%s",
               prog.log().c_str());
        exit(1);
    }
    
    prog.use();
   	//created cube vertex buffer object
    glGenBuffers(1, &cubeVertexBufferObject);
    
	glBindBuffer(GL_ARRAY_BUFFER, cubeVertexBufferObject);
	glBufferData(GL_ARRAY_BUFFER, sizeof(cubeVertexData), cubeVertexData, GL_STREAM_DRAW);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
    
    
	//set the camera matrix
	worldToCameraMatrix = glm::lookAt(glm::vec3(0.3f,1.0f,1.7f),glm::vec3(0.0f, 0.0f, 0.0f), glm::vec3(0.0f, 1.0f, 0.0f));
    
	//reset the orientation matrix
	orientationMatrix=glm::mat4(1.0f);

    
    /* ----------------------------------------------------------------------------------------------------------------------*/
    /* ------------------------------------------------- OPENGL STATES INITIALIZATION-------- -------------------------------*/
    /* ----------------------------------------------------------------------------------------------------------------------*/
    
	//some general opengl initialization
    glEnable(GL_CULL_FACE);
	glFrontFace(GL_CW);
    glCullFace(GL_BACK);
    
	glEnable(GL_DEPTH_TEST);
	glDepthMask(GL_TRUE);
	glDepthFunc(GL_LEQUAL);
	glDepthRangef(0.0f, 1.0f);
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

void Open:: setMatrices()
{
//	const glm::vec3 &camPos = ResolveCamPosition();
//	worldToCameraMatrix = glm::lookAt(camPos, g_camTarget, glm::vec3(0.0f, 1.0f, 0.0f));
    prog.setUniform("modelToWorldMatrix", modelToWorldMatrix);
	prog.setUniform("worldToCameraMatrix", worldToCameraMatrix);
	prog.setUniform("cameraToClipMatrix", cameraToClipMatrix);
}

void Open:: drawcube1()
{
	prog.setUniform("fragModulationColor",glm::vec4(1,1,1,1));
	modelToWorldMatrix =orientationMatrix*glm::scale(glm::mat4(1.0f),glm::vec3(1,1,3));
	setMatrices();
	size_t colorData = sizeof(cubeVertexData) / 2;
	glBindBuffer(GL_ARRAY_BUFFER, cubeVertexBufferObject);
	glEnableVertexAttribArray(0);
	glEnableVertexAttribArray(1);
	glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, 0);
	glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, (void*)colorData);
	glDrawArrays(GL_TRIANGLES, 0, 36);
	glDisableVertexAttribArray(0);
	glDisableVertexAttribArray(1);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
}
void  Open:: drawcube2()
{
	prog.setUniform("fragModulationColor",glm::vec4(1,1,1,1));
	modelToWorldMatrix =orientationMatrix*glm::scale(glm::mat4(1.0f),glm::vec3(2.0f,1,1));
	setMatrices();
	size_t colorData = sizeof(cubeVertexData) / 2;
	glBindBuffer(GL_ARRAY_BUFFER, cubeVertexBufferObject);
	glEnableVertexAttribArray(0);
	glEnableVertexAttribArray(1);
	glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, 0);
	glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, (void*)colorData);
	glDrawArrays(GL_TRIANGLES, 0, 36);
	glDisableVertexAttribArray(0);
	glDisableVertexAttribArray(1);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
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
    
    drawcube1();
	drawcube2();
    

}

void Open:: reshape(int w, int h)
{
    cameraToClipMatrix = glm::perspective(90.0f, (float)w/h, 1.0f, 100.0f);
}

void Open:: OffsetOrientation(const glm::vec3 &_axis, float fAngDeg)
{
	float fAngRad = Deg2Rad(fAngDeg);
    
	glm::vec3 axis = glm::normalize(_axis);
    
	axis = axis * sinf(fAngRad / 2.0f);
	float scalar = cosf(fAngRad / 2.0f);
    
	glm::fquat offset(scalar, axis.x, axis.y, axis.z);
    
	g_orientation = g_orientation * offset;
    
	g_orientation = glm::normalize(g_orientation);
}

void Open::keyboard(unsigned char key, int x, int y)
{
	switch (key)
	{
		case 'x':
            OffsetOrientation(glm::vec3(1.0f, 0.0f, 0.0f), 1.0f);
            break;
            
		case 'X':
            OffsetOrientation(glm::vec3(1.0f, 0.0f, 0.0f), -1.0f);
            break;
            
		case 'y':
            OffsetOrientation(glm::vec3(0.0f, 1.0f, 0.0f), 1.0f);
            break;
            
		case 'Y':
            OffsetOrientation(glm::vec3(0.0f, 1.0f, 0.0f), -1.0f);
            break;
            
		case 'z':
            OffsetOrientation(glm::vec3(0.0f, 0.0f, 1.0f), 1.0f);
            break;
            
		case 'Z':
            OffsetOrientation(glm::vec3(0.0f, 0.0f, 1.0f), -1.0f);
            break;
            
	}
    
    
	orientationMatrix=glm::mat4_cast(g_orientation);
    
    
}

void Open:: update(int dt)
{
//	glutTimerFunc(1,update,0);
//	glutPostRedisplay();
}



//int main1(int argc, char* argv[])
//{
//
//    return 0;
//}

