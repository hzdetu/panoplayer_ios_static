//
//  ZZNLiveShowController.h
//  panoPlayerDemo
//
//  Created by 吴泽 on 15/12/15.
//  Copyright © 2015年 shenxing. All rights reserved.

// 播放器界面

#import <UIKit/UIKit.h>
#import "CustomUINavigationController.h"
#import "ZZNPicOrMovItem.h"

@interface ZZNMovController : CustomUINavigationController
@property (nonatomic, strong) ZZNPicOrMovItem *item;
@end
