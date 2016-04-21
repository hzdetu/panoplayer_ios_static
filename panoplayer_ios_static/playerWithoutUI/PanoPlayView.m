//
//  PanoVideoPlayer.m
//  MyVideoPlayer
//
//  Created by apple on 15/6/26.
//
//

#import "PanoPlayView.h"


#import "PanoPlayerUrl.h"
#import "VideoPlugin.h"


@interface PanoPlayView()
{
    // PanoVideoView *panoView;
   
    VideoPlugin* videoplugin;
    
    UILabel *timePlayedLabel;
    UILabel *timeTotalLabel;
    
    UIButton *btnPlay;
    UIButton *btnTurnMode;
    UISlider *slider;
    
    PanoVideoPluginStatus status;
    bool isSlideDraging;
}

@property NSDateFormatter* dateFormatter;
@end

@implementation PanoPlayView


-(id)init{
    self=[super init];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"mm:ss";

    _panoplayer = [[PanoPlayer alloc] init];
//_panoplayer.gyroEnable=true;
    _panoplayer.delegate = self;
  // [panoplayer setViewMode:VIEWMODE_LINEFLAT];
    [self addSubview:_panoplayer];
    
    
        btnTurnMode=[[UIButton alloc]init];
        [btnTurnMode setTitle:@"模式" forState:UIControlStateNormal];
        [btnTurnMode setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
        [btnTurnMode setTitleColor:[UIColor colorWithWhite:0 alpha:1] forState:UIControlStateNormal];
        [btnTurnMode addTarget:self action:@selector(turnMode) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnTurnMode];
        
       
    
    
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.frame.size.width>0&&self.frame.size.height>0) {
        
        _panoplayer.frame=self.frame;
        NSLog(@"panoplayer frame %f %f",_panoplayer.frame.size.width, _panoplayer.frame.size.height);
        
        btnTurnMode.frame=CGRectMake(self.frame.size.width-50, self.frame.size.height-30, 50, 25);
        
    }
}


