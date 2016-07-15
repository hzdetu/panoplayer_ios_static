//
//  Plugin.h
//  PanoPlayer
//
//  Created by qiruisun on 15/7/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PanoPlayer.h"


@interface Plugin : NSObject
{
    __weak PanoPlayer* panoplayer;
    __weak PanoramaData* panoramaData;
    @public
        GLModel*  model;
    
}

//初始化插件
-(void) InitPlugin:(PanoPlayer*)player;

-(void) SetPanoData:(PanoramaData*)panoData;
-(void) DisablePlugin;
-(void) EnablePlugin;

-(void) clear;

@end
