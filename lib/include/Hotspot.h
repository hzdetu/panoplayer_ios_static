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




@end
