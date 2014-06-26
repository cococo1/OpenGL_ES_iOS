//
//  File.cpp
//  GLSampe1
//
//  Created by Maxim Chetrusca on 5/11/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//

#include "File.h"

GLuint theProgram;
GLuint  vertexBufferObject;
//    GLuint offsetLocation;
int width;
int height;
//    bool enableDepthClamping;
GLuint indexBufferObject;
GLuint vao;
//    GLuint vaoObject2;
//    GLuint offsetUniform;
GLuint modelToCameraMatrixUnif;
GLuint cameraToClipMatrixUnif;

//using namespace Open;
inline float DegToRad(float fAngDeg)
{
	const float fDegToRad = 3.14159f * 2.0f / 360.0f;
	return fAngDeg * fDegToRad;
}

glm::mat4 RotateX(float fAngDeg)
{
	glm::mat4 tempMat;
	return glm::rotate(tempMat,fAngDeg,glm::vec3(1,0,0));
}

glm::mat4 RotateY(float fAngDeg)
{
	glm::mat4 tempMat;
	return glm::rotate(tempMat,fAngDeg,glm::vec3(0,1,0));
}

glm::mat4 RotateZ(float fAngDeg)
{
	glm::mat4 tempMat;
	return glm::rotate(tempMat,fAngDeg,glm::vec3(0,0,1));
}

class MatrixStack
{
public:
	MatrixStack(): m_currMat(1.0f)
	{
	}
    
	const glm::mat4 &Top()
	{
		return m_currMat;
	}
    
	void RotateX(float fAngDeg)
	{
		m_currMat = m_currMat * ::RotateX(fAngDeg);
	}
    
	void RotateY(float fAngDeg)
	{
		m_currMat = m_currMat * ::RotateY(fAngDeg);
	}
    
	void RotateZ(float fAngDeg)
	{
		m_currMat = m_currMat * ::RotateZ(fAngDeg);
	}
    
	void Scale(const glm::vec3 &scaleVec)
	{
		glm::mat4 scaleMat(1.0f);
		scaleMat=glm::scale(scaleMat,scaleVec);
		m_currMat = m_currMat * scaleMat;
	}
    
	void Translate(const glm::vec3 &offsetVec)
	{
		glm::mat4 translateMat(1.0f);
		translateMat=glm::translate(translateMat,offsetVec);
		m_currMat = m_currMat * translateMat;
	}
    
	void Push()
	{
		m_matrices.push(m_currMat);
	}
    
	void Pop()
	{
		m_currMat = m_matrices.top();
		m_matrices.pop();
	}
    
private:
	glm::mat4 m_currMat;
	std::stack<glm::mat4> m_matrices;
};


OpenGL::OpenGL()
{
//    enableDepthClamping = false;
//    blendingType = 0;
//        NSLog(@"Open created");
 
}

OpenGL::~OpenGL(){}

class Hierarchy
{
public:
	Hierarchy()
    : posBase(glm::vec3(0.0f,-2.0f, -18.0f))
    , angBase(-45.0f)
    , posBaseLeft(glm::vec3(2.0f, 0.0f, 0.0f))
    , posBaseRight(glm::vec3(-2.0f, 0.0f, 0.0f))
    , scaleBaseZ(3.0f)
    , angUpperArm(-33.75f)
    , sizeUpperArm(9.0f)
    , posLowerArm(glm::vec3(0.0f, 0.0f, 8.0f))
    , angLowerArm(146.25f)
    , lenLowerArm(5.0f)
    , widthLowerArm(1.5f)
    , posWrist(glm::vec3(0.0f, 0.0f, 5.0f))
    , angWristRoll(0.0f)
    , angWristPitch(67.5f)
    , lenWrist(2.0f)
    , widthWrist(2.0f)
    , posLeftFinger(glm::vec3(1.0f, 0.0f, 1.0f))
    , posRightFinger(glm::vec3(-1.0f, 0.0f, 1.0f))
    , angFingerOpen(180.0f)
    , lenFinger(2.0f)
    , widthFinger(0.5f)
    , angLowerFinger(45.0f)
	{}
    
