//
//  Hotspot.h
//  PanoPlayer
//
//  Created by qiruisun on 15/7/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Hotspot : NSObject

@property NSString* name;
@property float ath;
@property float atv;


@property NSString* eventtype;
@property NSString* eventarg;

@property NSString* style;
@property NSString* stylearg;


@property NSString* locdata;//坐标

@property float nextath;
@property float nextatv;
@property float nextfov;


@property float alpha;
@property float scale;

@property (nonatomic,assign) BOOL checkrange;//检测区域是否加大
@property (nonatomic,assign) BOOL hidden;//是否显示 配置里的值
@property (nonatomic,assign) BOOL copyhidden;//是否显示 实际的值，控制热点显示和隐藏


@end
