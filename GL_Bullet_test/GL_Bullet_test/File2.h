//
//  File2.h
//  GL_Bullet_test
//
//  Created by Maxim Chetrusca on 5/5/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//

#ifndef __GL_Bullet_test__File2__
#define __GL_Bullet_test__File2__

//#include <iostream>
#include "File.h"
#include "glslprogram.h"

class OpenGL1 : public OpenGL
{
    
public:
    OpenGL1();
    virtual ~OpenGL1();
    OpenGL1(const OpenGL1 &copy);
    void init();
    virtual void update(int dt);
    virtual void setMatrices();
    virtual void render();
    virtual void reshape(int width, int height);
    virtual void keyboard (unsigned char key, int x, int y);
    virtual void getGlVersion(int *major, int *minor);
    virtual void getGlslVersion(int *major, int *minor);
    virtual int main(int argc, char* argv[]);
    virtual void* getProgram();
//    virtual mat4 getProjectionMatrix();
//    virtual mat4 getModelMatrix();
//    virtual mat4 getViewMatrix();

};

#endif /* defined(__GL_Bullet_test__File2__) */
