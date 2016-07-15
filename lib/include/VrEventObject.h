//
//  VrEventObject.h
//  PanoPlayer
//
//  Created by qiruisun on 15/8/11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hotspot.h"


@protocol VrEventTimerDelegate <NSObject>

-(void)vrEventTimerCallHandler:(float)process;
-(void)vrEventTimerCancelHandler;
-(void)vrEventTimerCompleteHandler;

@end

@interface VrEventObject : NSObject

//是否开始
@property bool isstart;

@property float yaw;
@property float pitch;

@property int process;
@property UInt64 currenttime;

@property (nonatomic,weak)   id<VrEventTimerDelegate> delegate;

@property (nonatomic,strong) Hotspot* hotspot;

@end
