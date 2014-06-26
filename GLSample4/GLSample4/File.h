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
    
};
//cTimer fpsTimer;
//GLuint theProgram;


class Open
{
private:
    GLuint theProgram;
    GLuint  vertexBufferObject;





public:
    Open();
    virtual ~Open();
    void init();
    void render(float elapsedTime);
    void update(int dt);
    void reshape(int w, int h);
//    int main1(int argc, char* argv[]);
//    void keyboard(unsigned char key, int x, int y);
    void ComputePositionOffsets(float &fXOffset, float &fYOffset, float elapsedTime);
    void AdjustVertexData(float fXOffset, float fYOffset);


    
    
};
#endif /* defined(__GLSampe1__File__) */
