#import <AVFoundation/AVFoundation.h>

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#define MOVIE_DECODER_TARGET_IOS 1
#import <AssetsLibrary/AssetsLibrary.h>
#else
#define MOVIE_DECODER_TARGET_OSX 1
#endif

#include "BasePlayerMovieDecoder.h"

@class AVPlayer;
@class AVPlayerItemVideoOutput;
@class AVPlayerMovieDecoder;


// For iOS6 or later
@interface AVPlayerMovieDecoder : BasePlayerMovieDecoder{
	AVPlayer *_player;
    AVPlayerItemVideoOutput *_output;
    NSRecursiveLock *_lock;
    AVPlayerItem* _item;
    
}

@property (nonatomic,readonly) BOOL   isRunning, isFinished;

@end
