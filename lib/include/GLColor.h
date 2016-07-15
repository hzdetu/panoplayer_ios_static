//
//  GLColor.h
//  PanoPlayer
//
//  Created by qiruisun on 15/9/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wobjc-missing-property-synthesis"

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>


void CGRectGetGLCoords(CGRect rect, GLfloat *coords);
void GLLoadCATransform3D(CATransform3D transform);

@interface UIColor (GL)

- (void)getGLComponents:(GLfloat *)rgba;
- (void)bindGLClearColor;
- (void)bindGLColor;

@end


