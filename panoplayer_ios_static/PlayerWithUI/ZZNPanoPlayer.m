//
//  ZZNPanoPlayer.m
//  DeTuZZN
//
//  Created by 吴泽 on 15/11/24.
//  Copyright © 2015年 DETU. All rights reserved.
//

#import "ZZNPanoPlayer.h"
#import "PanoPlayer.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"


@interface ZZNPanoPlayer ()


@end

@implementation ZZNPanoPlayer


- (instancetype)init {
    
    if (self = [super init]) {
        
        [self initCommand];
        
    }
    return self;
}

- (void)initCommand {
    
   @weakify(self);
    [RACObserve(self, item) subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            
            [self playDataItem];
            
        }
    }];
}

- (void)playDataItem {
    
    if (self.item.fromWhere == ZZNDataFromWeb) {//来自网络
        
        if (!self.item.isLiveShow) {
            PanoPlayerUrl *panoPlayerUrl = [[PanoPlayerUrl alloc] init];
            [panoPlayerUrl SetXMlUrl:self.item.app_config];
            [self.panoPlayer Play:panoPlayerUrl];
        } else {
            // 本地配置 xml
            NSString *tpl = @"<?xml version=\"1.0\" encoding=\"UTF-8\" ?> \
            <DetuVr> \
            <settings init=\"pano1\" initmode=\"default\" enablevr=\"false\" title=\"\"></settings> \
            \
            \
            <scenes> \
            <scene name=\"pano1\" title=\"\" thumburl=\"\"> \
            <preview url=\"\" /> \
            <image type=\"video\"  url=\"%url\" \
            \
            \
            device=\"0\" \
            \
            /> <view hlookat='0' vlookat='90' fov='110' viewmode='default' /> \
            </scene> \
            </scenes> \
            </DetuVr>";
            
            tpl =  [tpl stringByReplacingOccurrencesOfString:@"%url" withString:self.item.app_config];
            PanoPlayerUrl *panoplayerurl = [[PanoPlayerUrl alloc] init];
            [panoplayerurl SetXmlContent:tpl];
             [self.panoPlayer Play:panoplayerurl];
        }

      
    } else { //来自本地
        
        // 本地配置 xml
        NSString *tpl = @"<?xml version=\"1.0\" encoding=\"UTF-8\" ?> \
        <DetuVr> \
        <settings init=\"pano1\" initmode=\"default\" enablevr=\"false\" title=\"\"></settings> \
        \
        \
        <scenes> \
        <scene name=\"pano1\" title=\"\" thumburl=\"\"> \
        <preview url=\"\" /> \
        <image type=\"%type\"  url=\"%url\" \
        \
        \
        device=\"0\" \
        \
        /> <view hlookat='0' vlookat='90' fov='110' viewmode='default' /> \
        </scene> \
        </scenes> \
        </DetuVr>";
        
        NSString *videoOrPic = self.item.fileType == 1 ? @"sphere" : @"video";
        tpl =  [tpl stringByReplacingOccurrencesOfString:@"%url" withString:self.item.url];
        tpl = [tpl stringByReplacingOccurrencesOfString:@"%type" withString:videoOrPic];
        PanoPlayerUrl *panoplayerurl = [[PanoPlayerUrl alloc] init];
        [panoplayerurl SetXmlContent:tpl];
        [self.panoPlayer Play:panoplayerurl];
  
    }
    
}


- (PanoPlayer *)panoPlayer {
    if (_panoPlayer == nil) {
        _panoPlayer = [[PanoPlayer alloc] init];
        [self addSubview:_panoPlayer];
        [_panoPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _panoPlayer;
    
}


- (void)setRotateEnable:(BOOL)rotateEnable {
    
    _rotateEnable = rotateEnable;
    if (rotateEnable == YES) {
        [self.panoPlayer getCurrentPanoramaData].image.rz = -90;
        [self.panoPlayer getCurrentPanoramaData].image.ry = -90;
    } else {
        [self.panoPlayer getCurrentPanoramaData].image.rz = 0;
        [self.panoPlayer getCurrentPanoramaData].image.ry = 0;
    }
    
    
}

- (void)setGyroEnable:(BOOL)gyroEnable {
    
    _gyroEnable = gyroEnable;
    self.panoPlayer.gyroEnable = gyroEnable;
    
}

- (void)setViewMode:(int)viewMode {
    
    _viewMode = viewMode;
    int mode = 0;
    if (viewMode == 1) {
        mode = VIEWMODE_SPHERE;
        [self.panoPlayer setHLookAt:90];
        [self.panoPlayer setVLookAt:90];
        [self.panoPlayer setFov:105];
    } else if (viewMode == 2) {
        mode = VIEWMODE_DEF;
        [self.panoPlayer setHLookAt:90];
        [self.panoPlayer setVLookAt:0];
        [self.panoPlayer setFov:65];
        
    } else if (viewMode == 3) {
        mode = VIEWMODE_LITTLEPLANET;
        [self.panoPlayer setHLookAt:90];
        [self.panoPlayer setVLookAt:-90];
        
    } else if (viewMode == 4) {
        mode = VIEWMODE_SPHERE;
        [self.panoPlayer setHLookAt:90];
        [self.panoPlayer setVLookAt:22];
        [self.panoPlayer setFov:113];
        
    } else if (viewMode == 5) {
        mode = VIEWMODE_VR;
    }
    self.panoPlayer.gyroEnable = mode == VIEWMODE_VR ? YES : NO;
    [self.panoPlayer setViewMode:mode];
    
    
}




@end
