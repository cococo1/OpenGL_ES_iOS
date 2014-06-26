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
//#include <glm/gtx/transform2.hpp>
#include <vector>
#include "math.h"
//#include "defines.h"
#include "glslprogram.h"
//#include "vboplane.h"
//#include "vboteapot.h"

using glm::mat4;
using glm::vec3;

#define ARRAY_COUNT( array ) (sizeof( array ) / (sizeof( array[0] ) * (sizeof( array ) != sizeof(void*) || sizeof( array[0] ) <= sizeof(void*))))


//3D CUBE Vertex and Color data
const float cubeVertexData[] = {
    0.25f,  0.25f, 0.25f, 1.0f,
    0.25f, -0.25f, 0.25f, 1.0f,
	-0.25f,  0.25f, 0.25f, 1.0f,
    
    0.25f, -0.25f, 0.25f, 1.0f,
	-0.25f, -0.25f, 0.25f, 1.0f,
	-0.25f,  0.25f, 0.25f, 1.0f,
    
    0.25f,  0.25f, -0.25f, 1.0f,
	-0.25f,  0.25f, -0.25f, 1.0f,
    0.25f, -0.25f, -0.25f, 1.0f,
    
    0.25f, -0.25f, -0.25f, 1.0f,
	-0.25f,  0.25f, -0.25f, 1.0f,
	-0.25f, -0.25f, -0.25f, 1.0f,
    
	-0.25f,  0.25f, 0.25f, 1.0f,
	-0.25f, -0.25f, 0.25f, 1.0f,
	-0.25f, -0.25f, -0.25f, 1.0f,
    
	-0.25f,  0.25f, 0.25f, 1.0f,
	-0.25f, -0.25f, -0.25f, 1.0f,
	-0.25f,  0.25f, -0.25f, 1.0f,
    
    0.25f,  0.25f, 0.25f, 1.0f,
    0.25f, -0.25f, -0.25f, 1.0f,
    0.25f, -0.25f, 0.25f, 1.0f,
    
    0.25f,  0.25f, 0.25f, 1.0f,
    0.25f,  0.25f, -0.25f, 1.0f,
    0.25f, -0.25f, -0.25f, 1.0f,
    
    0.25f,  0.25f, -0.25f, 1.0f,
    0.25f,  0.25f, 0.25f, 1.0f,
	-0.25f,  0.25f, 0.25f, 1.0f,
    
    0.25f,  0.25f, -0.25f, 1.0f,
	-0.25f,  0.25f, 0.25f, 1.0f,
	-0.25f,  0.25f, -0.25f, 1.0f,
    
    0.25f, -0.25f, -0.25f, 1.0f,
	-0.25f, -0.25f, 0.25f, 1.0f,
    0.25f, -0.25f, 0.25f, 1.0f,
    
    0.25f, -0.25f, -0.25f, 1.0f,
	-0.25f, -0.25f, -0.25f, 1.0f,
	-0.25f, -0.25f, 0.25f, 1.0f,
    
	0.0f, 0.0f, 1.0f, 1.0f,
	0.0f, 0.0f, 1.0f, 1.0f,
	0.0f, 0.0f, 1.0f, 1.0f,
    
	0.0f, 0.0f, 1.0f, 1.0f,
	0.0f, 0.0f, 1.0f, 1.0f,
	0.0f, 0.0f, 1.0f, 1.0f,
    
	0.0f, 0.0f, 0.9f, 1.0f,
	0.0f, 0.0f, 0.9f, 1.0f,
	0.0f, 0.0f, 0.9f, 1.0f,
    
	0.0f, 0.0f, 0.9f, 1.0f,
	0.0f, 0.0f, 0.9f, 1.0f,
	0.0f, 0.0f, 0.9f, 1.0f,
    
	0.0f, 0.0f, 0.8f, 1.0f,
	0.0f, 0.0f, 0.8f, 1.0f,
	0.0f, 0.0f, 0.8f, 1.0f,
    
	0.0f, 0.0f, 0.8f, 1.0f,
	0.0f, 0.0f, 0.8f, 1.0f,
	0.0f, 0.0f, 0.8f, 1.0f,
    
	0.0f, 0.0f, 0.7f, 1.0f,
	0.0f, 0.0f, 0.7f, 1.0f,
	0.0f, 0.0f, 0.7f, 1.0f,
    
	0.0f, 0.0f, 0.7f, 1.0f,
	0.0f, 0.0f, 0.7f, 1.0f,
	0.0f, 0.0f, 0.7f, 1.0f,
    
	0.0f, 0.0f, 0.6f, 1.0f,
	0.0f, 0.0f, 0.6f, 1.0f,
	0.0f, 0.0f, 0.6f, 1.0f,
    
	0.0f, 0.0f, 0.6f, 1.0f,
	0.0f, 0.0f, 0.6f, 1.0f,
	0.0f, 0.0f, 0.6f, 1.0f,
    
	0.0f, 0.0f, 0.5f, 1.0f,
	0.0f, 0.0f, 0.5f, 1.0f,
	0.0f, 0.0f, 0.5f, 1.0f,
    
	0.0f, 0.0f, 0.5f, 1.0f,
	0.0f, 0.0f, 0.5f, 1.0f,
	0.0f, 0.0f, 0.5f, 1.0f,
    
};

//3D gimbals vertex and color data
static const int circleTesselation=32;