	void Draw()
	{
		MatrixStack modelToCameraStack;
        
		glUseProgram(theProgram);
		glBindVertexArrayOES (vao);
        
		modelToCameraStack.Translate(posBase);
		modelToCameraStack.RotateY(angBase);
        
		//Draw left base.
		{
			modelToCameraStack.Push();
			modelToCameraStack.Translate(posBaseLeft);
			modelToCameraStack.Scale(glm::vec3(1.0f, 1.0f, scaleBaseZ));
			glUniformMatrix4fv(modelToCameraMatrixUnif, 1, GL_FALSE, &modelToCameraStack.Top()[0][0]);
			glDrawElements(GL_TRIANGLES, ARRAY_COUNT(indexData), GL_UNSIGNED_SHORT, 0);
			modelToCameraStack.Pop();
		}
        
		//Draw right base.
		{
			modelToCameraStack.Push();
			modelToCameraStack.Translate(posBaseRight);
			modelToCameraStack.Scale(glm::vec3(1.0f, 1.0f, scaleBaseZ));
			glUniformMatrix4fv(modelToCameraMatrixUnif, 1, GL_FALSE, &modelToCameraStack.Top()[0][0]);
			glDrawElements(GL_TRIANGLES, ARRAY_COUNT(indexData), GL_UNSIGNED_SHORT, 0);
			modelToCameraStack.Pop();
		}
        
		//Draw main arm.
		DrawUpperArm(modelToCameraStack);
        
		glBindVertexArrayOES(0);
		glUseProgram(0);
	}
    
#define STANDARD_ANGLE_INCREMENT 11.25f
#define SMALL_ANGLE_INCREMENT 9.0f
    
	void AdjBase(bool bIncrement)
	{
		angBase += bIncrement ? STANDARD_ANGLE_INCREMENT : -STANDARD_ANGLE_INCREMENT;
		angBase = fmodf(angBase, 360.0f);
	}
    
	void AdjUpperArm(bool bIncrement)
	{
		angUpperArm += bIncrement ? STANDARD_ANGLE_INCREMENT : -STANDARD_ANGLE_INCREMENT;
	}
    
	void AdjLowerArm(bool bIncrement)
	{
		angLowerArm += bIncrement ? STANDARD_ANGLE_INCREMENT : -STANDARD_ANGLE_INCREMENT;
	}
    
	void AdjWristPitch(bool bIncrement)
	{
		angWristPitch += bIncrement ? STANDARD_ANGLE_INCREMENT : -STANDARD_ANGLE_INCREMENT;
	}
    
	void AdjWristRoll(bool bIncrement)
	{
		angWristRoll += bIncrement ? STANDARD_ANGLE_INCREMENT : -STANDARD_ANGLE_INCREMENT;
	}
    
