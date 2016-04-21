//
//  RootViewController.m
//  PanoPlayer
//
//  Created by qiruisun on 15/7/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
#import "ZZNMovController.h"
#import "Masonry.h"

@implementation RootViewController

-(void)viewDidLoad{
    UIButton *btn1=[[UIButton alloc]init];
    [btn1 setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    [btn1 setTitleColor:[UIColor colorWithWhite:0 alpha:1] forState:UIControlStateNormal];
    [btn1 setTitle:@"测试" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.center.equalTo(@0);
    }];
    
    
 
}



-(void)click{
 
    MainViewController *controller=[[MainViewController alloc]init];
    [self presentViewController:controller animated:NO completion:nil];
}

@end
