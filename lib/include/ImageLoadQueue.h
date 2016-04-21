//
//  ImageLoadQueue.h
//  PanoPlayer
//
//  Created by qiruisun on 15/7/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ImageLoadQueueCallBack <NSObject>

-(void)ImageLoadOnLoadComplete:(NSString*)imguri uiimage:(UIImage*)image;

@end

@interface ImageLoadQueue : NSObject

@property (nonatomic,weak)   id<ImageLoadQueueCallBack> delegate;
-(void)addQueue:(NSString*)url;
-(void)startLoad;
@end
