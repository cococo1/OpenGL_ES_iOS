//
//  File.cpp
//  GLSampe1
//
//  Created by Maxim Chetrusca on 5/11/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//

#include "File.h"
#include <vector>
#include "math.h"

Open::Open()
{
//    blendingType = 0;
//        NSLog(@"Open created");
 
}

Open::~Open(){}


void Open::init()
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
    
    offsetLocation = glGetUniformLocation(theProgram, "offset");
//	GLuint perspectiveMatrixUnif = glGetUniformLocation(theProgram, "perspectiveMatrix");
//    
//    float theMatrix[16];
//	memset(theMatrix, 0, sizeof(float) * 16);
//    
//	float r=0.75f,l=-0.75f,t=0.75f,b=-0.75f,zFar=3.0f,zNear=1.0f;
//    
//	theMatrix[0] = (2*zNear)/(r-l);
//	theMatrix[2] = (r+l)/(r-l);
//	theMatrix[5] = (2*zNear)/(t-b);
//	theMatrix[6] = (t+b)/(t-b);
//	theMatrix[10] = -(zFar + zNear) / (zFar - zNear);
//	theMatrix[11] = - 2 * zFar * zNear / (zFar - zNear);
//	theMatrix[14] = -1.0f;
//	
//	glUniformMatrix4fv(perspectiveMatrixUnif, 1, GL_FALSE, theMatrix);
    
    glGenBuffers(1, &vertexBufferObject);
    
	glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObject);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertexData), vertexData, GL_STREAM_DRAW);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
    
    glEnable(GL_CULL_FACE);
	glFrontFace(GL_CW);
    glCullFace(GL_BACK);
}


void Open::render(float elapsedTime)
{

//    NSLog(@"%f",elapsedTime);
    
//	float fXOffset = 0.0f, fYOffset = 0.0f;
//    ComputePositionOffsets(fXOffset, fYOffset,elapsedTime);
//    AdjustVertexData(fXOffset, fYOffset);
    
	glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
	glClear(GL_COLOR_BUFFER_BIT);
    
	glUseProgram(theProgram);
    
    glUniform2f(offsetLocation, 0.5f, 0.5f);

    size_t colorData = sizeof(vertexData) / 2;
	glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObject);
	glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);

	glVertexAttribPointer(GLKVertexAttribPosition, 4, GL_FLOAT, GL_FALSE, 0, 0);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, (void*)colorData);

    
//    glEnableVertexAttribArray(GLKVertexAttribColor);
//    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, (void*)96);
    
	glDrawArrays(GL_TRIANGLES, 0, 36);
    
	glDisableVertexAttribArray(GLKVertexAttribPosition);
    glDisableVertexAttribArray(GLKVertexAttribColor);
	glUseProgram(0);
    
//	glutSwapBuffers();
}

//void Open::keyboard(unsigned char key, int x, int y)
//{
//	if(key==VK_SPACE)
//	{
//		blendingType++;
//		if(blendingType>2)
//		{
//			blendingType=0;
//		}
//	}
//}

void Open:: update(int dt)
{
//	glutTimerFunc(1,update,0);
//	glutPostRedisplay();
}

void Open:: reshape(int w, int h)
{
    width = w;
    height = h;
    
	glUseProgram( theProgram );
	GLuint perspectiveMatrixUnif = glGetUniformLocation(theProgram, "perspectiveMatrix");
	glm::mat4 theMatrix;
	theMatrix = glm::perspective(90.0f,(float)width/height,1.0f,3.0f);
	glUniformMatrix4fv(perspectiveMatrixUnif, 1, GL_FALSE, &theMatrix[0][0]);
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

