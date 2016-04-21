//
//  BasePlayerMovieDecoder.h
//  PanoPlayer
//
//  Created by qiruisun on 15/7/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#define MOVIE_DECODER_TARGET_IOS 1
#import <AssetsLibrary/AssetsLibrary.h>
#else
#define MOVIE_DECODER_TARGET_OSX 1
#endif
#import <CoreVideo/CVPixelBuffer.h>
#import <UIKit/UIKit.h>


typedef enum {
    MOVICE_STATE_PLAYING,
    MOVICE_STATE_STOP,
    MOVICE_STATE_PAUSE,
    MOVICE_STATE_BUFFER_EMPTY,
    MOVICE_STATE_START_SEEK,
    MOVICE_STATE_FAILED,
    MOVICE_STATE_READYTOPALY,
    MOVICE_STATE_UNKNOWN
    
}MovieDecoderPlayItemState;

@protocol MovieDecoderDelegate <NSObject>

@required

-(void)movieDecoderDidFinishDecoding;
-(void)movieDecoderDidSeeked;
-(void)movieDecoderError:(NSError *)error;
-(void)moviceDecoderPlayItemState:(MovieDecoderPlayItemState)state;

@optional
-(void)movieDecoderDidDecodeFrame:(CVPixelBufferRef)buffer;
-(void)movieDecoderDidDecodeFrameBuffer:(void*)buffer width:(int)width height:(int)height channel:(int)channel;

@end



@interface BasePlayerMovieDecoder : NSObject

@property (nonatomic,readonly)   float duration;
@property (nonatomic,readonly)   float bufferedTime;
@property int isreplay;
@property (nonatomic,assign)   double currentTime;
@property (nonatomic,weak)   id<MovieDecoderDelegate> delegate;

+(id)movieDecoder;
+(id)movieDecoderWithMovie:(NSString*)path;
-(id)initWithMovie:(NSString*)path;
-(BOOL)loadMovie:(NSString*)path;
-(void)captureNext;
-(void)start;
-(void)pause;
-(void)stop;
-(void)cleargc;

-(NSString*)getDescriptMedta:(NSString *)key;
@end

