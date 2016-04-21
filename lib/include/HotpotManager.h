//
//  HotpotManager.h
//  PanoPlayer
//
//  Created by qiruisun on 15/8/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PanoPlayer.h"
#import "Hotspot.h"
#import "HotpotView.h"
#import "PanoramaData.h"

@interface HotpotManager :NSObject{
    __weak PanoPlayer *panoplayer;
}

-(instancetype)initWidthPlayer:(PanoPlayer*)player;

-(void)addPanohot:(PanoramaData*)panodata;
-(void)addHotpot:(Hotspot*)hotspot;

-(void)clear;
-(void)render:(int)modeltype;
@end
