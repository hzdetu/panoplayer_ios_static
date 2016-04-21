//
//  UIButton+wz.m
//  2323
//
//  Created by 吴泽 on 15/11/27.
//  Copyright © 2015年 吴泽. All rights reserved.
//

#import "UIButton+wz.h"

@implementation UIButton (wz)


+ (UIButton *)ButtonWithFont:(CGFloat )font image:(NSString *)image imageH:(NSString *)imageH imageSlected:(NSString *)imageSlected title:(NSString *)title imageCenterRatio:(CGFloat )imageRatio titleCenterRatio:(CGFloat )titleRatio {

    UIButton *btn = [[UIButton alloc] init];
    
    UIImage *btnImage = [UIImage imageNamed:image];
    CGFloat imageWidth = CGImageGetWidth(btnImage.CGImage);
    CGFloat imageHeight = CGImageGetHeight(btnImage.CGImage);
    
    
    if ([UIScreen mainScreen].scale == 3.0f) {
        imageWidth *= 0.5f;
        imageHeight *= 0.5f;
    }
    
    NSString *btnText = title;
    UIFont *btnFont = [UIFont systemFontOfSize:font];
    NSDictionary *attrs = @{NSFontAttributeName : btnFont};
    CGSize labelSize =  [btnText boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine attributes:attrs context:nil].size;
    
    CGFloat labelHeight = labelSize.height;
    CGFloat labelWidth = labelSize.width;
    
    CGFloat btnH = imageHeight + labelHeight;
    CGFloat btnW = imageWidth + labelWidth;
    
    btn.bounds = CGRectMake(0, 0, btnW, btnH);
    
    
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageH] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:imageSlected] forState:UIControlStateSelected];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:font]];
    
    CGPoint imageEndCenter = CGPointMake(btnW / 2, btnH * imageRatio);
    CGPoint imageStartCenter = btn.imageView.center;
    
    CGFloat top1 = imageEndCenter.y - imageStartCenter.y;
    CGFloat left1 = imageEndCenter.x - imageStartCenter.x;
    CGFloat bottom1 = -top1;
    CGFloat right1 = -left1;
    btn.imageEdgeInsets = UIEdgeInsetsMake(top1, left1, bottom1, right1);
    
    CGPoint titleEndCenter = CGPointMake(btnW / 2, btnH * titleRatio);
    CGPoint titleStartCenter = btn.titleLabel.center;
    
    CGFloat top2 = titleEndCenter.y - titleStartCenter.y;
    CGFloat left2 = titleEndCenter.x - titleStartCenter.x;
    CGFloat bottom2 = -top2;
    CGFloat right2 = -left2;
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(top2, left2, bottom2, right2);
    
    
   

    return btn;
}

+ (UIButton *)ButtonWithFont:(CGFloat )font image:(NSString *)image title:(NSString *)title {
    
    return [UIButton ButtonWithFont:font image:image imageH:image imageSlected:image title:title imageCenterRatio:0.25 titleCenterRatio:0.75];
    
}


+ (UIButton *)ButtonWithSize:(CGSize )size image:(NSString *)image imageH:(NSString *)imageH imageSlected:(NSString *)imageSlected title:(NSString *)title imageCenterRatio:(CGFloat )imageRatio titleCenterRatio:(CGFloat )titleRatio {
    
    UIButton *btn = [[UIButton alloc] init];
    

    CGFloat btnH = size.height;
    CGFloat btnW = size.width;
    
    
    btn.bounds = CGRectMake(0, 0, btnW, btnH);
    
    
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageH] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:imageSlected] forState:UIControlStateSelected];
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    CGPoint imageEndCenter = CGPointMake(btnW / 2, btnH * imageRatio);
    CGPoint imageStartCenter = btn.imageView.center;
    
    CGFloat top1 = imageEndCenter.y - imageStartCenter.y;
    CGFloat left1 = imageEndCenter.x - imageStartCenter.x;
    CGFloat bottom1 = -top1;
    CGFloat right1 = -left1;
    btn.imageEdgeInsets = UIEdgeInsetsMake(top1, left1, bottom1, right1);
    
    CGPoint titleEndCenter = CGPointMake(btnW / 2, btnH * titleRatio);
    CGPoint titleStartCenter = btn.titleLabel.center;
    
    CGFloat top2 = titleEndCenter.y - titleStartCenter.y;
    CGFloat left2 = titleEndCenter.x - titleStartCenter.x;
    CGFloat bottom2 = -top2;
    CGFloat right2 = -left2;
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(top2, left2, bottom2, right2);
    
    
    
    
    return btn;
}

+ (UIButton *)ButtonWithSize:(CGSize )size image:(NSString *)image title:(NSString *)title {
    
    return [UIButton ButtonWithSize:size image:image imageH:image imageSlected:image title:title imageCenterRatio:0.25 titleCenterRatio:0.75];
    
}



+ (UIButton *)buttonWithImage:(NSString *)image title:(NSString *)title size:(CGSize )size{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    [btn addSubview:imageView];
    imageView.frame = CGRectMake(10, 0, size.width-20, size.height/2);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, size.height/2, size.width, size.height/2)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    [btn addSubview:label];
    label.text = title;
    
    return btn;
    
}
@end
