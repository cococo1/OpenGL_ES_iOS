//
//  File.cpp
//  GLSampe1
//
//  Created by Maxim Chetrusca on 5/11/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//

#include "File.h"
//#include <iostream>
//#include <fstream>

//using namespace std;
Open::Open()
{
    blendingType = 0;
//        NSLog(@"Open created");
 
}

Open::~Open(){}

//void Open::init()
//{
//	//////////////////////////////////////////////////////
//    /////////// Vertex shader //////////////////////////
//    //////////////////////////////////////////////////////
//    GLchar* vertShaderFile =  (GLchar*)[[[NSBundle mainBundle] pathForResource:@"basic"
//                                                    ofType:@"vert"] UTF8String];
//    GLchar * shaderCode;
//
//    // Load contents of file into shaderCode hereÖ
//    ifstream inFile( vertShaderFile, ifstream::in );
//    if( !inFile ) {
//        NSLog(@"Error opening file: shader/basic.vert\n" );
////        fprintf(stderr, "Error opening file: shader/basic.vert\n" );
//        exit(1);
//    }
//    
//    shaderCode = (char *)malloc(10000);
//    int i = 0;
//    while( inFile.good() ) {
//        int c = inFile.get();
//        shaderCode[i++] = c;
//    }
//    inFile.close();
//    shaderCode[i++] = '\0';
//    ////////////////////////////////////////////
//    
//    // Create the shader object
//    GLuint vertShader = glCreateShader( GL_VERTEX_SHADER );
//    if( 0 == vertShader )
//    {
//        NSLog(@"Error creating vertex shader.\n");
//        exit(1);
//    }
//    
//    // Load the source code into the shader object
//    const GLchar* codeArray[] = {shaderCode};
//    glShaderSource( vertShader, 1, codeArray, NULL );
//    free(shaderCode); // can be removed from book.
//    
//    // Compile the shader
//    glCompileShader( vertShader );
//    
//    // Check compilation status
//    GLint result;
//    glGetShaderiv( vertShader, GL_COMPILE_STATUS, &result );
//    if( GL_FALSE == result )
//    {
//        NSLog(@"Vertex shader compilation failed!");
////        fprintf( stderr, "Vertex shader compilation failed!\n" );
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
//            NSLog(@"Shader log: \n%s", log);
////            fprintf(stderr, "Shader log: \n%s", log);
//            
//            free(log);
//        }
//    }
//    
//    //////////////////////////////////////////////////////
//    /////////// Fragment shader //////////////////////////
//    //////////////////////////////////////////////////////
//    
//    //GLchar * shaderCode;
//    
//    GLchar* fragShaderFile =  (GLchar*)[[[NSBundle mainBundle] pathForResource:@"basic"
//                                                                        ofType:@"frag"] UTF8String];
//    
//    // Load contents of file into shaderCode hereÖ
//    ifstream fragFile( fragShaderFile, ifstream::in );
//    if( !fragFile ) {
//        NSLog(@"Error opening file: shader/basic.frag\n");
////        fprintf(stderr, "Error opening file: shader/basic.frag\n" );
//        exit(1);
//    }
//    
//    shaderCode = (char *)malloc(10000);
//    i = 0;
//    while( fragFile.good() ) {
//        int c = fragFile.get();
//        shaderCode[i++] = c;
//    }
//    inFile.close();
//    shaderCode[i++] = '\0';
//    ////////////////////////////////////////////
//    
//    // Create the shader object
//    GLuint fragShader = glCreateShader( GL_FRAGMENT_SHADER );
//    if( 0 == fragShader )
//    {
//        NSLog(@"Error creating fragment shader.\n");
////        fprintf(stderr, "Error creating fragment shader.\n");
//        exit(1);
//    }
////    NSLog(@"compile");
//    // Load the source code into the shader object
//    //const GLchar* codeArray[] = {shaderCode};
//    codeArray[0] = shaderCode;
//    glShaderSource( fragShader, 1, codeArray, NULL );
//    free(shaderCode); // can be removed from book.
//    
//    // Compile the shader
//    glCompileShader( fragShader );
//    
//    // Check compilation status
//    //GLint result;
//    glGetShaderiv( fragShader, GL_COMPILE_STATUS, &result );
//    if( GL_FALSE == result )
//    {
//        
//        NSLog(@"Fragment shader compilation failed!\n");
////        fprintf( stderr, "Fragment shader compilation failed!\n" );
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
//            NSLog(@"Shader log: \n%s", log );
////            fprintf(stderr, "Shader log: \n%s", log);
//            
//            free(log);
//        }
//    }
//    
//    
//    
//	// Create the program object
//    theProgram= glCreateProgram();
//    if( 0 == theProgram )
//    {
//        NSLog(@"Error creating program object.\n");
////        fprintf(stderr, "Error creating program object.\n");
//        exit(1);
//    }
//    
//    // Attach the shaders to the program object
//    glAttachShader( theProgram, vertShader );
//    glAttachShader( theProgram, fragShader );
//    
//    // Link the program
//    glLinkProgram( theProgram );
//    
//    // Check for successful linking
//    GLint status;
//    glGetProgramiv( theProgram, GL_LINK_STATUS, &status );
//    if( GL_FALSE == status ) {
//        
//        NSLog(@"Failed to link shader program!\n");
////        fprintf( stderr, "Failed to link shader program!\n" );
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
//            NSLog(@"Program log: \n%s", log );
////            fprintf(stderr, "Program log: \n%s", log);
//            
//            free(log);
//        }
//    }
//    else
//    {
//        glUseProgram( theProgram );
//    }
//    
//    
//    glGenBuffers(1, &positionBufferObject);
//    
//	glBindBuffer(GL_ARRAY_BUFFER, positionBufferObject);
//	glBufferData(GL_ARRAY_BUFFER, sizeof(vertexPositions), vertexPositions, GL_STATIC_DRAW);
//	glBindBuffer(GL_ARRAY_BUFFER, 0);
//}

