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
    angY=0;
    angX=0;
    angZ=0;
    g_sphereCamRelPos = glm::vec3(67.5f, -46.0f, 5.0f);
    g_camTarget = glm::vec3(0.0f, 0.4f, 0.0f);
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

//helper function to generate our gimbal geometry
void Open::GenerateCircleGeometry()
{
	//vertex data
	for(int i=0;i<circleTesselation;i++)
	{
		//the top vertices
		double rad=DegToRad(((float)i)*360.0f/(float)circleTesselation);
		circleVertexData[i*96]=(float)cos(rad);
		circleVertexData[i*96+1]=(float)sin(rad);
		circleVertexData[i*96+2]=0.05f;
		circleVertexData[i*96+3]=1.0f;
        
		circleVertexData[i*96+4]=(float)cos(rad);
		circleVertexData[i*96+5]=(float)sin(rad);
		circleVertexData[i*96+6]=-0.05f;
		circleVertexData[i*96+7]=1.0f;
        
		rad=DegToRad(((float)(i+1))*360.0f/(float)circleTesselation);
		circleVertexData[i*96+8]=(float)cos(rad);
		circleVertexData[i*96+9]=(float)sin(rad);
		circleVertexData[i*96+10]=0.05f;
		circleVertexData[i*96+11]=1.0f;
        
		circleVertexData[i*96+12]=circleVertexData[i*96+8];
		circleVertexData[i*96+13]=circleVertexData[i*96+9];
		circleVertexData[i*96+14]=circleVertexData[i*96+10];
		circleVertexData[i*96+15]=circleVertexData[i*96+11];
        
		circleVertexData[i*96+16]=circleVertexData[i*96+4];
		circleVertexData[i*96+17]=circleVertexData[i*96+5];
		circleVertexData[i*96+18]=circleVertexData[i*96+6];
		circleVertexData[i*96+19]=circleVertexData[i*96+7];
        
		circleVertexData[i*96+20]=(float)cos(rad);
		circleVertexData[i*96+21]=(float)sin(rad);
		circleVertexData[i*96+22]=-0.05f;
		circleVertexData[i*96+23]=1.0f;
        
		//the bottom vertices
		rad=DegToRad(((float)i)*360.0f/(float)circleTesselation);
		circleVertexData[i*96+24]=(float)cos(rad)*0.9f;
		circleVertexData[i*96+24+1]=(float)sin(rad)*0.9f;
		circleVertexData[i*96+24+2]=0.05f;
		circleVertexData[i*96+24+3]=1.0f;
        
		circleVertexData[i*96+24+4]=(float)cos(rad)*0.9f;
		circleVertexData[i*96+24+5]=(float)sin(rad)*0.9f;
		circleVertexData[i*96+24+6]=-0.05f;
		circleVertexData[i*96+24+7]=1.0f;
        
		rad=DegToRad(((float)(i+1))*360.0f/(float)circleTesselation);
		circleVertexData[i*96+24+8]=(float)cos(rad)*0.9f;
		circleVertexData[i*96+24+9]=(float)sin(rad)*0.9f;
		circleVertexData[i*96+24+10]=0.05f;
		circleVertexData[i*96+24+11]=1.0f;
        
		circleVertexData[i*96+24+12]=circleVertexData[i*96+24+8];
		circleVertexData[i*96+24+13]=circleVertexData[i*96+24+9];
		circleVertexData[i*96+24+14]=circleVertexData[i*96+24+10];
		circleVertexData[i*96+24+15]=circleVertexData[i*96+24+11];
        
		circleVertexData[i*96+24+16]=circleVertexData[i*96+24+4];
		circleVertexData[i*96+24+17]=circleVertexData[i*96+24+5];
		circleVertexData[i*96+24+18]=circleVertexData[i*96+24+6];
		circleVertexData[i*96+24+19]=circleVertexData[i*96+24+7];
        
		circleVertexData[i*96+24+20]=(float)cos(rad)*0.9f;
		circleVertexData[i*96+24+21]=(float)sin(rad)*0.9f;
		circleVertexData[i*96+24+22]=-0.05f;
		circleVertexData[i*96+24+23]=1.0f;
        
		for(int v=0;v<6;v++)
		{
			if(v==1 || v==3 || v==4)
			{
				circleVertexData[i*96+48+v*4]=circleVertexData[i*96+v*4];
				circleVertexData[i*96+48+v*4+1]=circleVertexData[i*96+v*4+1];
				circleVertexData[i*96+48+v*4+2]=0.05f;
				circleVertexData[i*96+48+v*4+3]=1.0f;
			}
			else
			{
				circleVertexData[i*96+48+v*4]=circleVertexData[i*96+24+v*4];
				circleVertexData[i*96+48+v*4+1]=circleVertexData[i*96+24+v*4+1];
				circleVertexData[i*96+48+v*4+2]=0.05f;
				circleVertexData[i*96+48+v*4+3]=1.0f;
			}
		}
        
		for(int v=0;v<6;v++)
		{
			if(v==1 || v==3 || v==4)
			{
				circleVertexData[i*96+72+v*4]=circleVertexData[i*96+v*4];
				circleVertexData[i*96+72+v*4+1]=circleVertexData[i*96+v*4+1];
				circleVertexData[i*96+72+v*4+2]=-0.05f;
				circleVertexData[i*96+72+v*4+3]=1.0f;
			}
			else
			{
				circleVertexData[i*96+72+v*4]=circleVertexData[i*96+24+v*4];
				circleVertexData[i*96+72+v*4+1]=circleVertexData[i*96+24+v*4+1];
				circleVertexData[i*96+72+v*4+2]=-0.05f;
				circleVertexData[i*96+72+v*4+3]=1.0f;
			}
		}
        
	}
    
	//color data
	for(int i=0;i<circleTesselation;i++)
	{
		for(int j=0;j<24;j++)
		{
			circleVertexData[circleTesselation*96+i*96+j]=1.0f;
		}
        
		for(int j=24;j<48;j++)
		{
			circleVertexData[circleTesselation*96+i*96+j]=0.8f;
		}
        
		for(int j=48;j<72;j++)
		{
			circleVertexData[circleTesselation*96+i*96+j]=0.6f;
		}
        
		for(int j=72;j<96;j++)
		{
			circleVertexData[circleTesselation*96+i*96+j]=0.4f;
		}
	}
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
    
	//fill gimbal vertex buffer object
	GenerateCircleGeometry();
	glGenBuffers(1, &gimbalVertexBufferObject);
    
	glBindBuffer(GL_ARRAY_BUFFER, gimbalVertexBufferObject);
	glBufferData(GL_ARRAY_BUFFER, circleTesselation*192*4, circleVertexData, GL_STREAM_DRAW);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
    
	//set the camera matrix
	worldToCameraMatrix = glm::lookAt(glm::vec3(0.3f,1.0f,1.7f),glm::vec3(0.0f, 0.0f, 0.0f), glm::vec3(0.0f, 1.0f, 0.0f));    /* ----------------------------------------------------------------------------------------------------------------------*/
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
	modelToWorldMatrix = zRotMatrix*yRotMatrix*xRotMatrix*glm::scale(glm::mat4(1.0f),glm::vec3(1,1,3));
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
	modelToWorldMatrix =zRotMatrix*yRotMatrix*xRotMatrix*glm::scale(glm::mat4(1.0f),glm::vec3(2.0f,1,1));
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
void Open:: drawGimbalZ(float elapsedTime)
{
//	zRotTimer.AdvanceTimeNegative();
//	if(zRotTimer.GetElapsedTime()<0)
//	{
//		zRotTimer.SetElapsedTime(0);
//	}
//    
	prog.setUniform("fragModulationColor",glm::vec4(1,elapsedTime,elapsedTime,1));
	modelToWorldMatrix = zRotMatrix*glm::scale(glm::mat4(1.0f),glm::vec3(1.25f,1.25f,1.25f));
	setMatrices();
	size_t colorData = circleTesselation*192*2;
	glBindBuffer(GL_ARRAY_BUFFER, gimbalVertexBufferObject);
	glEnableVertexAttribArray(0);
	glEnableVertexAttribArray(1);
	glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, 0);
	glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, (void*)colorData);
	glDrawArrays(GL_TRIANGLES, 0, circleTesselation*48);
	glDisableVertexAttribArray(0);
	glDisableVertexAttribArray(1);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
}
void Open:: drawGimbalY(float elapsedTime)
{
//	yRotTimer.AdvanceTimeNegative();
//	if(yRotTimer.GetElapsedTime()<0)
//	{
//		yRotTimer.SetElapsedTime(0);
//	}
    
	prog.setUniform("fragModulationColor",glm::vec4(elapsedTime,1,elapsedTime,1));
	modelToWorldMatrix = zRotMatrix*yRotMatrix*glm::rotate(glm::mat4(1.0f),90.0f,glm::vec3(1,0,0))*glm::scale(glm::mat4(1.0f),glm::vec3(1.1f,1.1f,1.1f));
	setMatrices();
	size_t colorData = circleTesselation*192*2;
	glBindBuffer(GL_ARRAY_BUFFER, gimbalVertexBufferObject);
	glEnableVertexAttribArray(0);
	glEnableVertexAttribArray(1);
	glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, 0);
	glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, (void*)colorData);
	glDrawArrays(GL_TRIANGLES, 0, circleTesselation*48);
	glDisableVertexAttribArray(0);
	glDisableVertexAttribArray(1);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
}
void Open:: drawGimbalX(float elapsedTime)
{
//	xRotTimer.AdvanceTimeNegative();
//	if(xRotTimer.GetElapsedTime()<0)
//	{
//		xRotTimer.SetElapsedTime(0);
//	}
//    
	prog.setUniform("fragModulationColor",glm::vec4(elapsedTime,elapsedTime,1,1));
	modelToWorldMatrix = zRotMatrix*yRotMatrix*xRotMatrix*glm::rotate(glm::mat4(1.0f),90.0f,glm::vec3(0,1,0))*glm::scale(glm::mat4(1.0f),glm::vec3(1.0f,1.0f,1.0f));
	setMatrices();
	size_t colorData = circleTesselation*192*2;
	glBindBuffer(GL_ARRAY_BUFFER, gimbalVertexBufferObject);
	glEnableVertexAttribArray(0);
	glEnableVertexAttribArray(1);
	glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, 0);
	glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, (void*)colorData);
	glDrawArrays(GL_TRIANGLES, 0, circleTesselation*48);
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
    
    //calc 3 rotation matrices
	xRotMatrix=glm::rotate(glm::mat4(1.0f),angX,glm::vec3(1,0,0));
	yRotMatrix=glm::rotate(glm::mat4(1.0f),angY,glm::vec3(0,1,0));
	zRotMatrix=glm::rotate(glm::mat4(1.0f),angZ,glm::vec3(0,0,1));
    
	//enable culling for cube
	glEnable(GL_CULL_FACE);
	glFrontFace(GL_CW);
    glCullFace(GL_BACK);
    
	drawcube1();
	drawcube2();
    
	//disable culling for gimbals due to awful geometry setup
	glDisable(GL_CULL_FACE);
    
	//draw gimbals
