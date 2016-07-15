//
//  PanoPlayerUrl.h
//  PanoPlayer
//
//  Created by qiruisun on 15/7/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagerData.h"
#import "Image.h"
#import "Preview.h"


typedef void (^PanoPlayerUrlParserSuccess)(ManagerData *mdata);
typedef void (^PanoPlayerUrlErrorSuccess)(NSError *e);

@interface PanoPlayerUrl : NSObject

-(void) SetCubeUrlImage:(NSString*)url preview:(NSString*)preview;
-(void) SetSphereUrlImage:(NSString*)url preview:(NSString*)preview;
-(void) SetSphereUrlVideo:(NSString *)url preview:(NSString*)preview;

-(void) SetXmlContent:(NSString*)xmlstr;
-(void) SetXMlUrl:(NSString*)xmlurl;

-(void) Set360VideoUrl:(NSString*)url;


-(void)ParserManagerData:(PanoPlayerUrlParserSuccess)success failure:(PanoPlayerUrlErrorSuccess)failure;

@end
