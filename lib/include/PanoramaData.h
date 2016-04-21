//
//  PanoramaData.h
//  PanoPlayer
//
//  Created by qiruisun on 15/7/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Preview.h"
#import "Image.h"
#import "ImageViewData.h"
#import "Hotspot.h"
#import "BackgoundMusic.h"

@interface PanoramaData : NSObject

@property  NSString* name;
@property  NSString* title;
@property  NSString* thumbUrl;

@property Preview* preview;
@property ImageViewData* imageviewdata;
@property Image* image;

@property BackgoundMusic* backgroundMusic;

@property NSArray* hotspotList;



@end