//	drawGimbalZ(0.9);
//	drawGimbalY(0.9);
//	drawGimbalX(0.9);
    
//	glUseProgram(theProgram);
//    
//	glBindVertexArrayOES(vaoObject);
//    glUniform3f(offsetUniform, 0.0f, 0.0f, 0.0f);
//
//    static float rx=0,ry=0,rz=0;
//	rx+=0.1f;ry+=0.1f;rz+=0.1f;
//	//prepare the first rotation matrix and render object
//	glUniform3f(offsetUniform, 0.0f, 0.0f, -3.0f);
//	glm::mat4 transformMatrix = glm::mat4(1.0f);
//	transformMatrix=glm::rotate(transformMatrix,rx,glm::vec3(1,0,0));
//	glUniformMatrix4fv(modelToCameraMatrixUnif, 1, GL_FALSE, &transformMatrix[0][0]);
//	glDrawElements(GL_TRIANGLES, ARRAY_COUNT(indexData), GL_UNSIGNED_SHORT, 0);
//    
//	//prepare the second rotation matrix and render object
//	glUniform3f(offsetUniform, -2.0f, 0.0f, -3.0f);
//	transformMatrix = glm::mat4(1.0f);
//	transformMatrix=glm::rotate(transformMatrix,ry,glm::vec3(0,1,0));
//	glUniformMatrix4fv(modelToCameraMatrixUnif, 1, GL_FALSE, &transformMatrix[0][0]);
//	glDrawElements(GL_TRIANGLES, ARRAY_COUNT(indexData), GL_UNSIGNED_SHORT, 0);
//    
//	//prepare the third rotation matrix and render object
//	glUniform3f(offsetUniform, 2.0f, 0.0f, -3.0f);
//	transformMatrix = glm::mat4(1.0f);
//	transformMatrix=glm::rotate(transformMatrix,rz,glm::vec3(0,0,1));
//	glUniformMatrix4fv(modelToCameraMatrixUnif, 1, GL_FALSE, &transformMatrix[0][0]);
//	glDrawElements(GL_TRIANGLES, ARRAY_COUNT(indexData), GL_UNSIGNED_SHORT, 0);
//    
//    
//	glBindVertexArrayOES (0);
//    
//	glUseProgram(0);    

    
//    glEnableVertexAttribArray(GLKVertexAttribColor);
//    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, (void*)96);
    

    
//	glutSwapBuffers();
}

