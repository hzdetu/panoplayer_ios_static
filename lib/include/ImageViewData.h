//
//  ImageViewData.h
//  PanoPlayer
//
//  Created by qiruisun on 15/8/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageViewData : NSObject

@property float hlookat;
@property float vlookat;
@property float fov;
@property float vrfov;
@property float vrz;
@property float fovmin;
@property float fovmax;
@property float defovmax;

@property float hlookatmin;
@property float hlookatmax;
@property float vlookatmin;
@property float vlookatmax;
@property int gyroenable;
@property NSString* viewmodel;


@end
