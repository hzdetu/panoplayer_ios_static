//
//  VrEventObjectManager.h
//  PanoPlayer
//
//  Created by qiruisun on 15/8/11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VrEventObject.h"

@class PanoPlayer;


#define VR_EVENTCHECK_TOTAL_TIME 3000


@interface VrEventObjectManager : NSObject{
    PanoPlayer* panoplayer;
    
}

-(instancetype)initWithPanoPlayer:(PanoPlayer*)player;

-(void) addVrEventListener:(VrEventObject*)vrevtobj;

-(void) removeVrEventListener:(VrEventObject *)vreventobj;

-(void) render:(int)modeltype;

-(void)clear;

@end