-(void)layoutVideUI{
    
    
    
    
    if (btnPlay == nil) {
   
        //初始化控件
        btnPlay=[[UIButton alloc]init];
        [btnPlay setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
        [btnPlay setTitleColor:[UIColor colorWithWhite:0 alpha:1] forState:UIControlStateNormal];
        [btnPlay addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnPlay];
    
      
    
        slider=[[UISlider alloc]init];
        [slider addTarget:self action:@selector(sliderChanged) forControlEvents:UIControlEventTouchUpInside];
        [slider addTarget:self action:@selector(sliderChanged) forControlEvents:UIControlEventTouchUpOutside];
        [slider addTarget:self action:@selector(sliderStartChanged) forControlEvents:UIControlEventTouchDown];
        [self addSubview:slider];
        
        timePlayedLabel = [[UILabel alloc] init];
        [timePlayedLabel setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:timePlayedLabel];
        
        timeTotalLabel  = [[UILabel alloc] init];
        [timeTotalLabel setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:timeTotalLabel];
    
    
        btnPlay.frame=CGRectMake(0, self.frame.size.height-30, 50, 25);
        
        timePlayedLabel.frame=CGRectMake(55, self.frame.size.height-30, 50, 25);
        timeTotalLabel.frame=CGRectMake(55, self.frame.size.height-80, 50, 25);
        
        slider.frame=CGRectMake(110, self.frame.size.height-30, self.frame.size.width-200,25);
    }
    
    if (btnPlay) {
        [btnPlay setHidden:false];

        [slider setHidden:false];
        [timePlayedLabel setHidden:false];
        [timeTotalLabel setHidden:false];
    }
}
-(void)layoutVideUIHide{
    if (btnPlay) {
        [btnPlay setHidden:true];
        [slider setHidden:true];
        [timePlayedLabel setHidden:true];
        [timeTotalLabel setHidden:true];
    }
}

-(void)sliderStartChanged{
    isSlideDraging=true;
}

-(void)sliderChanged{
    videoplugin.currentTime= slider.value * videoplugin.duration;
}

-(void)play{
    if (status==STATUS_PAUSE) {
        [videoplugin start];
    }else if(status==STATUS_PLAYING){
        [videoplugin pause];
    }else if(status==STATUS_STOP){
        [videoplugin start];
    }
    
}

-(void)turnMode{
    
    // [panoplayer setPlayMode:PANO_MODEL_DEFAULT];
  
    if (_panoplayer.viewMode==VIEWMODE_SPHERE) {
        _panoplayer.gyroEnable=false;
        [_panoplayer setHLookAt:0];
        [_panoplayer setVLookAt:10];
        [_panoplayer setFov:90];
        _panoplayer.viewMode=VIEWMODE_FISHEYE;
    }else if (_panoplayer.viewMode==VIEWMODE_FISHEYE) {
        _panoplayer.gyroEnable=false;
        [_panoplayer setHLookAt:0];
        [_panoplayer setVLookAt:0];
        [_panoplayer setFov:65];
        _panoplayer.viewMode=VIEWMODE_DEF;
    }else if (_panoplayer.viewMode==VIEWMODE_DEF) {
        _panoplayer.gyroEnable=true;
        _panoplayer.viewMode=VIEWMODE_VR;
    }else if (_panoplayer.viewMode==VIEWMODE_VR) {
      _panoplayer.gyroEnable=false;
        [_panoplayer setHLookAt:0];
        [_panoplayer setVLookAt:-90];
        _panoplayer.viewMode=VIEWMODE_LITTLEPLANET;

    }else if (_panoplayer.viewMode==VIEWMODE_LITTLEPLANET) {
        _panoplayer.gyroEnable=false;
        [_panoplayer setHLookAt:0];
        [_panoplayer setVLookAt:90];
        [_panoplayer setFov:90];
        _panoplayer.viewMode=VIEWMODE_SPHERE;
    }else {
        _panoplayer.gyroEnable=false;
        [_panoplayer setHLookAt:0];
        [_panoplayer setVLookAt:0];
        [_panoplayer setFov:65];

        _panoplayer.viewMode=VIEWMODE_DEF;
    }
}



-(void)setPath:(PanoPlayerUrl *)panoplayerurl{
    [_panoplayer Play:panoplayerurl];
}

-(int)viewMode{
    return _panoplayer.viewMode;
}



-(void)cleargc{
    [_panoplayer cleargc];
}

#pragma 事件回调清单 -


//loading
-(void)PanoPlayOnLoading { //加载中
    NSLog(@"panoplay loading");
}
-(void)PanoPlayOnLoaded{//加载完成
    NSLog(@"panoplay loaded");
}

//panorama
-(void)PanoPlayOnEnter:(PanoramaData*)curpanodata{//进入场景
    NSLog(@"pano play onenter");
    [self layoutVideUIHide];
    
    //得到当前场景对象，是否是视频
    videoplugin = [_panoplayer GetCurrentPluginObject];
    if (videoplugin != nil) {
        [self layoutVideUI];
    } else{
        [self layoutVideUIHide];
    }
    
    
}
-(void)PanoPlayonLeave:(PanoramaData*)prepanodata{//离开场景
    NSLog(@"pano play onleave");
}

//hotspot
-(void)PanoPlayOnTapBeforeHotpot:(Hotspot*)hotspot{//点击热点响应前
    NSLog(@"pano play tap hot before");
    
}
-(void)PanoPlayOnTapAfterHotpot:(Hotspot*)hotspot{//点击热点后
    NSLog(@"pano play tap hot after");
}

//plugin
//plugin - video回调
-(void)PluginVideoOnStatusChanged:(PanoVideoPluginStatus)s{
   
    
    status=s;
    if (status==STATUS_PAUSE) {
         NSLog(@"------> PluginVideoOnStatusChanged 暂停");
        [btnPlay setTitle:@"播放" forState:UIControlStateNormal];
    }else if(status==STATUS_PLAYING){
        NSLog(@"------> PluginVideoOnStatusChanged 播放");
        [btnPlay setTitle:@"暂停" forState:UIControlStateNormal];
    }else if(status==STATUS_STOP){
        NSLog(@"------> PluginVideoOnStatusChanged 停止");
        slider.value=0;
        [btnPlay setTitle:@"播放" forState:UIControlStateNormal];
    }else if(status == STATUS_FINISH){
        NSLog(@"------> PluginVideoOnStatusChanged 完成");
       
        [_panoplayer rePlay];
       return;
        /*
        Image* image = [[Image alloc] init];
        [image setUrl:@"http://media.qicdn.detu.com/@/da732428-6fe3-4132-881d-671401a98997/2015-06-25/558bad0222cc9-2048x1024.mp4"];
        [image setType:@"video"];
        [image setIsautoplay:true];
        
        Preview* preview = [[Preview alloc] init];
        
        PanoPlayerUrl* panoplayerurl = [[PanoPlayerUrl alloc] init];
        [panoplayerurl SetImageObject:image preview:preview];
        
        
        [panoplayer Play:panoplayerurl];*/
    }else if(status == STATUS_BUFFER_EMPTY){
        NSLog(@"------> PluginVideoOnStatusChanged 缓冲中");
    }
}
-(void)PluginVideoOnProgessChanged{
   // NSLog(@"PluginVideoOnProgessChanged");
    
    if (!isSlideDraging) {
        //slider.value=videoplugin.currentTime;
        //slider.maximumValue=videoplugin.duration;
        
        [slider setValue:videoplugin.currentTime/videoplugin.duration animated:YES];
        timePlayedLabel.text = [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:slider.value * videoplugin.duration]];
        timeTotalLabel.text = [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:videoplugin.duration]];
    }
}
-(void)PluginVideoOnSeekFinished{
    NSLog(@"PluginVideoOnSeekFinished");
    
    isSlideDraging=false;
}
-(void)PluginVideoOnPlayerError:(NSError *)e{
    NSLog(@"PluginVideoOnPlayerError error %@",e);
}

//error
-(void)PanoPlayOnError:(PanoPlayerErrorCode)e{
   NSLog(@"PanoPlayOnError error %d",e);
}


@end
