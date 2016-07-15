//
//  HotpotManager.h
//  PanoPlayer
//
//  Created by qiruisun on 15/8/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//


#import "Hotspot.h"
#import "PanoramaData.h"

@class PanoPlayer;

@interface HotpotManager :NSObject{
    __weak PanoPlayer *panoplayer;
}

-(instancetype)initWidthPlayer:(PanoPlayer*)player;

-(void)addPanohot:(PanoramaData*)panodata;
-(void)addHotpot:(Hotspot*)hotspot;

-(void)clear;
-(void)render:(int)modeltype;
@end
