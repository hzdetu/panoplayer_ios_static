//
//  GLSphere.h
//  DETU
//
//  Created by apple on 15/2/5.
//  Copyright (c) 2015年 ___DETU___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLModel.h"
#import "Texture.h"
#import "Image.h"

#define COUNTX 160
#define COUNTY 80

#define POINTCOUNT (COUNTX+1)*COUNTY*2
#define POINT3DCOUNT POINTCOUNT * 3
#define POINT2DCOUNT POINTCOUNT * 2

@interface GLSphere : GLModel
{
    
    int pointCount;
    GLfloat points[POINT3DCOUNT]; //
    GLfloat plane_points[POINT2DCOUNT]; // (COUNTX+1)*COUNTY*2 * 2
    
    
    GLfloat spriteTexcoords[POINT2DCOUNT]; // (COUNTX+1)*COUNTY*2 * 2
    GLfloat spriteTexcoords2[POINT2DCOUNT];
    
    
    
    
    GLuint points_bufid;
    GLuint spriteTexcoords_bufid;
    
    Texture *texture;
}

-(void)drawPlane;
-(void)loadmodel;
-(void)bindBuffer;


-(void)initTexCoords:(float)xRange :(float)yRange;
-(void)setImage:(UIImage *)uiimg;
-(void)setBuf:(CVPixelBufferRef)buf;
-(void)setVoidBuf:(void *)buf width:(int)width height:(int)height channel:(int)channel force:(bool)force;
@end
