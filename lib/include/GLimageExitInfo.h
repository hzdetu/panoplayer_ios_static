//
//  WWimageExitInfo.h
//  WWimageExif
//
//  Created by 王维 on 14-8-22.
//  Copyright (c) 2014年 wangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>


@interface GLimageExitInfo : NSObject{
    @private
    CGImageSourceRef imageRef;
}

/*初始化方法
 *parms imageUrl 图片路径
 */
- (id)initWithURL:(NSURL*)imageUrl;

//照片EXIF
@property(strong) NSDictionary * imageExifDictionary;
//照片Tiff
@property(strong) NSDictionary * imageTiffDictionary;

@property(strong) NSDictionary * imageJfifDictionary;

//所有照片信息
@property(strong) NSDictionary * imageProperty;

@property(assign,nonatomic) NSInteger  imageFileSize;
@property(strong)           NSString * imageFileType;
@end
