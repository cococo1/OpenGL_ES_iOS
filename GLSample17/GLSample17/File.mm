//
//  File.cpp
//  GLSampe1
//
//  Created by Maxim Chetrusca on 5/11/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//

#include "File.h"

//position of the camera in spherical coordinates
static glm::vec3 g_sphereCamRelPos(67.5f, -46.0f, 5.0f);
//the position our camera looks at
static glm::vec3 g_camTarget(0.0f, 0.4f, 0.0f);

Open::Open()
{
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

    if( ! prog.link() )
    {
        printf("Shader program failed to link!\n%s",
               prog.log().c_str());
        exit(1);
    }
    
    prog.use();
    
	//initializing the teapot and the plane geometry
    plane = new VBOPlane(50.0f, 50.0f, 1, 1);
    teapot = new VBOTeapot(14, glm::mat4(1.0f));
    //    const GLchar *shaderString;
//    
//    NSString* file = [[NSBundle mainBundle] pathForResource:@"basic"
//                                                     ofType:@"vert"];
//    //    NSLog(@"%@",file);
//    NSError* error;
//    NSString *shaderNSString =[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error];
//    if (!shaderNSString)
//    {
//        NSLog(@"Failed to load vertex shader. Error: %@",error.localizedDescription);
//        return ;
//    }
//    const GLchar* shaderCstring = (GLchar *)[shaderNSString UTF8String];
//    
//    
//    
//    GLuint vertShader = glCreateShader( GL_VERTEX_SHADER );
//    if( 0 == vertShader )
//    {
//        //        fprintf(stderr, "Error creating vertex shader.\n");
//        NSLog(@"Error creating vertex shader.");
//        exit(1);
//    }
//    
//    int shaderStringLength = [shaderNSString length];
//    glShaderSource(vertShader, 1, &shaderCstring, &shaderStringLength);
//    glCompileShader( vertShader );
//    
//    GLint result;
//    glGetShaderiv( vertShader, GL_COMPILE_STATUS, &result );
//    if( GL_FALSE == result )
//    {
//        
//        //        fprintf( stderr, "Vertex shader compilation failed!\n" );
//        NSLog(@"Vertex shader compilation failed!");
//        
//        GLint logLen;
//        glGetShaderiv( vertShader, GL_INFO_LOG_LENGTH, &logLen );
//        
//        if( logLen > 0 )
//        {
//            char * log = (char *)malloc(logLen);
//            
//            GLsizei written;
//            glGetShaderInfoLog(vertShader, logLen, &written, log);
//            
//            NSLog(@"Shader log: \n%s", log);
//            
//            free(log);
//        }
//    }
//    
//    //Fragment shader
//    
//    NSString* file1 = [[NSBundle mainBundle] pathForResource:@"basic"
//                                                      ofType:@"frag"];
//    
//    NSError* error1;
//    NSString *shaderNSString1 =[NSString stringWithContentsOfFile:file1 encoding:NSUTF8StringEncoding error:&error1];
//    const GLchar* shaderCstring1 = (GLchar *)[shaderNSString1 UTF8String];
//    
//    if (!shaderCstring1)
//    {
//        NSLog(@"Failed to load fragment shader. Error: %@",error1.localizedDescription);
//        return ;
//    }
//    
//    GLuint fragShader = glCreateShader( GL_FRAGMENT_SHADER );
//    if( 0 == fragShader )
//    {
//        //        fprintf(stderr, "Error creating vertex shader.\n");
//        NSLog(@"Error creating frag shader.");
//        exit(1);
//    }
//    
//    int shaderStringLength1 = [shaderNSString1 length];
//    glShaderSource(fragShader, 1, &shaderCstring1, &shaderStringLength1);
//    glCompileShader( fragShader );
//    
//    GLint result1;
//    glGetShaderiv( fragShader, GL_COMPILE_STATUS, &result1 );
//    if( GL_FALSE == result1 )
//    {
//        
//        //        fprintf( stderr, "Vertex shader compilation failed!\n" );
//        NSLog(@"Frag shader compilation failed!");
//        
//        GLint logLen;
//        glGetShaderiv( fragShader, GL_INFO_LOG_LENGTH, &logLen );
//        
//        if( logLen > 0 )
//        {
//            char * log = (char *)malloc(logLen);
//            
//            GLsizei written;
//            glGetShaderInfoLog(fragShader, logLen, &written, log);
//            
//            NSLog(@"Shader log: \n%s", log);
//            
//            free(log);
//        }
//    }
//    
//    theProgram= glCreateProgram();
//    if( 0 == theProgram )
//    {
//        NSLog(@"Error creating the program.");
//        exit(1);
//    }
//    
//    
//    glAttachShader( theProgram, vertShader );
//    glAttachShader( theProgram, fragShader );
//    
//    glBindAttribLocation(theProgram, GLKVertexAttribPosition, "vertexPosition");
//    glBindAttribLocation(theProgram, GLKVertexAttribColor, "colorIn");
//
//    //    glBindAttribLocation(theProgram, GLKVertexAttribColor, "vertexColor");
//    // Link the program
//    glLinkProgram( theProgram );
//    
//    // Check for successful linking
//    GLint status;
//    glGetProgramiv( theProgram, GL_LINK_STATUS, &status );
//    if( GL_FALSE == status ) {
//        NSLog(@"Failed to link shader program!");
//        //        fprintf( stderr, "Failed to link shader program!\n" );
//        
//        GLint logLen;
//        glGetProgramiv( theProgram, GL_INFO_LOG_LENGTH, &logLen );
//        
//        if( logLen > 0 )
//        {
//            char * log = (char *)malloc(logLen);
//            
//            GLsizei written;
//            glGetProgramInfoLog(theProgram, logLen, &written, log);
//            
//            NSLog(@"Program log: \n%s",log);
//            //            fprintf(stderr, "Program log: \n%s", log);
//            
//            free(log);
//        }
//    }
//    else
//    {
//        glUseProgram( theProgram );
//    }
//    
//    modelToCameraMatrixUnif = glGetUniformLocation(theProgram, "modelToCameraMatrix");
//    offsetUniform = glGetUniformLocation(theProgram, "offset");
//
//
//
//    /* ----------------------------------------------------------------------------------------------------------------------*/
//    /* ------------------------------------------------- VERTEX BUFFERS INITITALIZATION -------------------------------------*/
//    /* ----------------------------------------------------------------------------------------------------------------------*/
//    
//    glGenBuffers(1, &vertexBufferObject);
//    
//    
//	glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObject);
//	glBufferData(GL_ARRAY_BUFFER, sizeof(vertexData), vertexData, GL_STATIC_DRAW);
//	glBindBuffer(GL_ARRAY_BUFFER, 0);
//    
//    // initializing the index buffer data
//	glGenBuffers(1, &indexBufferObject);
//    
//	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBufferObject);
//	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indexData), indexData, GL_STATIC_DRAW);
//	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
//    
//    /* ----------------------------------------------------------------------------------------------------------------------*/
//    /* ------------------------------------------------- VERTEX ARRAY OBJECST INITITALIZATION -------------------------------*/
//    /* ----------------------------------------------------------------------------------------------------------------------*/
//    
//	// initializing the first vertex array object
//	glGenVertexArraysOES(1, &vaoObject);
//	glBindVertexArrayOES(vaoObject);
//    
//	size_t colorDataOffset = sizeof(float) * 3 * numberOfVertices;
//    
//	glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObject);
//	glEnableVertexAttribArray(GLKVertexAttribPosition);
//	glEnableVertexAttribArray(GLKVertexAttribColor);
//	glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, 0);
//	glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, (void*)colorDataOffset);
//	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBufferObject);
//    
//	glBindVertexArrayOES(0);
//    
////    // initializing the second vertex array object
////	glGenVertexArraysOES(1, &vaoObject2);
////	glBindVertexArrayOES (vaoObject2);
////    
////	size_t posDataOffset = sizeof(float) * 3 * (numberOfVertices/2);
////	colorDataOffset += sizeof(float) * 4 * (numberOfVertices/2);
////    
////	//Use the same buffer object previously bound to GL_ARRAY_BUFFER.
////	glEnableVertexAttribArray(GLKVertexAttribPosition);
////	glEnableVertexAttribArray(GLKVertexAttribColor);
////	glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, (void*)posDataOffset);
////	glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, (void*)colorDataOffset);
////	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBufferObject);
////    
////	glBindVertexArrayOES (0);
//    
//
    /* ----------------------------------------------------------------------------------------------------------------------*/
    /* ------------------------------------------------- OPENGL STATES INITIALIZATION-------- -------------------------------*/
    /* ----------------------------------------------------------------------------------------------------------------------*/
    
	//some general opengl initialization
    glEnable(GL_CULL_FACE);
	glFrontFace(GL_CCW);
    glCullFace(GL_BACK);
    
	glEnable(GL_DEPTH_TEST);
	glDepthMask(GL_TRUE);
	glDepthFunc(GL_LEQUAL);
	glDepthRangef(0.0f, 1.0f);
}
//used to calculate the camera position based on our spherical coordinates
glm::vec3 ResolveCamPosition()
{
	float phi = DegToRad(g_sphereCamRelPos.x);
	float theta = DegToRad(g_sphereCamRelPos.y + 90.0f);
    
	float fSinTheta = sinf(theta);
	float fCosTheta = cosf(theta);
	float fCosPhi = cosf(phi);
	float fSinPhi = sinf(phi);
    
	glm::vec3 dirToCamera(fSinTheta * fCosPhi, fCosTheta, fSinTheta * fSinPhi);
	return (dirToCamera * g_sphereCamRelPos.z) + g_camTarget;
}

