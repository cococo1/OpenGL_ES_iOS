//
//  OpenGLViewController.m
//  GL_Bullet_test
//
//  Created by Maxim Chetrusca on 5/5/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//

#import "OpenGLViewController.h"
//#import <GLKit/GLKit.h>
//#import "File.h"
#import "File2.h"
//#include "glslprogram.h"


@interface OpenGLViewController ()
{
//    GLuint _program;

}

@property (strong, nonatomic) EAGLContext *context;
//@property (strong, nonatomic) GLKBaseEffect *effect;


@property (nonatomic) OpenGL *opengl;
@property (nonatomic) GLSLProgram *prog;



@end



@implementation OpenGLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
//    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    self.opengl = new OpenGL1();
    
    self.prog = (GLSLProgram*)self.opengl->getProgram();
    
    [self loadContext];
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
   

    
//
//	// Do any additional setup after loading the view.
}


-(void) loadContext
{
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
}

//-(void) 
//{
//    [self loadContext];
//    
//
//}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    

    self.prog->compileShaderFromFile(NULL,GLSLShader::VERTEX);
    self.prog->use();
    
    
    
    self.opengl->init();

}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
//    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
//    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
//    
//    glBindVertexArrayOES(_vertexArray);
//    
//    // Render the object with GLKit
//    [self.effect prepareToDraw];
//    
//    glDrawArrays(GL_TRIANGLES, 0, 36);
//    
//    // Render the object again with ES2
//    glUseProgram(_program);
//    
//    glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX], 1, 0, _modelViewProjectionMatrix.m);
//    glUniformMatrix3fv(uniforms[UNIFORM_NORMAL_MATRIX], 1, 0, _normalMatrix.m);
//    
//    glDrawArrays(GL_TRIANGLES, 0, 36);
    self.opengl->render();
}

-(GLKMatrix4) glkMatrixFromGlm:(glm::mat4)m
{
    return GLKMatrix4Make(m[0][0], m[0][1], m[0][2], m[0][3],
                   m[1][0], m[1][1], m[1][2], m[1][3],
                   m[2][0], m[2][1], m[2][2], m[2][3],
                   m[3][0], m[3][1], m[3][2], m[3][3]);
}

-(void) update
{
    self.opengl->update(0);
//    glm::mat4 projection = self.opengl->getProjectionMatrix();
//    glm::mat4 model = self.opengl->getModelMatrix();

//    self.effect.transform.projectionMatrix = [self glkMatrixFromGlm:projection];
//    self.effect.transform.modelviewMatrix = [self glkMatrixFromGlm:model];
//    self.effect.transform.modelviewMatrix = [self glkMatrixFromGlm:model];




}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    
//    glDeleteBuffers(1, &_vertexBuffer);
//    glDeleteVertexArraysOES(1, &_vertexArray);
    
//    self.effect = nil;
    
    if (self.prog->getHandle()) {
        glDeleteProgram(self.prog->getHandle());
    }
}


- (void)didReceiveMemoryWarning
{
    NSLog(@"did receive memory warning");
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }
//    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"view appeared");
}



@end
