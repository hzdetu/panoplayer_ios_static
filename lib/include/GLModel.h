//
//  GLModel.h
//  PanoPlayer
//
//  Created by apple on 15/7/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLPanoPlayerCore.h"
#import <OpenGLES/EAGLDrawable.h>
#import <OpenGLES/EAGL.h>

#ifdef OPENGLES2
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#else
#import <OpenGLES/ES1/gl.h>
#endif


#import <GLKit/GLKMath.h>
#import <GLKit/GLKit.h>
#import "PanoramaData.h"
#import "GLESRenderer.h"



#define VIEWMODE_FISHEYE    2
#define VIEWMODE_LITTLEPLANET 3
#define VIEWMODE_DEF        1
#define VIEWMODE_VR         4
#define VIEWMODE_FLAT       5
#define VIEWMODE_SPHERE    6
#define VIEWMODE_LINEFLAT  7


//视角
#define GLPLAYERRENDERMODELTYPE_DEFAULTEYE 0
#define GLPLAYERRENDERMODELTYPE_LEFTEYE 1
#define GLPLAYERRENDERMODELTYPE_RIGHTEYE 2

//顶点数
typedef struct {
    float Position[3];
    float Color[4];
    float TexCoord[2];
} GLVertexPoint3D;

typedef struct{
    float Position[2];
    float Color[4];
    float TexCoord[2];
} GLVecterPoint2D;

struct matrixf16 {
    float f[16];
};

@interface GLModel : NSObject{
    __weak PanoramaData* panodata;
    __weak GLESRenderer* glesrenderer;
    
    
    float w_h_rate;
    
    GLuint mProgramHandle;
    GLuint mMVPMatrixHandle;
    GLuint mTextureUniformHandle;
    GLuint mPositionHandle;
    GLuint mTextureCoordinateHandle;
    GLuint misforwardHandle;
    int isforward;
    
    
    GLKMatrix4 projectionMatrix;
    GLKMatrix4 modelMatrix;
    GLKMatrix4 viewMatrix;
    
}

@property (nonatomic,assign) int width;
@property (nonatomic,assign) int height;
@property (nonatomic,assign) float yaw,pitch,roll,fovY;
@property (nonatomic,assign) int viewMode;
@property (nonatomic,assign) int oldViewMode;
@property (nonatomic, assign) CATransform3D modelTransform;
@property (nonatomic, copy) NSArray *lights;

@property (nonatomic,assign) BOOL isAnimate;
@property (nonatomic,assign) float animate_zOffset;
@property (nonatomic,assign) float animate_zNear;
@property (nonatomic,assign) int animate_fov;



@property bool isvisible;



-(CGPoint)calWinPointByAngleXLeftEye:(float)x angleY:(float)y viewsize:(CGSize)viewsize;
-(CGPoint)calWinPointByAngleXRightEye:(float)x angleY:(float)y viewsize:(CGSize)viewsize;
-(CGPoint)calWinPointByAngleX:(float)x angleY:(float)y viewsize:(CGSize)viewsize;

-(CGPoint)calAngleByWinPointXLeft:(float)x winPointY:(float)y;
-(CGPoint)calAngleByWinPointXRight:(float)x winPointY:(float)y;
-(CGPoint)calAngleByWinPointX:(float)x winPointY:(float)y;


-(id)initWithMode:(int)viewmode renderer:(GLESRenderer*)renderer;
-(void)setPanoData:(PanoramaData *)pdata;
-(void)draw;
-(void)tranmatrix:(GLKMatrix4 )modelmatrix;
-(void)drawModel:(int)type;
-(void)loadShader;

-(PanoramaData *)getPanoData;

@end