//const int numberOfVertices = 18;
//
//#define RIGHT_EXTENT 0.8f
//#define LEFT_EXTENT -RIGHT_EXTENT
//#define TOP_EXTENT 0.20f
//#define MIDDLE_EXTENT 0.0f
//#define BOTTOM_EXTENT -TOP_EXTENT
//#define FRONT_EXTENT 0.25f
//#define REAR_EXTENT -0.25f
//
//#define GREEN_COLOR 0.75f, 0.75f, 1.0f, 1.0f
//#define BLUE_COLOR 	0.0f, 0.5f, 0.0f, 1.0f
//#define RED_COLOR 1.0f, 0.0f, 0.0f, 1.0f
//#define GREY_COLOR 0.8f, 0.8f, 0.8f, 1.0f
//#define BROWN_COLOR 0.5f, 0.5f, 0.0f, 1.0f
//
////#include <iostream>
//
//
//const float vertexData[] = {
//	//Object 1 positions
//	LEFT_EXTENT,	TOP_EXTENT,		REAR_EXTENT,
//	LEFT_EXTENT,	MIDDLE_EXTENT,	FRONT_EXTENT,
//	RIGHT_EXTENT,	MIDDLE_EXTENT,	FRONT_EXTENT,
//	RIGHT_EXTENT,	TOP_EXTENT,		REAR_EXTENT,
//    
//	LEFT_EXTENT,	BOTTOM_EXTENT,	REAR_EXTENT,
//	LEFT_EXTENT,	MIDDLE_EXTENT,	FRONT_EXTENT,
//	RIGHT_EXTENT,	MIDDLE_EXTENT,	FRONT_EXTENT,
//	RIGHT_EXTENT,	BOTTOM_EXTENT,	REAR_EXTENT,
//    
//	LEFT_EXTENT,	TOP_EXTENT,		REAR_EXTENT,
//	LEFT_EXTENT,	MIDDLE_EXTENT,	FRONT_EXTENT,
//	LEFT_EXTENT,	BOTTOM_EXTENT,	REAR_EXTENT,
//    
//	RIGHT_EXTENT,	TOP_EXTENT,		REAR_EXTENT,
//	RIGHT_EXTENT,	MIDDLE_EXTENT,	FRONT_EXTENT,
//	RIGHT_EXTENT,	BOTTOM_EXTENT,	REAR_EXTENT,
//    
//	LEFT_EXTENT,	BOTTOM_EXTENT,	REAR_EXTENT,
//	LEFT_EXTENT,	TOP_EXTENT,		REAR_EXTENT,
//	RIGHT_EXTENT,	TOP_EXTENT,		REAR_EXTENT,
//	RIGHT_EXTENT,	BOTTOM_EXTENT,	REAR_EXTENT,
//    
//	//Object 1 colors
//	GREEN_COLOR,
//	GREEN_COLOR,
//	GREEN_COLOR,
//	GREEN_COLOR,
//    
//	BLUE_COLOR,
//	BLUE_COLOR,
//	BLUE_COLOR,
//	BLUE_COLOR,
//    
//	RED_COLOR,
//	RED_COLOR,
//	RED_COLOR,
//    
//	GREY_COLOR,
//	GREY_COLOR,
//	GREY_COLOR,
//    
//	BROWN_COLOR,
//	BROWN_COLOR,
//	BROWN_COLOR,
//	BROWN_COLOR,
//    
//};
////cTimer fpsTimer;
////GLuint theProgram;
//
//const GLshort indexData[] =
//{
//	0, 2, 1,
//	3, 2, 0,
//    
//	4, 5, 6,
//	6, 7, 4,
//    
//	8, 9, 10,
//	11, 13, 12,
//    
//	14, 16, 15,
//	17, 16, 14,
//    
//};

class Open
{
private:
//    VBOPlane *plane;
//    VBOTeapot *teapot;
    mat4 modelToWorldMatrix;
    mat4 worldToCameraMatrix;
    mat4 cameraToClipMatrix;
    float angle;
    float  circleVertexData[circleTesselation*192];

    
    //position of the camera in spherical coordinates
     glm::vec3 g_sphereCamRelPos;
    //the position our camera looks at
     glm::vec3 g_camTarget;
    
    float angY,angX,angZ;
    glm::mat4 xRotMatrix, yRotMatrix, zRotMatrix;
    GLuint cubeVertexBufferObject;
    GLuint gimbalVertexBufferObject;

    
    GLSLProgram prog;

////    GLuint theProgram;
//    GLuint  vertexBufferObject;
////    GLuint offsetLocation;
//    int width;
//    int height;
////    bool enableDepthClamping;
//    GLuint indexBufferObject;
//    GLuint vaoObject;
////    GLuint vaoObject2;
//    GLuint offsetUniform;
//    GLuint modelToCameraMatrixUnif;





public:
    Open();
    virtual ~Open();
    void init();
    void render(float elapsedTime);
    void update(int dt);
    void reshape(int w, int h);
    void setMatrices();
//    int main1(int argc, char* argv[]);
    void keyboard(unsigned char key, int x, int y);
//    void ComputePositionOffsets(float &fXOffset, float &fYOffset, float elapsedTime);
//    void AdjustVertexData(float fXOffset, float fYOffset);
    void drawcube1();
    void drawcube2();
    void drawGimbalZ(float elapsedTime);
    void drawGimbalY(float elapsedTime);
    void drawGimbalX(float elapsedTime);
    void GenerateCircleGeometry();



    
    
};
#endif /* defined(__GLSampe1__File__) */