	void AdjFingerOpen(bool bIncrement)
	{
		angFingerOpen += bIncrement ? SMALL_ANGLE_INCREMENT : -SMALL_ANGLE_INCREMENT;
	}
    
private:
	void DrawFingers(MatrixStack &modelToCameraStack)
	{
		//Draw left finger
		modelToCameraStack.Push();
		modelToCameraStack.Translate(posLeftFinger);
		modelToCameraStack.RotateY(angFingerOpen);
        
		modelToCameraStack.Push();
		modelToCameraStack.Translate(glm::vec3(0.0f, 0.0f, lenFinger / 2.0f));
		modelToCameraStack.Scale(glm::vec3(widthFinger / 2.0f, widthFinger/ 2.0f, lenFinger / 2.0f));
		glUniformMatrix4fv(modelToCameraMatrixUnif, 1, GL_FALSE, &modelToCameraStack.Top()[0][0]);
		glDrawElements(GL_TRIANGLES, ARRAY_COUNT(indexData), GL_UNSIGNED_SHORT, 0);
		modelToCameraStack.Pop();
        
		{
			//Draw left lower finger
			modelToCameraStack.Push();
			modelToCameraStack.Translate(glm::vec3(0.0f, 0.0f, lenFinger));
			modelToCameraStack.RotateY(-angLowerFinger);
            
			modelToCameraStack.Push();
			modelToCameraStack.Translate(glm::vec3(0.0f, 0.0f, lenFinger / 2.0f));
			modelToCameraStack.Scale(glm::vec3(widthFinger / 2.0f, widthFinger/ 2.0f, lenFinger / 2.0f));
			glUniformMatrix4fv(modelToCameraMatrixUnif, 1, GL_FALSE, &modelToCameraStack.Top()[0][0]);
			glDrawElements(GL_TRIANGLES, ARRAY_COUNT(indexData), GL_UNSIGNED_SHORT, 0);
			modelToCameraStack.Pop();
            
			modelToCameraStack.Pop();
		}
        
		modelToCameraStack.Pop();
        
		//Draw right finger
		modelToCameraStack.Push();
		modelToCameraStack.Translate(posRightFinger);
		modelToCameraStack.RotateY(-angFingerOpen);
        
		modelToCameraStack.Push();
		modelToCameraStack.Translate(glm::vec3(0.0f, 0.0f, lenFinger / 2.0f));
		modelToCameraStack.Scale(glm::vec3(widthFinger / 2.0f, widthFinger/ 2.0f, lenFinger / 2.0f));
		glUniformMatrix4fv(modelToCameraMatrixUnif, 1, GL_FALSE, &modelToCameraStack.Top()[0][0]);
		glDrawElements(GL_TRIANGLES, ARRAY_COUNT(indexData), GL_UNSIGNED_SHORT, 0);
		modelToCameraStack.Pop();
        
		{
			//Draw right lower finger
			modelToCameraStack.Push();
			modelToCameraStack.Translate(glm::vec3(0.0f, 0.0f, lenFinger));
			modelToCameraStack.RotateY(angLowerFinger);
            
			modelToCameraStack.Push();
			modelToCameraStack.Translate(glm::vec3(0.0f, 0.0f, lenFinger / 2.0f));
			modelToCameraStack.Scale(glm::vec3(widthFinger / 2.0f, widthFinger/ 2.0f, lenFinger / 2.0f));
			glUniformMatrix4fv(modelToCameraMatrixUnif, 1, GL_FALSE, &modelToCameraStack.Top()[0][0]);
			glDrawElements(GL_TRIANGLES, ARRAY_COUNT(indexData), GL_UNSIGNED_SHORT, 0);
			modelToCameraStack.Pop();
            
			modelToCameraStack.Pop();
		}
        
		modelToCameraStack.Pop();
	}
    
	void DrawWrist(MatrixStack &modelToCameraStack)
	{
		modelToCameraStack.Push();
		modelToCameraStack.Translate(posWrist);
		modelToCameraStack.RotateZ(angWristRoll);
		modelToCameraStack.RotateX(angWristPitch);
        
		modelToCameraStack.Push();
		modelToCameraStack.Scale(glm::vec3(widthWrist / 2.0f, widthWrist/ 2.0f, lenWrist / 2.0f));
		glUniformMatrix4fv(modelToCameraMatrixUnif, 1, GL_FALSE, &modelToCameraStack.Top()[0][0]);
		glDrawElements(GL_TRIANGLES, ARRAY_COUNT(indexData), GL_UNSIGNED_SHORT, 0);
		modelToCameraStack.Pop();
        
		DrawFingers(modelToCameraStack);
        
		modelToCameraStack.Pop();
	}
    