void Open::keyboard(unsigned char key, int x, int y)
{
	switch (key)
	{
		case 'x':
            angX += 1.0f;
//            if(xRotTimer.GetElapsedTime()<0.01f)
//            {
//                xRotTimer.SetElapsedTime(0.9f);
//            }
            break;
            
		case 'X':
            angX -= 1.0f;
//            if(xRotTimer.GetElapsedTime()<0.01f)
//            {
//                xRotTimer.SetElapsedTime(0.9f);
//            }
            break;
            
		case 'y':
            angY += 1.0f;
//            if(yRotTimer.GetElapsedTime()<0.01f)
//            {
//                yRotTimer.SetElapsedTime(0.9f);
//            }
            break;
            
		case 'Y':
            angY -= 1.0f;
//            if(yRotTimer.GetElapsedTime()<0.01f)
//            {
//                yRotTimer.SetElapsedTime(0.9f);
//            }
            break;
            
		case 'z':
            angZ += 1.0f;
//            if(zRotTimer.GetElapsedTime()<0.01f)
//            {
//                zRotTimer.SetElapsedTime(0.9f);
//            }
            break;
            
		case 'Z':
            angZ -= 1.0f;
//            if(zRotTimer.GetElapsedTime()<0.01f)
//            {
//                zRotTimer.SetElapsedTime(0.9f);
//            }
            break;
            
	}
//	if(key == VK_SPACE)
//	{
//        NSLog(@"key pressed");
//		enableDepthClamping = !enableDepthClamping;
//        
//		if(enableDepthClamping)
//		{
////			glEnable(GL_DEPTH_CLAMP);
//
//		}
//		else
//		{
////			glDisable(GL_CLAMP_TO_EDGE);
//		}
//	}
}

