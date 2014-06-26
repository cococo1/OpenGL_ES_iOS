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

#define VK_SPACE 1

//#include <iostream>


const float vertexData[] = {
    0.0f,    0.5f, 0.0f, 1.0f,
    0.5f, -0.366f, 0.0f, 1.0f,
    -0.5f, -0.366f, 0.0f, 1.0f,
    0.3f,    0.8f, 0.0f, 1.0f,
    0.8f, -0.066f, 0.0f, 1.0f,
    -0.2f, -0.066f, 0.0f, 1.0f,
    1.0f,    0.0f, 0.0f, 1.0f,
    0.0f,    1.0f, 0.0f, 1.0f,
    0.0f,    0.0f, 1.0f, 1.0f,
    1.0f,    0.0f, 0.0f, 1.0f,
    0.0f,    1.0f, 0.0f, 1.0f,
    0.0f,    0.0f, 1.0f, 1.0f,
};
//cTimer fpsTimer;
//GLuint theProgram;


class Open
{
private:
    GLuint theProgram;
    GLuint  vertexBufferObject;
    int blendingType;





public:
    Open();
    virtual ~Open();
    void init();
    void render();
    void update(int dt);
    void reshape(int w, int h);
    int main1(int argc, char* argv[]);
    void keyboard(unsigned char key, int x, int y);
    
    
};
#endif /* defined(__GLSampe1__File__) */