	void DrawLowerArm(MatrixStack &modelToCameraStack)
	{
		modelToCameraStack.Push();
		modelToCameraStack.Translate(posLowerArm);
		modelToCameraStack.RotateX(angLowerArm);
        
		modelToCameraStack.Push();
		modelToCameraStack.Translate(glm::vec3(0.0f, 0.0f, lenLowerArm / 2.0f));
		modelToCameraStack.Scale(glm::vec3(widthLowerArm / 2.0f, widthLowerArm / 2.0f, lenLowerArm / 2.0f));
		glUniformMatrix4fv(modelToCameraMatrixUnif, 1, GL_FALSE, &modelToCameraStack.Top()[0][0]);
		glDrawElements(GL_TRIANGLES, ARRAY_COUNT(indexData), GL_UNSIGNED_SHORT, 0);
		modelToCameraStack.Pop();
        
		DrawWrist(modelToCameraStack);
        
		modelToCameraStack.Pop();
	}
    
	void DrawUpperArm(MatrixStack &modelToCameraStack)
	{
		modelToCameraStack.Push();
		modelToCameraStack.RotateX(angUpperArm);
        
		{
			modelToCameraStack.Push();
			modelToCameraStack.Translate(glm::vec3(0.0f, 0.0f, (sizeUpperArm / 2.0f) - 1.0f));
			modelToCameraStack.Scale(glm::vec3(1.0f, 1.0f, sizeUpperArm / 2.0f));
			glUniformMatrix4fv(modelToCameraMatrixUnif, 1, GL_FALSE, &modelToCameraStack.Top()[0][0]);
			glDrawElements(GL_TRIANGLES, ARRAY_COUNT(indexData), GL_UNSIGNED_SHORT, 0);
			modelToCameraStack.Pop();
		}
        
		DrawLowerArm(modelToCameraStack);
        
		modelToCameraStack.Pop();
	}
    
	glm::vec3		posBase;
	float			angBase;
    
	glm::vec3		posBaseLeft, posBaseRight;
	float			scaleBaseZ;
    
	float			angUpperArm;
	float			sizeUpperArm;
    
	glm::vec3		posLowerArm;
	float			angLowerArm;
	float			lenLowerArm;
	float			widthLowerArm;
    
	glm::vec3		posWrist;
	float			angWristRoll;
	float			angWristPitch;
	float			lenWrist;
	float			widthWrist;
    
	glm::vec3		posLeftFinger, posRightFinger;
	float			angFingerOpen;
	float			lenFinger;
	float			widthFinger;
	float			angLowerFinger;
};

Hierarchy g_armature;


