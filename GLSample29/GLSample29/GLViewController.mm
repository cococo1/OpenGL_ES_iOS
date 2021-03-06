//
//  GLViewController.m
//  GLSampe1
//
//  Created by Maxim Chetrusca on 5/11/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//w

#import "GLViewController.h"
#include "File.h"

@interface GLViewController()
{
//    Open* FAFmain;
}
@property (strong, nonatomic) EAGLContext *context;
@property (nonatomic) Open *FAFmain;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation GLViewController
- (IBAction)touchDown:(UIButton *)sender
{
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFunction:) userInfo:sender.titleLabel.text repeats:YES];
}
- (IBAction)touchUpInside:(UIButton *)sender
{
    [self.timer invalidate];
    self.timer = nil;
    char c = [sender.titleLabel.text characterAtIndex:0];
    
//    self.FAFmain->keyboard(c, 0, 0);
}

-(void)timerFunction:(NSTimer*)timer
{
    char c = [timer.userInfo characterAtIndex:0];

//    self.FAFmain->keyboard(c, 0, 0);
}
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
        self.FAFmain->keyboard(32, 0, 0);
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
    self.FAFmain->update(0);
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
