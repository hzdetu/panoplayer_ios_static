//
//  ManagerData.h
//  PanoPlayer
//
//  Created by qiruisun on 15/7/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Settings.h"


@interface ManagerData : NSObject

@property bool debugModel;
@property Settings* settings;
@property NSArray* panoramaList;


@end
