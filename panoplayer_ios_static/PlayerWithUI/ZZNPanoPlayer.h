//
//  ZZNPanoPlayer.h
//  DeTuZZN
//
//  Created by 吴泽 on 15/11/24.
//  Copyright © 2015年 DETU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PanoPlayer.h"
#import "ZZNPicOrMovItem.h"

@interface ZZNPanoPlayer : UIView
@property (nonatomic, strong) ZZNPicOrMovItem *item;
@property (nonatomic, strong) PanoPlayer *panoPlayer;
@property (nonatomic, assign) int viewMode;//视角
@property (nonatomic, assign) BOOL gyroEnable;//陀螺仪
@property (nonatomic, assign) BOOL rotateEnable;//旋转

@end
