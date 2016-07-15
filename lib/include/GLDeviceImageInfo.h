//
//  GLDeviceImageInfo.h
//  PanoPlayer
//
//  Created by qiruisun on 15/9/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "GLUtils.h"
@interface GLDeviceImageInfo : NSObject

-(s_CircleStruct)getDeviceImageInfoWithMat:(cv::Mat)mat imgdata:(Image*)imgdata;
-(s_CircleStruct)getDeviceImageInfoWithBuffer:(CVPixelBufferRef)buffer imgdata:(Image*)imgdata;
-(s_CircleStruct)getDeviceImageInfoWithUIImage:(UIImage *)img imgdata:(Image*)imgdata;
-(s_CircleStruct)getDeviceImageInfoWithVoid:(void *)data imgdata:(Image*)imgdata;

-(s_CircleStruct)getDeviceImageInfoWithDeivceid:(UIImage*)img deviceid:(int)deviceid;

@end
