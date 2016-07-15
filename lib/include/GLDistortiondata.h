//
//  GLDistortiondata.h
//  PanoPlayer
//
//  Created by qiruisun on 15/8/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
#import "Image.h"

@interface DistortiondataStruct : NSObject

@property float angle;
@property float multiple;

@end


@interface GLDistortiondata : NSObject

-(id)initWithImageData:(Image*)imagedata;

-(CGPoint)getRealXY:(CGPoint)point r:(float)r;

-(float)GetDistortValue:(float)data device:(int)device;
@end
