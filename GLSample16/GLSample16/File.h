//
//  File.h
//  GLSampe1
//
//  Created by Maxim Chetrusca on 5/11/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//

#ifndef __GLSampe1__File__
#define __GLSampe1__File__
#import <GLKit/GLKit.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <stack>
#include <vector>
#include "math.h"



#define ARRAY_COUNT( array ) (sizeof( array ) / (sizeof( array[0] ) * (sizeof( array ) != sizeof(void*) || sizeof( array[0] ) <= sizeof(void*))))

#define VK_SPACE 1

const int numberOfVertices = 24;

//#define RIGHT_EXTENT 0.8f
//#define LEFT_EXTENT -RIGHT_EXTENT
//#define TOP_EXTENT 0.20f
//#define MIDDLE_EXTENT 0.0f
//#define BOTTOM_EXTENT -TOP_EXTENT
//#define FRONT_EXTENT 0.25f
//#define REAR_EXTENT -0.25f

#define GREEN_COLOR 0.75f, 0.75f, 1.0f, 1.0f
#define BLUE_COLOR 	0.0f, 0.5f, 0.0f, 1.0f
#define RED_COLOR 1.0f, 0.0f, 0.0f, 1.0f

#define YELLOW_COLOR 1.0f, 1.0f, 0.0f, 1.0f
#define CYAN_COLOR 0.0f, 1.0f, 1.0f, 1.0f
#define MAGENTA_COLOR 	1.0f, 0.0f, 1.0f, 1.0f

//#include <iostream>


const float vertexData[] =
{
	//Front
	+1.0f, +1.0f, +1.0f,
	+1.0f, -1.0f, +1.0f,
	-1.0f, -1.0f, +1.0f,
	-1.0f, +1.0f, +1.0f,
    
	//Top
	+1.0f, +1.0f, +1.0f,
	-1.0f, +1.0f, +1.0f,
	-1.0f, +1.0f, -1.0f,
	+1.0f, +1.0f, -1.0f,
    
	//Left
	+1.0f, +1.0f, +1.0f,
	+1.0f, +1.0f, -1.0f,
	+1.0f, -1.0f, -1.0f,
	+1.0f, -1.0f, +1.0f,
    
	//Back
	+1.0f, +1.0f, -1.0f,
	-1.0f, +1.0f, -1.0f,
	-1.0f, -1.0f, -1.0f,
	+1.0f, -1.0f, -1.0f,
    
	//Bottom
	+1.0f, -1.0f, +1.0f,
	+1.0f, -1.0f, -1.0f,
	-1.0f, -1.0f, -1.0f,
	-1.0f, -1.0f, +1.0f,
    
	//Right
	-1.0f, +1.0f, +1.0f,
	-1.0f, -1.0f, +1.0f,
	-1.0f, -1.0f, -1.0f,
	-1.0f, +1.0f, -1.0f,
    
    
	GREEN_COLOR,
	GREEN_COLOR,
	GREEN_COLOR,
	GREEN_COLOR,
    
	BLUE_COLOR,
	BLUE_COLOR,
	BLUE_COLOR,
	BLUE_COLOR,
    
	RED_COLOR,
	RED_COLOR,
	RED_COLOR,
	RED_COLOR,
    
	YELLOW_COLOR,
	YELLOW_COLOR,
	YELLOW_COLOR,
	YELLOW_COLOR,
    
	CYAN_COLOR,
	CYAN_COLOR,
	CYAN_COLOR,
	CYAN_COLOR,
    
	MAGENTA_COLOR,
	MAGENTA_COLOR,
	MAGENTA_COLOR,
	MAGENTA_COLOR,
    
};
//cTimer fpsTimer;
//GLuint theProgram;

const GLshort indexData[] =
{
	0, 1, 2,
	2, 3, 0,
    
	4, 5, 6,
	6, 7, 4,
    
	8, 9, 10,
	10, 11, 8,
    
	12, 13, 14,
	14, 15, 12,
    
	16, 17, 18,
	18, 19, 16,
    
	20, 21, 22,
	22, 23, 20,
    
};

//namespace Open
//{
//
//
//    
//    
//
//    //    void ComputePositionOffsets(float &fXOffset, float &fYOffset, float elapsedTime);
//    //    void AdjustVertexData(float fXOffset, float fYOffset);
//   
//
//}

class OpenGL
{
private:
    
    
    
    
    
    
    
public:

    
    
    OpenGL();
    virtual ~OpenGL();
    void init();
    void render(float elapsedTime);
    void update(int dt);
    void reshape(int w, int h);
    //    int main1(int argc, char* argv[]);
    void keyboard(unsigned char key, int x, int y);
    
    
    
    
    
};


#endif /* defined(__GLSampe1__File__) */
