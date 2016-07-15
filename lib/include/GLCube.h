//
//  GLCube.h
//  zzn
//
//  Created by apple on 15/6/11.
//  Copyright (c) 2015年 DETU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GLModel.h"


@interface GLCube : GLModel

-(void)setPreviewImage:(UIImage *)photo;
-(void)setFrontImage:(UIImage *)photo;
-(void)setBackImage:(UIImage *)photo;
-(void)setLeftImage:(UIImage *)photo;
-(void)setRightImage:(UIImage *)photo;
-(void)setUpImage:(UIImage *)photo;
-(void)setDownImage:(UIImage *)photo;
-(void)releaseRes;

@end
