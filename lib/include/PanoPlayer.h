//
//  PanoPlayer.h
//  PanoPlayer
//
//  Created by qiruisun on 15/7/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PanoPlayerUrl.h"
#import "GLPlayerView.h"
#import "PanoramaData.h"
#import "VrEventObjectManager.h"
#import "ManagerData.h"



//当前版本
#define PANOPLAYER_VERSION 2.0


typedef NS_ENUM(NSUInteger, PanoPlayerErrorCode) {
    PANO_PLAY_SUCCESS,
    PANO_SETTING_DATA_IS_EMPTY, //Settings为空
    PANO_PANORAMALIST_IS_EMPTY, //全景节点为空
    PANO_PLAY_PARSERERROR
    
};

typedef enum {
    STATUS_PLAYING,
    STATUS_PAUSE,
    STATUS_STOP,
    STATUS_FINISH,
    STATUS_BUFFER_EMPTY
}PanoVideoPluginStatus;



@protocol PanoPlayDelegate <NSObject>

//loading
-(void)PanoPlayOnLoading;//加载中
-(void)PanoPlayOnLoaded;//加载完成

//panorama
-(void)PanoPlayOnEnter:(PanoramaData*)curpanodata;//进入场景
-(void)PanoPlayonLeave:(PanoramaData*)prepanodata;//离开场景


@optional
//error
-(void)PanoPlayOnError:(PanoPlayerErrorCode)e;

//hotspot
-(void)PanoPlayOnTapBeforeHotpot:(Hotspot*)hotspot;//点击热点响应前
-(void)PanoPlayOnTapAfterHotpot:(Hotspot*)hotspot;//点击热点后

@optional
//plugin
  //plugin - video回调
-(void)PluginVideoOnStatusChanged:(PanoVideoPluginStatus)s;
-(void)PluginVideoOnProgessChanged;
-(void)PluginVideoOnSeekFinished;
-(void)PluginVideoOnPlayerError:(NSError *)e;



@end


@interface PanoPlayer : GLPlayerView

@property (nonatomic,weak)   id<PanoPlayDelegate> delegate;


//得到当前的全景对象
-(PanoramaData*) getCurrentPanoramaData;

//得到场景插件对象
-(id)GetCurrentPluginObject;

//播放
-(void)Play:(PanoPlayerUrl*)playerurl;

-(void) rePlay;

-(ManagerData*) getManagerData;

-(void) loadPano:(NSString*)name;

-(void) cleargc;

-(void) PanoPlayOnLoaded;

-(void) onTapBeforeHotpot:(Hotspot*)hotspot;
-(void) onTapAfterHotpot:(Hotspot*)hotspot;

-(UIImage *)getScreenShot;



-(VrEventObjectManager*)getVrEventManager;


@end
