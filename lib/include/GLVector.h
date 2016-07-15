//
//  GLVector.h
//  PanoPlayer
//
//  Created by qiruisun on 15/8/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>



#define tol 0.0001

@interface GLVector : NSObject
{
    double x;
    double y;
    double z;
}

@property double x;
@property double y;
@property double z;

- (id)initWithUnitaryVector;
- (id)initWithZeros;
- (id)initWithX:(double)xi Y:(double)yi Z:(double)zi;
- (double)Magnitude;
- (void)Normalize;
- (void)Reverse;
- (void)Add:(GLVector*)v;
- (void)Sub:(GLVector*)v;
- (void)Mul:(double)s;
- (void)Div:(double)s;

+ (GLVector*)Add:(GLVector*)u _v2:(GLVector*)v;
+ (GLVector*)Sub:(GLVector*)u _v2:(GLVector*)v;
+ (GLVector*)Cross:(GLVector*)u _v2:(GLVector*)v;
+ (double)Dot:(GLVector*)u _v2:(GLVector*)v;
+ (GLVector*)Mul:(GLVector*)u scalar:(double)s;
+ (GLVector*)Div:(GLVector*)u scalar:(double)s;
+ (double)TScProd:(GLVector*)u _v2:(GLVector*)v _v3:(GLVector*)w;
@end
