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
#include <glm/gtc/quaternion.hpp>

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
#define PI 3.14159265358979323846
#define Deg2Rad(DEG) ((DEG)*((PI)/(180.0)))


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
//


class Open
{
private:
//    VBOPlane *plane;
//    VBOTeapot *teapot;
    mat4 modelToWorldMatrix;
    mat4 worldToCameraMatrix;
    mat4 cameraToClipMatrix;
//    float angle;
    glm::mat4 orientationMatrix;
    glm::fquat g_orientation;




//    
//    //position of the camera in spherical coordinates
//     glm::vec3 g_sphereCamRelPos;
//    //the position our camera looks at
//     glm::vec3 g_camTarget;
//    
//    float angY,angX,angZ;
//    glm::mat4 xRotMatrix, yRotMatrix, zRotMatrix;
    GLuint cubeVertexBufferObject;
//    GLuint gimbalVertexBufferObject;

    
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
//    void drawGimbalZ(float elapsedTime);
//    void drawGimbalY(float elapsedTime);
//    void drawGimbalX(float elapsedTime);
//    void GenerateCircleGeometry();
    void OffsetOrientation(const glm::vec3 &_axis, float fAngDeg);




    
    
};
#endif /* defined(__GLSampe1__File__) */
