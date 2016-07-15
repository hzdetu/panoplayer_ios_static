//
//  RXMLElement.h
//  PanoPlayer
//
//  Created by qiruisun on 15/7/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <libxml2/libxml/xmlreader.h>
#import <libxml2/libxml/xmlmemory.h>
#import <libxml2/libxml/HTMLparser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>

@interface RXMLDocHolder : NSObject {
    xmlDocPtr doc_;
}

- (id)initWithDocPtr:(xmlDocPtr)doc;
- (xmlDocPtr)doc;

@end

@interface RXMLElement : NSObject<NSCopying> {
    xmlNodePtr node_;
}

- (id)initFromXMLString:(NSString *)xmlString encoding:(NSStringEncoding)encoding;
- (id)initFromXMLFile:(NSString *)filename;
- (id)initFromXMLFile:(NSString *)filename fileExtension:(NSString*)extension;
- (id)initFromXMLFilePath:(NSString *)fullPath;
- (id)initFromURL:(NSURL *)url __attribute__((deprecated));
- (id)initFromXMLData:(NSData *)data;
- (id)initFromXMLDoc:(RXMLDocHolder *)doc node:(xmlNodePtr)node;

- (id)initFromHTMLString:(NSString *)xmlString encoding:(NSStringEncoding)encoding;
- (id)initFromHTMLFile:(NSString *)filename;
- (id)initFromHTMLFile:(NSString *)filename fileExtension:(NSString*)extension;
- (id)initFromHTMLFilePath:(NSString *)fullPath;
- (id)initFromHTMLData:(NSData *)data;

+ (id)elementFromXMLString:(NSString *)xmlString encoding:(NSStringEncoding)encoding;
+ (id)elementFromXMLFile:(NSString *)filename;
+ (id)elementFromXMLFilename:(NSString *)filename fileExtension:(NSString *)extension;
+ (id)elementFromXMLFilePath:(NSString *)fullPath;
+ (id)elementFromURL:(NSURL *)url __attribute__((deprecated));
+ (id)elementFromXMLData:(NSData *)data;
+ (id)elementFromXMLDoc:(RXMLDocHolder *)doc node:(xmlNodePtr)node;

+ (id)elementFromHTMLString:(NSString *)xmlString encoding:(NSStringEncoding)encoding;
+ (id)elementFromHTMLFile:(NSString *)filename;
+ (id)elementFromHTMLFile:(NSString *)filename fileExtension:(NSString*)extension;
+ (id)elementFromHTMLFilePath:(NSString *)fullPath;
+ (id)elementFromHTMLData:(NSData *)data;

- (NSString *)attribute:(NSString *)attributeName;
- (NSString *)attribute:(NSString *)attributeName inNamespace:(NSString *)ns;

- (NSArray *)attributeNames;

- (NSInteger)attributeAsInt:(NSString *)attributeName;
- (NSInteger)attributeAsInt:(NSString *)attributeName inNamespace:(NSString *)ns;

- (double)attributeAsDouble:(NSString *)attributeName;
- (double)attributeAsDouble:(NSString *)attributeName inNamespace:(NSString *)ns;

- (RXMLElement *)child:(NSString *)tag;
- (RXMLElement *)child:(NSString *)tag inNamespace:(NSString *)ns;

- (NSArray *)children:(NSString *)tag;
- (NSArray *)children:(NSString *)tag inNamespace:(NSString *)ns;
- (NSArray *)childrenWithRootXPath:(NSString *)xpath;

- (void)iterate:(NSString *)query usingBlock:(void (^)(RXMLElement *))blk;
- (void)iterateWithRootXPath:(NSString *)xpath usingBlock:(void (^)(RXMLElement *))blk;
- (void)iterateElements:(NSArray *)elements usingBlock:(void (^)(RXMLElement *))blk;

@property (nonatomic, strong) RXMLDocHolder *xmlDoc;
@property (nonatomic, readonly) NSString *tag;
@property (nonatomic, readonly) NSString *text;
@property (nonatomic, readonly) NSString *xml;
@property (nonatomic, readonly) NSString *innerXml;
@property (nonatomic, readonly) NSInteger textAsInt;
@property (nonatomic, readonly) double textAsDouble;
@property (nonatomic, readonly) BOOL isValid;

@end

typedef void (^RXMLBlock)(RXMLElement *element);