void OpenGL::init()
{
    //    const GLchar *shaderString;
    
    NSString* file = [[NSBundle mainBundle] pathForResource:@"basic"
                                                     ofType:@"vert"];
    //    NSLog(@"%@",file);
    NSError* error;
    NSString *shaderNSString =[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error];
    if (!shaderNSString)
    {
        NSLog(@"Failed to load vertex shader. Error: %@",error.localizedDescription);
        return ;
    }
    const GLchar* shaderCstring = (GLchar *)[shaderNSString UTF8String];
    
    
    
    GLuint vertShader = glCreateShader( GL_VERTEX_SHADER );
    if( 0 == vertShader )
    {
        //        fprintf(stderr, "Error creating vertex shader.\n");
        NSLog(@"Error creating vertex shader.");
        exit(1);
    }
    
    int shaderStringLength = [shaderNSString length];
    glShaderSource(vertShader, 1, &shaderCstring, &shaderStringLength);
    glCompileShader( vertShader );
    
    GLint result;
    glGetShaderiv( vertShader, GL_COMPILE_STATUS, &result );
    if( GL_FALSE == result )
    {
        
        //        fprintf( stderr, "Vertex shader compilation failed!\n" );
        NSLog(@"Vertex shader compilation failed!");
        
        GLint logLen;
        glGetShaderiv( vertShader, GL_INFO_LOG_LENGTH, &logLen );
        
        if( logLen > 0 )
        {
            char * log = (char *)malloc(logLen);
            
            GLsizei written;
            glGetShaderInfoLog(vertShader, logLen, &written, log);
            
            NSLog(@"Shader log: \n%s", log);
            
            free(log);
        }
    }
    
    //Fragment shader
    
    NSString* file1 = [[NSBundle mainBundle] pathForResource:@"basic"
                                                      ofType:@"frag"];
    
    NSError* error1;
    NSString *shaderNSString1 =[NSString stringWithContentsOfFile:file1 encoding:NSUTF8StringEncoding error:&error1];
    const GLchar* shaderCstring1 = (GLchar *)[shaderNSString1 UTF8String];
    
    if (!shaderCstring1)
    {
        NSLog(@"Failed to load fragment shader. Error: %@",error1.localizedDescription);
        return ;
    }
    
    GLuint fragShader = glCreateShader( GL_FRAGMENT_SHADER );
    if( 0 == fragShader )
    {
        //        fprintf(stderr, "Error creating vertex shader.\n");
        NSLog(@"Error creating frag shader.");
        exit(1);
    }
    
    int shaderStringLength1 = [shaderNSString1 length];
    glShaderSource(fragShader, 1, &shaderCstring1, &shaderStringLength1);
    glCompileShader( fragShader );
    
    GLint result1;
    glGetShaderiv( fragShader, GL_COMPILE_STATUS, &result1 );
    if( GL_FALSE == result1 )
    {
        
        //        fprintf( stderr, "Vertex shader compilation failed!\n" );
        NSLog(@"Frag shader compilation failed!");
        
        GLint logLen;
        glGetShaderiv( fragShader, GL_INFO_LOG_LENGTH, &logLen );
        
        if( logLen > 0 )
        {
            char * log = (char *)malloc(logLen);
            
            GLsizei written;
            glGetShaderInfoLog(fragShader, logLen, &written, log);
            
            NSLog(@"Shader log: \n%s", log);
            
            free(log);
        }
    }
    
    theProgram= glCreateProgram();
    if( 0 == theProgram )
    {
        NSLog(@"Error creating the program.");
        exit(1);
    }
    
    
    glAttachShader( theProgram, vertShader );
    glAttachShader( theProgram, fragShader );
    
    glBindAttribLocation(theProgram, GLKVertexAttribPosition, "vertexPosition");
    glBindAttribLocation(theProgram, GLKVertexAttribColor, "colorIn");

    //    glBindAttribLocation(theProgram, GLKVertexAttribColor, "vertexColor");
    // Link the program
    glLinkProgram( theProgram );
    
    // Check for successful linking
    GLint status;
    glGetProgramiv( theProgram, GL_LINK_STATUS, &status );
    if( GL_FALSE == status ) {
        NSLog(@"Failed to link shader program!");
        //        fprintf( stderr, "Failed to link shader program!\n" );
        
        GLint logLen;
        glGetProgramiv( theProgram, GL_INFO_LOG_LENGTH, &logLen );
        
        if( logLen > 0 )
        {
            char * log = (char *)malloc(logLen);
            
            GLsizei written;
            glGetProgramInfoLog(theProgram, logLen, &written, log);
            
            NSLog(@"Program log: \n%s",log);
            //            fprintf(stderr, "Program log: \n%s", log);
            
            free(log);
        }
    }
    else
    {
        glUseProgram( theProgram );
    }
    
    modelToCameraMatrixUnif = glGetUniformLocation(theProgram, "modelToCameraMatrix");
	cameraToClipMatrixUnif = glGetUniformLocation(theProgram, "cameraToClipMatrix");
    



    /* ----------------------------------------------------------------------------------------------------------------------*/
    /* ------------------------------------------------- VERTEX BUFFERS INITITALIZATION -------------------------------------*/
    /* ----------------------------------------------------------------------------------------------------------------------*/
    
    glGenBuffers(1, &vertexBufferObject);
    
    
	glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObject);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertexData), vertexData, GL_STATIC_DRAW);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
    
    // initializing the index buffer data
	glGenBuffers(1, &indexBufferObject);
    
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBufferObject);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indexData), indexData, GL_STATIC_DRAW);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    
    /* ----------------------------------------------------------------------------------------------------------------------*/
    /* ------------------------------------------------- VERTEX ARRAY OBJECST INITITALIZATION -------------------------------*/
    /* ----------------------------------------------------------------------------------------------------------------------*/
    
	// initializing the first vertex array object
	glGenVertexArraysOES(1, &vao);
	glBindVertexArrayOES(vao);
    
	size_t colorDataOffset = sizeof(float) * 3 * numberOfVertices;
    
	glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObject);
	glEnableVertexAttribArray(GLKVertexAttribPosition);
	glEnableVertexAttribArray(GLKVertexAttribColor);
	glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, 0);
	glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, (void*)colorDataOffset);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBufferObject);
    
	glBindVertexArrayOES(0);
    
