//
//  Image.h
//  PanoPlayer
//
//  Created by qiruisun on 15/7/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>


#define DEVICE_SPHERE800 1

#define DEVICE_TWOSPHERE 2000

#define DEVICE_SPHEREDETUTWINS 2002
#define DEVICE_SPHERETHETAS 2003
#define DEVICE_SPHEREINSTA360 2004

#define DEVICE_360 360


@interface Image : NSObject

@property NSString* type;// cube sphere video
@property NSString* url; //地址 -


//设备相关
@property int device;//设备
@property NSString* devicename;//每个硬件设备名字
@property float degree;//度数 如果是240的，则设置成240
@property float maskdegree;//mask


@property int width; //宽度
@property int height;//高度

@property int originwidth;//原
@property int originheight;//

@property int panow;
@property int panoh;


//旋转量
@property float rx;
@property float ry;
@property float rz;

@property float a;
@property float b;
@property float c;
@property float d;
@property float e;

//图一
@property float dr;//半径
@property float centerx; //中心点x
@property float centery;//中心点y
@property float yaw;
@property float pitch;//
@property float roll;//


//图二
@property float dr2;//第二组半径
@property float centerx2; //中心点x
@property float centery2;//中心点y
@property float yaw2;//本身旋转
@property float pitch2;//
@property float roll2;//


@property int channel;//图像通道


@property float public_errand;//公差
@property bool isfixed;//是否已修正中心点


@property int mediacodec;


-(void)deviceFilter;
-(void)deviceFilterWithVoid:(void *)data;
-(void)deviceFilterWithUIImage:(UIImage*)img;
-(void)deviceFilterWithBuffer:(CVPixelBufferRef)buffer;

-(void)Parser:(NSString*)desc;




@end

