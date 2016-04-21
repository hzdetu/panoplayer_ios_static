//
//  MotionHelper.h
//  DETU
//
//  Created by apple on 15/2/6.
//  Copyright (c) 2015年 ___DETU___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MotionHelper : NSObject

+(void)start;
+(void)stop;

+(void)getMatrix44:(float [16])matrix;
+(void)getEuler:(float [3])euler;

@end
