//
//  PanoPlayView.h
//  PanoPlayer
//
//  Created by qiruisun on 15/7/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "PanoPlayer.h"
#import "PanoPlayerUrl.h"

@interface PanoPlayView :  UIView<PanoPlayDelegate>

@property PanoPlayer* panoplayer;

-(void)setPath:(PanoPlayerUrl *)panoplayerurl;
-(void)cleargc;

@end

