//
//  Texture.h
//  PanoPlayer
//
//  Created by apple on 15/7/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BasePlayerMovieDecoder.h"
#import "GLPanoPlayerCore.h"

@interface Texture : NSObject{
@public
    
//    GLuint textures[2];
//    GLint _uniformSamplers[2];
//    
//    CVOpenGLESTextureCacheRef textureCache;
//    CVOpenGLESTextureRef      cvTexturesRef[2];
//    GLint _uniformIsHardWare;
    
    
    const GLfloat *_preferredConversion;
    GLuint _textures[3];
    GLint _uniformSamplers[3];
    GLint _uniform[1];
    

}

@property(assign,readonly) float xRange;
@property(assign,readonly) float yRange;

-(id)initWithContext:(EAGLContext*)context;

-(void)updateWithBuffer:(CVPixelBufferRef)buf;
-(void)updateWithDataBuffer:(void *)data ww:(int)ww hh:(int)hh channel:(int)channel;
-(void)updateWithImage:(UIImage *)img;

-(void)updateWithFrameSDL:(SDL_VoutOverlay*)overlay;

-(void)bind;
@end
