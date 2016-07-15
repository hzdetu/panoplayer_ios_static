//
//  GLStitchImage.h
//  PanoPlayer
//
//  Created by qiruisun on 15/9/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLProjectiveImage.h"

@interface GLStitchImage : NSObject

-(UIImage*)stitchPanoUIImage:(UIImage*)fisheyeimage1 fisheyeimage2:(UIImage*)fisheyeimage2;

@end
