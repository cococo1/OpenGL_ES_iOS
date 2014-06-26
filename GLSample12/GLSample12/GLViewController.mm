//
//  GLViewController.m
//  GLSampe1
//
//  Created by Maxim Chetrusca on 5/11/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//

#import "GLViewController.h"
#include "File.h"

@interface GLViewController()
{
//    Open* FAFmain;
}
@property (strong, nonatomic) EAGLContext *context;
@property (nonatomic) Open *FAFmain;

@end

@implementation GLViewController


-(void) setupGL
{
    //    NSString* file = [[NSBundle mainBundle] pathForResource:@"basic"
    //                                                     ofType:@"vert"];
    //    NSLog(@"%@",file);
    
    
    self.FAFmain = new Open();
    
    self.context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    
    self.preferredFramesPerSecond = 60;
    [EAGLContext setCurrentContext:self.context];
    
    self.FAFmain->init(); // self setupGL
}


-(void) tap:(UIGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        NSLog(@"tap");
        self.FAFmain->keyboard(1, 0, 0);
    }
}

-(void) viewDidLoad
{
//    NSLog(@"we");
    [super viewDidLoad];
    
    [self setupGL];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];

}

-(void) glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    self.FAFmain->render(self.timeSinceFirstResume);
}

-(void) update
{
    self.FAFmain->reshape(self.view.bounds.size.width, self.view.bounds.size.height);
//    float aspect = fabsf(self.view.bounds.size.width/self.view.bounds.size.height);
}

-(void) tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
}

-(void) viewDidUnload
{
    [super viewDidUnload];
    
    if ([EAGLContext currentContext] == self.context)
    {
        [EAGLContext setCurrentContext:nil];
    }
    self.context = nil;
    [self tearDownGL];
}

@end
