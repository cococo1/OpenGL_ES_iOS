//
//  File.h
//  GL_Bullet_test
//
//  Created by Maxim Chetrusca on 5/5/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//

#ifndef __GL_Bullet_test__File__
#define __GL_Bullet_test__File__

//#include <iostream>
//#include "glslprogram.h"
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtx/transform2.hpp>
class OpenGL
{

    
public:
    OpenGL();
    virtual ~OpenGL();
    OpenGL(const OpenGL &copy);
    
    virtual void init() = 0;
    virtual void update(int dt) = 0;
    virtual void setMatrices() = 0;
    virtual void render() = 0;
    virtual void reshape(int width, int height) = 0;
    virtual void keyboard (unsigned char key, int x, int y) = 0;
    virtual void getGlVersion(int *major, int *minor) = 0;
    virtual void getGlslVersion(int *major, int *minor) = 0;
//The so-called main - implement everything here than call it from the real main
    virtual int main(int argc, char* argv[]) = 0;
    virtual void* getProgram() = 0;
//    virtual glm::mat4 getProjectionMatrix() = 0;
//    virtual glm::mat4 getModelMatrix() = 0;
//    virtual glm::mat4 getViewMatrix() = 0;




    
};

#endif /* defined(__GL_Bullet_test__File__) */
