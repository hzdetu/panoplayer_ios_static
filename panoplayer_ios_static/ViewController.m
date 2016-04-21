//
//  ViewController.m
//  panoplayer_ios_static
//
//  Created by qiruisun on 15/12/31.
//  Copyright © 2015年 detu. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "ZZNMovController.h"
#import "ZZNPicOrMovItem.h"

@interface ViewController ()

@end

@implementation ViewController


-(void)viewDidLoad{
    
    //直播
    UIButton *liveShow = [[UIButton alloc] init];
    liveShow.frame = CGRectMake(100, 20, 120, 70);
    [liveShow setTitle:@"直播" forState:UIControlStateNormal];
    liveShow.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:liveShow];
    [liveShow addTarget:self action:@selector(liveShow:) forControlEvents:UIControlEventTouchDown];
    
    //远程视频
    UIButton *video_web = [[UIButton alloc] init];
    video_web.frame = CGRectMake(100, 120, 120, 70);
    [video_web setTitle:@"远程视频" forState:UIControlStateNormal];
    video_web.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:video_web];
    [video_web addTarget:self action:@selector(videoFromWeb:) forControlEvents:UIControlEventTouchDown];
    
    // 远程图片
    UIButton *pic_web = [[UIButton alloc] init];
    pic_web.frame = CGRectMake(100, 220, 120, 70);
    [pic_web setTitle:@"远程图片" forState:UIControlStateNormal];
    pic_web.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:pic_web];
    [pic_web addTarget:self action:@selector(pictureFromWeb:) forControlEvents:UIControlEventTouchDown];
    
    // 本地视频
    UIButton *video_local = [[UIButton alloc] init];
    video_local.frame = CGRectMake(100, 320, 120, 70);
    [video_local setTitle:@"本地视频" forState:UIControlStateNormal];
    video_local.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:video_local];
    [video_local addTarget:self action:@selector(videoFromLocal:) forControlEvents:UIControlEventTouchDown];
    
    // 本地图片
    UIButton *pic_local = [[UIButton alloc] init];
    pic_local.frame = CGRectMake(100, 420, 120, 70);
    [pic_local setTitle:@"本地图片" forState:UIControlStateNormal];
    pic_local.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:pic_local];
    [pic_local addTarget:self action:@selector(pictureFromLocal:) forControlEvents:UIControlEventTouchDown];
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskPortrait;
}



- (void)liveShow:(NSString *)liveConfigUrl {
    
    ZZNMovController *vc = [ZZNMovController new];
    ZZNPicOrMovItem *item = [ZZNPicOrMovItem new];
    item.fromWhere = ZZNDataFromWeb;
    item.isLiveShow = YES;
    item.fileType = 2;
    item.app_config = @"http://hls5.l.cztv.com/channels/lantian/wchannel102/720p.m3u8";
    item.title = @"直播";
    vc.item = item;
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)videoFromWeb:(NSString *)configUrl {

    ZZNMovController *vc = [ZZNMovController new];
    ZZNPicOrMovItem *item = [ZZNPicOrMovItem new];
    item.fromWhere = ZZNDataFromWeb;
    item.isLiveShow = NO;
    item.fileType = 2;
    item.app_config = @"http://www.detu.com/ajax/pano/xml/68356";
    item.title = @"远程视频";
    vc.item = item;
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)pictureFromWeb:(NSString *)configUrl {
    
    ZZNMovController *vc = [ZZNMovController new];
    ZZNPicOrMovItem *item = [ZZNPicOrMovItem new];
    item.fromWhere = ZZNDataFromWeb;
    item.isLiveShow = NO;
    item.fileType = 1;
    item.app_config = @"http://www.detu.com/ajax/pano/xml/61505";
    item.title = @"远程图片";
    vc.item = item;
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)videoFromLocal:(NSString *)configUrl {

    ZZNMovController *vc = [ZZNMovController new];
    ZZNPicOrMovItem *item = [ZZNPicOrMovItem new];
    item.fromWhere = ZZNDataFromLocal;
    item.isLiveShow = NO;
    item.fileType = 2;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"demo.mp4" ofType:nil];
    path = [NSString stringWithFormat:@"file://%@",path];
    item.url = path;
    item.title = @"本地视频";
    vc.item = item;
    [self presentViewController:vc animated:YES completion:nil];
    
    
}

- (void)pictureFromLocal:(NSString *)configUrl {
    
    ZZNMovController *vc = [ZZNMovController new];
    ZZNPicOrMovItem *item = [ZZNPicOrMovItem new];
    item.fromWhere = ZZNDataFromLocal;
    item.isLiveShow = NO;
    item.fileType = 1;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"THETA_DEMO.jpg" ofType:nil];
    path = [NSString stringWithFormat:@"file://%@",path];
    item.url = path;
    item.title = @"本地图片";
    vc.item = item;
    [self presentViewController:vc animated:YES completion:nil];
}


@end
