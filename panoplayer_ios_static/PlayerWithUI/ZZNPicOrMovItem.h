//
//  ZZNPicOrMovItem.h
//  panoplayer_ios_static
//
//  Created by David on 16/4/7.
//  Copyright © 2016年 detu. All rights reserved.
//

//播放的图片或者视频 对象
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZZNDataFromWhere) {
    ZZNDataFromLocal = 0,
    ZZNDataFromWeb = 1,
};
@interface ZZNPicOrMovItem : NSObject

@property (nonatomic, assign) ZZNDataFromWhere fromWhere;  //数据来源
@property (nonatomic, assign) int fileType;                //文件类型 1照片 2视频
@property (nonatomic, assign) BOOL isLiveShow;             // 是否为直播
@property (nonatomic, copy) NSString *app_config;          //播放的xml
@property (nonatomic, copy) NSString *url;                 //播放路径
@property (nonatomic, copy) NSString *title;               //名称
@end
