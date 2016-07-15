//
//  GLUtils.h
//  PanoPlayer
//
//  Created by qiruisun on 15/8/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "Image.h"

#import "opencv2/core/core.hpp"
#import "opencv2/imgproc/imgproc.hpp"
#import "opencv2/highgui/ios.h"

using namespace cv;

struct CircleStruct{
    float r;
    float cx;
    float cy;

};
typedef struct CircleStruct s_CircleStruct;

@interface GLUtils : NSObject

-(cv::Mat)convertToMatWithBuffer:(CVPixelBufferRef)cvImageBuffer;
-(cv::Mat)convertToMatWithVoid:(void *)image imgdata:(Image*)imgdata;
-(cv::Mat)convertToMat:(UIImage *)image;
-(cv::Mat)cropWithMat:(cv::Mat)img1 rect:(CGRect)rect;

-(s_CircleStruct)findBestCircleFromMat:(cv::Mat)pSrcImage imgdata:(Image*)imgdata withThresholdPos:(float)pos;
-(s_CircleStruct)findBestCircleFromUIImage:(UIImage *)img imgdata:(Image*)imgdata withThresholdPos:(float)pos;
-(s_CircleStruct)findBestCircleFromVoid:(void *)data imgdata:(Image*)imgdata withThresholdPos:(float)pos;
-(s_CircleStruct)findBestCircleFromBuffer:(CVPixelBufferRef)img imgdata:(Image*)imgdata withThresholdPos:(float)pos;
@end

