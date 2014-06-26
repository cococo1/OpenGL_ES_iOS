//
//  GLSLProgramHelper.h
//  GL_Bullet_test
//
//  Created by Maxim Chetrusca on 5/6/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

enum GLSLShaderType {
    VERTEX, FRAGMENT,
    GEOMETRY,
    TESS_CONTROL,
    TESS_EVALUATION
};

@interface GLSLProgramHelper : NSObject

- (BOOL)loadShaders;
- (BOOL)loadShaderFromFile:(const char*)filename withType:(GLuint)type;


- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;


@property (nonatomic) GLuint program;


@end
