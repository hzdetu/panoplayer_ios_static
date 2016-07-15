//
//  VideoPlugin.h
//  PanoPlayer
//
//  Created by qiruisun on 15/7/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Plugin.h"
#import "BasePlayerMovieDecoder.h"



@interface VideoPlugin : Plugin<MovieDecoderDelegate>

@property (nonatomic,readonly) float duration;
@property (nonatomic,assign)   float currentTime;


-(void)start;
-(void)pause;
-(void)stop;

//录制
-(Boolean)recordFile:(NSString*)savePath is2to1:(Boolean)is2to1;

//转2:1视频
-(Boolean)tranceVideo:(NSString*)inputFilePath outputPath:(NSString*)outputFilePath finishBlock:(void(^)(Boolean result))block;

-(void)stopRecord;

@end
