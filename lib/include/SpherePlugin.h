//
//  SpherePlugin.h
//  PanoPlayer
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Plugin.h"
#import "ImageLoadQueue.h"

@interface SpherePlugin : Plugin<ImageLoadQueueCallBack>

-(void)setShowImage:(UIImage*)img;

@end