//    // initializing the second vertex array object
//	glGenVertexArraysOES(1, &vaoObject2);
//	glBindVertexArrayOES (vaoObject2);
//    
//	size_t posDataOffset = sizeof(float) * 3 * (numberOfVertices/2);
//	colorDataOffset += sizeof(float) * 4 * (numberOfVertices/2);
//    
//	//Use the same buffer object previously bound to GL_ARRAY_BUFFER.
//	glEnableVertexAttribArray(GLKVertexAttribPosition);
//	glEnableVertexAttribArray(GLKVertexAttribColor);
//	glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, (void*)posDataOffset);
//	glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, (void*)colorDataOffset);
//	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBufferObject);
//    
//	glBindVertexArrayOES (0);
    

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


void OpenGL ::render(float elapsedTime)
{

//    NSLog(@"%f",elapsedTime);
    
//	float fXOffset = 0.0f, fYOffset = 0.0f;
//    ComputePositionOffsets(fXOffset, fYOffset,elapsedTime);
//    AdjustVertexData(fXOffset, fYOffset);
    
	glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClearDepthf(1.0);
//    glClearDepth(1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
	glUseProgram(theProgram);

	g_armature.Draw();
    
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
	glBindVertexArrayOES (0);
    
	glUseProgram(0);    

    
//    glEnableVertexAttribArray(GLKVertexAttribColor);
//    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, (void*)96);
    

    
//	glutSwapBuffers();
}

void OpenGL ::keyboard(unsigned char key, int x, int y)
{
	switch (key)
	{
		case 'a': g_armature.AdjBase(true); break;
		case 'd': g_armature.AdjBase(false); break;
		case 'w': g_armature.AdjUpperArm(false); break;
		case 's': g_armature.AdjUpperArm(true); break;
		case 'r': g_armature.AdjLowerArm(false); break;
		case 'f': g_armature.AdjLowerArm(true); break;
		case 't': g_armature.AdjWristPitch(false); break;
		case 'g': g_armature.AdjWristPitch(true); break;
		case 'z': g_armature.AdjWristRoll(true); break;
		case 'c': g_armature.AdjWristRoll(false); break;
		case 'q': g_armature.AdjFingerOpen(true); break;
		case 'e': g_armature.AdjFingerOpen(false); break;
	}
}

void OpenGL :: update(int dt)
{
//	glutTimerFunc(1,update,0);
//	glutPostRedisplay();
}

void OpenGL :: reshape(int w, int h)
{
    width = w;
    height = h;
    
	glUseProgram( theProgram );
//	GLuint cameraToClipMatrix = glGetUniformLocation(theProgram, "cameraToClipMatrix");
	glm::mat4 clipMatrix;
	clipMatrix = glm::perspective(90.0f,(float)width/height,1.0f,50.0f);
	glUniformMatrix4fv(cameraToClipMatrixUnif, 1, GL_FALSE, &clipMatrix[0][0]);
	glUseProgram(0);
    
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

