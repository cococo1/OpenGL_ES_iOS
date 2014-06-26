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

//#include <iostream>


const float vertexPositions[] = {
	0.75f, 0.75f, 0.0f, 1.0f,
	0.75f, -0.75f, 0.0f, 1.0f,
	-0.75f, -0.75f, 0.0f, 1.0f,
};

//cTimer fpsTimer;
//GLuint theProgram;


class Open
{
private:
    GLuint theProgram;
    GLuint positionBufferObject;




public:
    Open();
    virtual ~Open();
    void init();
    void render();
    void update(int dt);
    void reshape(int w, int h);
    int main1(int argc, char* argv[]);
    
};
#endif /* defined(__GLSampe1__File__) */
