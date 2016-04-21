//
//  UIButton+wz.h
//  2323
//
//  Created by 吴泽 on 15/11/27.
//  Copyright © 2015年 吴泽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (wz)

+ (UIButton *)ButtonWithSize:(CGSize )size image:(NSString *)image title:(NSString *)title;

+ (UIButton *)ButtonWithFont:(CGFloat )font image:(NSString *)image title:(NSString *)title;

+ (UIButton *)ButtonWithFont:(CGFloat )font image:(NSString *)image imageH:(NSString *)imageH imageSlected:(NSString *)imageSlected title:(NSString *)title imageCenterRatio:(CGFloat )imageRatio titleCenterRatio:(CGFloat )titleRatio;

+ (UIButton *)ButtonWithSize:(CGSize )size image:(NSString *)image imageH:(NSString *)imageH imageSlected:(NSString *)imageSlected title:(NSString *)title imageCenterRatio:(CGFloat )imageRatio titleCenterRatio:(CGFloat )titleRatio;

+ (UIButton *)buttonWithImage:(NSString *)image title:(NSString *)title size:(CGSize )size;

@end
