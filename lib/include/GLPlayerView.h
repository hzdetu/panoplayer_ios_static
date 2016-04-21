//
//  GLView.h
//  PanoPlayer
//
//  Created by apple on 15/7/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKMath.h>
#import <GLKit/GLKit.h>
#import <UIKit/UIKit.h>
#import "GLModel.h"
#import "ImageViewData.h"
#import "GLESRenderer.h"




@interface GLPlayerView : UIView

@property  GLESRenderer* renderer;

@property (nonatomic,assign) int viewMode;
@property (nonatomic,assign) bool zoomEnable;
@property (nonatomic,assign) bool gyroEnable;
@property (nonatomic,assign) GLModel* model;

-(void)rendermodel:(int)modeltype;
-(void)render;

-(CGPoint)getCenterYawAndPitchPoint:(int)modeltype;
-(void)setImageViewData:(ImageViewData*)data;

-(float)getHLookAt;
-(float)getVLookAt;
-(float)getFov;
-(void)setHLookAt:(float)ath;
-(void)setVLookAt:(float)atv;
-(void)setFov:(float)fov;

-(void)animationChangeMode:(int)mode hlook:(float)hlook vlook:(float)vlook fov:(float)fov;



@end
