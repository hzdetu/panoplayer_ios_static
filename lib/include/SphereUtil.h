//
//  SphereUtil.h
//  PanoPlayer
//
//  Created by qiruisun on 15/8/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLVector3D.h"




@interface SphereUtil : NSObject

@property float dx;
@property float dy;
@property float dz;

-(void)Rotation:(GLVector3D*)v radians:(float)radians b:(GLVector3D*)b;

-(id)initWithWidthAndHeight:(int)w h:(float)h;
-(void)cal_sphere_xyz:(int)px py:(int)py;

@end
