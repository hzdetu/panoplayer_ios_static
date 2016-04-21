//
//  CustomUINavigationController.m
//  DeTuZZN
//
//  Created by shenxing on 15/8/11.
//  Copyright (c) 2015年 DETU. All rights reserved.
//

#import "CustomUINavigationController.h"

@interface CustomUINavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CustomUINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canRotate = YES;
}

////当前viewcontroller是否支持转屏
- (BOOL)shouldAutorotate{
    return self.canRotate;
}

//当前viewcontroller支持哪些转屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    
    if (self.canRotate) {
        return UIInterfaceOrientationMaskAll;

    }
    return UIInterfaceOrientationMaskPortrait;
}

//当前viewcontroller默认的屏幕方向
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarHidden = YES;
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarHidden = NO;
    [super viewWillDisappear:animated];
}


@end
