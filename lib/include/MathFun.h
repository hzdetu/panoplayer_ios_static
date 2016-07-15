//
//  OpenGLPicking.h
//  RouteTest
//
//  Created by admin on 13-12-24.
//  Copyright (c) 2013年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <OpenGLES/ES1/gl.h>

#define TODEGRESS(a) a * 180.0f/M_PI
#define TORADIANS(a) a * M_PI/180.0f

@interface MathFun : NSObject

+(GLboolean)gluProject:(const GLfloat *)obj :(const GLfloat *)model :(const GLint *)viewport :(GLfloat *)win;
+(GLboolean)gluUnProject:(const GLfloat *)win :(const GLfloat *)model :(const GLint *)viewport :(GLfloat *)obj;
+(void)point3DToDeg:(const float *)inP :(float *)outP;
+(void)degToPoint3D:(const float *)inP :(float *)outP;
+(void)matrix33ToEuler:(const float *)inP :(float *)outP;
+(void)eulerToMatrix33:(const float *)inP :(float *)outP;
+(void)eulerToMatrix44:(const float *)inP :(float *)outP;
+(void)quaternionToEuler:(const float *)inP :(float *)outP;

+(float)calDeg:(const float *)v1 :(const float *)v2;

+(float)tranfromAth:(float)ath;
+(float)tranfromAth_Dre:(float)ath;


@end