void Open:: setMatrices()
{
	const glm::vec3 &camPos = ResolveCamPosition();
	worldToCameraMatrix = glm::lookAt(camPos, g_camTarget, glm::vec3(0.0f, 1.0f, 0.0f));
    prog.setUniform("modelToWorldMatrix", modelToWorldMatrix);
	prog.setUniform("worldToCameraMatrix", worldToCameraMatrix);
	prog.setUniform("cameraToClipMatrix", cameraToClipMatrix);
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
    
    
    //render 4 teapots
	float dist = 0.0f;
    for( int i = 0 ; i < 4; i++ ) {
		prog.setUniform("fragmentColor", glm::vec4(1.0f-i*0.2f,1.0f-i*0.2f,1.0f-i*0.2f,1.0f));
        modelToWorldMatrix = mat4(1.0f);
        modelToWorldMatrix *= glm::translate(vec3(dist * 0.6f - 1.0f,0.0f,-dist));
        modelToWorldMatrix *= glm::rotate(-90.0f, vec3(1.0f,0.0f,0.0f));
        setMatrices();
        teapot->render();
        dist += 7.0f;
    }
    
	//render the plane
	prog.setUniform("fragmentColor", glm::vec4(0,0,1,1));
    modelToWorldMatrix = mat4(1.0f);
    setMatrices();
    plane->render();
    
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
        case 'w': g_camTarget.z -= 0.4f; break;
        case 's': g_camTarget.z += 0.4f; break;
        case 'd': g_camTarget.x += 0.4f; break;
        case 'a': g_camTarget.x -= 0.4f; break;
        case 'e': g_camTarget.y -= 0.4f; break;
        case 'q': g_camTarget.y += 0.4f; break;
        case 'W': g_camTarget.z -= 0.4f; break;
        case 'S': g_camTarget.z += 0.4f; break;
        case 'D': g_camTarget.x += 0.4f; break;
        case 'A': g_camTarget.x -= 0.4f; break;
        case 'E': g_camTarget.y -= 0.4f; break;
        case 'Q': g_camTarget.y += 0.4f; break;
        case 'i': g_sphereCamRelPos.y -= 1.125f; break;
        case 'k': g_sphereCamRelPos.y += 1.125f; break;
        case 'j': g_sphereCamRelPos.x -= 1.125f; break;
        case 'l': g_sphereCamRelPos.x += 1.125f; break;
        case 'o': g_sphereCamRelPos.z -= 0.5f; break;
        case 'u': g_sphereCamRelPos.z += 0.5f; break;
        case 'I': g_sphereCamRelPos.y -= 1.125f; break;
        case 'K': g_sphereCamRelPos.y += 1.125f; break;
        case 'J': g_sphereCamRelPos.x -= 1.125f; break;
        case 'L': g_sphereCamRelPos.x += 1.125f; break;
        case 'O': g_sphereCamRelPos.z -= 0.5f; break;
        case 'U': g_sphereCamRelPos.z += 0.5f; break;
            
	}
    
	g_sphereCamRelPos.y = glm::clamp(g_sphereCamRelPos.y, -78.75f, -1.0f);
	g_camTarget.y = g_camTarget.y > 0.0f ? g_camTarget.y : 0.0f;
	g_sphereCamRelPos.z = g_sphereCamRelPos.z > 5.0f ? g_sphereCamRelPos.z : 5.0f;
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

