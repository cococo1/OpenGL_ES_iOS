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
#include <glm/gtx/transform2.hpp>
#include "defines.h"
#include "glslprogram.h"
#include "vboplane.h"
#include "vboteapot.h"
#include "vbotorus.h"


using glm::mat4;
using glm::vec3;


class Open
{
private:
    GLSLProgram prog;
//    GLSLProgram prog2;
    VBOPlane *plane;
    VBOTeapot *teapot;
    VBOTorus *torus;

    float angle;
//    float scale;
    mat4 model;
    mat4 view;
    mat4 projection;
    bool useHalfwayShader;


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
//    void setMatrices();



    
    
};
#endif /* defined(__GLSampe1__File__) */
