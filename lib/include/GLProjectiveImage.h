//
//  GLProjectiveImage.h
//  PanoPlayer
//
//  Created by qiruisun on 15/8/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
#import "GLDistortiondata.h"



@interface GLProjectiveImage : NSObject

- (UIImage*) imageFromBytes:(unsigned char *)bytes width:(int)width height:(int)height;

-(UIImage*)convertFisheyeToRect:(UIImage*)fisheyeimage deviceid:(int)deviceid;
-(UIImage*)convertDistortUIImage:(UIImage *)fisheyeimage deviceid:(int)deviceid;

-(UIImage*)convertPanoUIImageByRotaion:(UIImage*)fisheyeimage imgdata:(Image*)imgdata;

-(UIImage*)convertPanoUIImage:(UIImage*)fisheyeimage deviceid:(int)deviceid;
-(UIImage*)convertPanoUIImage:(UIImage*)fisheyeimage deviceid:(int)deviceid iscrop:(bool)iscrop;
-(UIImage*)convertPanoUIImage:(UIImage*)fisheyeimage imgdata:(Image*)imgdata iscrop:(bool)iscrop;

//只找一次圆
-(UIImage*)convertPanoUIImage2:(UIImage*)fisheyeimage imgdata:(Image*)imgdata iscrop:(bool)iscrop;
@end