void Open:: update(int dt)
{
//	glutTimerFunc(1,update,0);
//	glutPostRedisplay();
}

void Open:: reshape(int w, int h)
{
    cameraToClipMatrix = glm::perspective(90.0f, (float)w/h, 1.0f, 100.0f);

//    width = w;
//    height = h;
//    
//	glUseProgram( theProgram );
//	GLuint cameraToClipMatrix = glGetUniformLocation(theProgram, "cameraToClipMatrix");
//	glm::mat4 clipMatrix;
//	clipMatrix = glm::perspective(90.0f,(float)width/height,1.0f,10.0f);
//	glUniformMatrix4fv(cameraToClipMatrix, 1, GL_FALSE, &clipMatrix[0][0]);
//	glUseProgram(0);
//    
//	glViewport(0,0,(GLsizei)w,(GLsizei)h);
//	glViewport(0,0,(GLsizei)w,(GLsizei)h);
}

//void Open:: ComputePositionOffsets(float &fXOffset, float &fYOffset, float elapsedTime)
//{
//    const float fLoopDuration = 5.0f;
//    const float fScale = 3.14159f * 2.0f / fLoopDuration;
//    
//    float fElapsedTime = elapsedTime;// / 1000.0f;
//    
//    float fCurrTimeThroughLoop = fmodf(fElapsedTime, fLoopDuration);
//    
//    fXOffset = cosf(fCurrTimeThroughLoop * fScale) * 0.5f;
//    fYOffset = sinf(fCurrTimeThroughLoop * fScale) * 0.5f;
////    NSLog(@"%f %f",fXOffset, fYOffset);
//}
//
//void Open:: AdjustVertexData(float fXOffset, float fYOffset)
//{
//	int vertexDataElements=sizeof( vertexData )/4;
//    
//    std::vector<float> fNewData(vertexDataElements);
//    memcpy(&fNewData[0], vertexData, sizeof(vertexData));
//    
//    for(int iVertex = 0; iVertex < vertexDataElements; iVertex += 4)
//    {
//        fNewData[iVertex] += fXOffset;
//        fNewData[iVertex + 1] += fYOffset;
//    }
//    
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObject);
//    glBufferSubData(GL_ARRAY_BUFFER, 0, sizeof(vertexData), &fNewData[0]);
//    glBindBuffer(GL_ARRAY_BUFFER, 0);
//}

//int main1(int argc, char* argv[])
//{
//
//    return 0;
//}

