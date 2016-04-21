//
//  Texture.h
//  PanoPlayer
//
//  Created by apple on 15/7/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GLPanoPlayerCore.h"

@interface Texture : NSObject

@property(assign,readonly) float xRange;
@property(assign,readonly) float yRange;

-(void)updateWithBuffer:(CVPixelBufferRef)buf;
-(void)updateWithDataBuffer:(void *)data ww:(int)ww hh:(int)hh channel:(int)channel;
-(void)updateWithImage:(UIImage *)img;

-(void)bind;
@end
