//
//  HotpotView.h
//  PanoPlayer
//
//  Created by qiruisun on 15/8/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PanoPlayer.h"
#import "Hotspot.h"


typedef NS_ENUM(NSUInteger, HotpotViewEvent) {
    TOUCH,//点击
    LONGTOUCH, //长按
    VRTOUCH //VR点击
    
};

@interface HotpotView : UIView{
    Hotspot *hotspot;
    __weak PanoPlayer *panoplayer;
    float sw;
    float sh;
    
}

-(instancetype)initWithHotspotAndPlayer:(Hotspot*)data palyer:(PanoPlayer*)player;

-(void)initView;
-(void)initEvent;
-(void)dispatchHotpotEvent;

-(void)vrEventTimerCallHandler:(float)process;
-(void)vrEventTimerCancelHandler;
-(void)vrEventTimerCompleteHandler;

-(void)leftrender;
-(void)rightrender;
-(void)render;
@end
