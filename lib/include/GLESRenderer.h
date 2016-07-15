//
//  GLESRenderer.h
//  PanoPlayer
//
//  Created by qiruisun on 15/11/12.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKMath.h>
#import <GLKit/GLKit.h>
#import <UIKit/UIKit.h>

@interface GLESRenderer : NSObject

@property (nonatomic) EAGLContext *context;

- (BOOL)createFramebuffer:(CAEAGLLayer*)layer;
- (void)destroyFramebuffer;
- (void)setFramebuffer:(CAEAGLLayer*)layer;
- (BOOL)presentFramebuffer;
- (GLuint)loadShaders:(NSString*)sharder;
- (int)getGLWidth;
- (int)getGLHeight;
@end
