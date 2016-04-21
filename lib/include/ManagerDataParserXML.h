//
//  ManagerDataParserXML.h
//  PanoPlayer
//
//  Created by qiruisun on 15/7/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagerData.h"
#import "PanoramaData.h"
#import "RXMLElement.h"

@interface ManagerDataParserXML : NSObject

- (ManagerData *) configureManagerData:(NSString *)xmlString;


// panoramas
-(void) parserPreview:(PanoramaData *)panoData  xmlele:(RXMLElement *)e;
-(void) parserImage:(PanoramaData *)panoData xmlele:(RXMLElement *)e;
-(void) parserHotspot:(PanoramaData *)panoData xmlNs:(NSArray *)ns;


@end