void Open::render()
{
	//calc fps & update title bar
//	fpsTimer.AdvanceTime();
//	fpsCount++;
//	if(fpsTimer.GetElapsedTime()>1)
//	{
//		char tempBuf[512];
//		sprintf(tempBuf,"(%d fps) Shaders Sample 1 - First Shader App",fpsCount);
//		glutSetWindowTitle(tempBuf);
//		fpsTimer.Reset();
//		fpsCount=0;
//	}
    
    
	switch(blendingType)
	{
		case 0:
            glEnable(GL_BLEND);
//            glEnable(GL_BLEND,0);
            glBlendEquationSeparate(GL_FUNC_ADD, GL_FUNC_ADD);
            glBlendFuncSeparate(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ZERO);
            break;
            
		case 1:
//            glEnablei(GL_BLEND,0);
            glEnable(GL_BLEND);
            glBlendEquationSeparate(GL_FUNC_ADD, GL_FUNC_ADD);
            glBlendFuncSeparate(GL_ONE, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ZERO);
            break;
            
		case 2:
//            glDisablei(GL_BLEND,0);
            glDisable(GL_BLEND);
            break;
	}
    
	glClearColor(0.0f, 1.0f, 0.4f, 0.3f);
	glClear(GL_COLOR_BUFFER_BIT);
    
	glUseProgram(theProgram);
    
	glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObject);
	glEnableVertexAttribArray(GLKVertexAttribPosition);
	glVertexAttribPointer(GLKVertexAttribPosition, 4, GL_FLOAT, GL_FALSE, 0, 0);
    
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, (void*)96);
    
	glDrawArrays(GL_TRIANGLES, 0, 6);
    
	glDisableVertexAttribArray(GLKVertexAttribPosition);
    glDisableVertexAttribArray(GLKVertexAttribColor);
	glUseProgram(0);
    
//	glutSwapBuffers();
}

void Open::keyboard(unsigned char key, int x, int y)
{
	if(key==VK_SPACE)
	{
		blendingType++;
		if(blendingType>2)
		{
			blendingType=0;
		}
	}
}

void Open:: update(int dt)
{
//	glutTimerFunc(1,update,0);
//	glutPostRedisplay();
}

void Open:: reshape(int w, int h)
{
//	glViewport(0,0,(GLsizei)w,(GLsizei)h);
}


int main1(int argc, char* argv[])
{
//	//GLUT INIT
//	glutInit(&argc, argv);
//	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA);
//	glutInitWindowSize(512,512);
//	glutCreateWindow("Triangle Test");
//	glutDisplayFunc(render);
//	glutReshapeFunc(reshape);
//	glutTimerFunc(1,update,0);
//    
//    //GLEW INIT
//    glewInit();
//    GLenum err = glewInit();
//    if (GLEW_OK != err)
//    {
//        /* Problem: glewInit failed, something is seriously wrong. */
//        cout << "glewInit failed, aborting." << endl;
//        exit (1);
//    }
//    cout << "Status: Using GLEW " << glewGetString(GLEW_VERSION) << endl;
//    
//    
//    //GET GL VERSION
//    GLint major,minor;
//    glGetIntegerv(GL_MAJOR_VERSION,&major);
//    glGetIntegerv(GL_MINOR_VERSION,&minor);
//    cout << "GL VENDOR:" << glGetString(GL_VENDOR) << endl;
//    cout << "GL RENDERER:" << glGetString(GL_RENDERER) << endl;
//    cout << "GL VERSION(string):" << glGetString(GL_VERSION) << endl;
//    cout << "GL VERSION(integer):" << major<< "." << minor << endl;
//    cout << "GL VERSION:" << glGetString(GL_SHADING_LANGUAGE_VERSION) << endl;
//    
//    
//    //GET GL EXTENSIONS
//    GLint nExtensions;
//    glGetIntegerv(GL_NUM_EXTENSIONS,&nExtensions);
//    for(int i=0;i<nExtensions;i++)
//    {
//        cout << "ext:" << glGetStringi(GL_EXTENSIONS,i) << endl;
//    }
//    
//    
//    //INIT GL RESOURCES
//    init();
//	
//    
//    //ENTER LOOP
//    glutMainLoop();
//    getchar();
    return 0;
}


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
    glBindAttribLocation(theProgram, GLKVertexAttribColor, "vertexColor");
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
    
    
    glGenBuffers(1, &vertexBufferObject);
    
	glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObject);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertexData), vertexData, GL_STATIC_DRAW);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
}
