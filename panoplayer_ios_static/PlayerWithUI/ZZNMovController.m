//
//  ZZNLiveShowController.m
//  panoPlayerDemo
//
//  Created by 吴泽 on 15/12/15.
//  Copyright © 2015年 shenxing. All rights reserved.
//




#import "ZZNMovController.h"
#import "PanoPlayer.h"
#import "ZZNPanoPlayer.h"
#import "VideoPlugin.h"
#import "ZZNMacro.h"
#import "Masonry.h"
#import "UIButton+wz.h"
#import "ReactiveCocoa.h"

#define maskAlpha 0.8
#define playBar 40
#define btnHeight 60
#define btnWidth 100
//#define testColor  [UIColor randomColor]
#define testColor [UIColor clearColor]
//橙色字体
#define ZZN_UI_COLOR_ORANGE UIColorFromRGB(0xffc600)
#define ZZN_UI_BACK_COLOR UIColorFromRGB(0xffbc09)
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define strongifyy @strongify(self);

@interface ZZNMovController ()<UIGestureRecognizerDelegate, PanoPlayDelegate>
@property UITapGestureRecognizer *backgroundTap;
@property (nonatomic, strong) ZZNPanoPlayer *panoplayer;
@property (nonatomic, assign) PanoVideoPluginStatus playMovStatus;//播放状态
@property(nonatomic, weak) UIView *playerBarBackView;//播放条背景
@property (nonatomic) VideoPlugin* videoplugin;
@property (nonatomic) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) UIButton *btn_typeSelecterd;//按钮选中的模式
@property (nonatomic, assign) int viewMode;//视角类型
Button_(replayBtn);//重播按钮
Slider_(slider);//进度条
Button_(playBtn);//播放按钮
Label_(lab_time);//播放时间
Label_(lab_playTime);//已经播放时间
Label_(lab_totalTime);//全部时间
View_(navView);
Label_(title_pic);//标题
Button_(settingBtn);//设置按钮
Button_(setType);//切换视角
View_(settingsView);//设置界面（画质陀螺仪旋转）
BOOL_(panoPlayerLoading);//是否在加载中
BOOL_(fullScreen);//是否全屏
BOOL_(isShowMask);//是否显示遮盖
View_(typeVertical);//竖屏的模式选择
Button_(panBtn);
Button_(fishBtn);
Button_(planetBtn);
Button_(VrBtn);
Button_(sphereBtn);
Button_(label2);//播放模式label
Button_(backMask1);//透明遮盖
Button_(backMask2);//灰色遮盖
@end


@implementation ZZNMovController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canRotate = YES;
    self.view.backgroundColor = [UIColor grayColor];
    //播放视角
    self.viewMode = 1;

    //播放器
    [self setupPanoPlayer];
    
   //进度条
    [self setupPlayerBarView];
    
    //手势
    UITapGestureRecognizer *backgroundTap = [[UITapGestureRecognizer alloc] init];
    [self.view addGestureRecognizer:backgroundTap];
    backgroundTap.delegate = self;
    self.backgroundTap = backgroundTap;

    
    [self initCommand];

    //导航栏
    [self setupNav];

    //右下角弹出菜单
    [self setupSettings];

    //视角切换
    [self setupSetType];

    //遮盖
    [self setupMask];
    
}


- (void)setupPlayerBarView {
    //-----播放条背景-------
    UIView *playerBarBackView = [[UIView alloc] init];
    [self.view addSubview:playerBarBackView];
    [playerBarBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.height.equalTo(@40);
        make.right.equalTo(@0);
    }];
    self.playerBarBackView = playerBarBackView;
    UIImageView *backpic = [[UIImageView alloc] init];
    backpic.image = [UIImage imageNamed:@"zzn_shadow"];
    [_playerBarBackView addSubview:backpic];
    [backpic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    
    _replayBtn = [[UIButton alloc] init ];
    UIImageView *replayImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"replay"]];
    UILabel *replayLabel = [[UILabel alloc] init];
    replayLabel.text = @"重播";
    replayLabel.textColor = [UIColor whiteColor];
    replayLabel.textAlignment = NSTextAlignmentCenter;
    [_replayBtn addSubview:replayImage];
    [_replayBtn addSubview:replayLabel];
    [replayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerX.equalTo(@0);
        make.bottom.equalTo(_replayBtn.mas_centerY);
    }];
    [replayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.top.equalTo(replayImage.mas_bottom);
    }];
    [self.panoplayer addSubview:_replayBtn];
    
    _replayBtn.hidden = YES;
    [_replayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
        make.center.equalTo(@0);
    }];
    @weakify(self);
    _replayBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        strongifyy
        self.playMovStatus = STATUS_PLAYING;
        self.panoplayer.viewMode = self.viewMode;
        self.panoplayer.item = self.item;
        self.replayBtn.hidden = YES;
        return [RACSignal empty];
    }];
    
    
    _playBtn = [[UIButton alloc] init];
    _playBtn.imageEdgeInsets = UIEdgeInsetsMake(13, 10, 13, 20);
    [_playerBarBackView addSubview:_playBtn];
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.width.equalTo(@(playBar));
    }];
    [_playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [_playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateHighlighted];
    [_playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    _playBtn.rac_command = ({
        RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                strongifyy
                if (self.playMovStatus == STATUS_PLAYING || self.playMovStatus == STATUS_BUFFER_EMPTY) {
                    [self.videoplugin pause];
                } else {
                    [self.videoplugin start];
                }
                [subscriber sendCompleted];
                return nil;
            }];
        }];
        command;
        
    });
    
    
    
    
    _settingBtn = [[UIButton alloc] init];
    [_playerBarBackView addSubview:_settingBtn];
    _settingBtn.backgroundColor = testColor;
    [_settingBtn setImage:[UIImage imageNamed:@"settings2"] forState:UIControlStateNormal];
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    //设置按钮
    _settingBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        strongifyy
        self.settingsView.hidden = !self.settingsView.hidden;
        return [RACSignal empty];
    }];
    //视角切换
    _setType = [[UIButton alloc] init];
    _settingBtn.backgroundColor = testColor;
    [_playerBarBackView addSubview:_setType];
    [_setType setImage:[UIImage imageNamed:@"type2"] forState:UIControlStateNormal];
    [_setType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.equalTo(_settingBtn.mas_left);
        make.bottom.equalTo(@0);
    }];
    _setType.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        strongifyy
        self.typeVertical.hidden = !self.typeVertical.hidden;
        return [RACSignal empty];
    }];
    
    
    _lab_playTime = [[UILabel alloc] init];
    _lab_playTime.textAlignment = NSTextAlignmentCenter;
    _lab_playTime.font = [UIFont systemFontOfSize:13];
    _lab_playTime.text = @"000:00";
    [_playerBarBackView addSubview:_lab_playTime];
    [_lab_playTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.centerY.equalTo(@0);
        make.left.equalTo(_playBtn.mas_right).offset(-15);
    }];
    
    
    _lab_totalTime = [[UILabel alloc] init];
    _lab_totalTime.backgroundColor = testColor;
    _lab_totalTime.textAlignment =  NSTextAlignmentCenter;
    _lab_playTime.textColor = _lab_totalTime.textColor = [UIColor whiteColor];
    _lab_totalTime.font = [UIFont systemFontOfSize:13];
    _lab_totalTime.text = @"000:00";
    [_playerBarBackView addSubview:_lab_totalTime];
    [_lab_totalTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.centerY.equalTo(@0);
        make.right.equalTo(_setType.mas_left).offset(5);
    }];
    
    _slider = [[UISlider alloc] init];
    [_playerBarBackView addSubview:_slider];
    [_slider setThumbImage:[UIImage imageNamed:@"dot_36"] forState:UIControlStateNormal];
    [_slider setMinimumTrackTintColor:[UIColor orangeColor]];
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(_lab_playTime.mas_right).offset(0);
        make.right.equalTo(_lab_totalTime.mas_left).offset(0);
    }];
    
    
    if (self.item.isLiveShow || self.item.fileType == 1) { //直播或者图片 隐藏进度条
        _replayBtn.hidden = _playBtn.hidden = _lab_playTime.hidden = _lab_totalTime.hidden = _slider .hidden = backpic.hidden = YES;
    }
}


- (void)setupPanoPlayer {
    
    ZZNPanoPlayer *panoplayer = [[ZZNPanoPlayer alloc] init];
    [self.view addSubview:panoplayer];
    self.panoplayer = panoplayer;
    self.panoplayer.panoPlayer.delegate = self;
    self.playMovStatus = STATUS_BUFFER_EMPTY;
    [panoplayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"HH:mm:ss";
    self.dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
}

- (void)setupMask {
    //遮盖
    _backMask1  = [[UIButton alloc] init];
    [self.view addSubview:_backMask1];
    [_backMask1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    _backMask1.hidden = YES;
    @weakify(self);
    _backMask1.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        strongifyy
        self.backMask1.hidden = YES;
        return [RACSignal empty];
    }];
   }


- (void)setupNav {
    CGFloat navHeight = 44;
    self.navigationBarHidden = YES;
    _navView = [[UIView alloc] init];
    [self.view addSubview:_navView];
    [_navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
        make.height.equalTo(@(navHeight));
    }];
    
    UIImageView *shadow = [[UIImageView alloc] init];
    shadow.backgroundColor =  [UIColor blackColor];
    [_navView addSubview:shadow];
    [shadow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    UIButton *back_btn = [[UIButton alloc] init];
    [back_btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_navView addSubview:back_btn];
    [back_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(navHeight, navHeight));
        make.left.equalTo(@0);
        make.top.equalTo(@0);
    }];
    @weakify(self);
    back_btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        strongifyy
        [self dismissViewControllerAnimated:YES completion:nil];
        return [RACSignal empty];
    }];
    
    _title_pic = [[UILabel alloc] init];
    _title_pic.textColor = [UIColor whiteColor];
    _title_pic.text = self.item.title;
    [_navView addSubview:_title_pic];
        [_title_pic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(back_btn.mas_right);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            make.right.equalTo(@0);
            
        }];
    
}


- (void)setupSettings {

    @weakify(self);
    _settingsView = [[UIView alloc] init];
    _settingsView.hidden = YES;
    [self.view addSubview:_settingsView];
    [_settingsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    UIButton *backMask = [[UIButton alloc] init];
    backMask.backgroundColor = [UIColor blackColor];
    backMask.alpha = maskAlpha;
    [_settingsView addSubview:backMask];
    [backMask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    backMask.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        strongifyy
        self.settingsView.hidden = YES;
        return [RACSignal empty];
    }];;
    
    
    UIButton *gyro = [self creatSetButtonWithTitle:@"陀螺仪:" tag:1];
    UIButton *gyroOn = [self creatSetButtonWithTitle:@"开启" tag:2];
    UIButton *gyroOff = [self creatSetButtonWithTitle:@"关闭" tag:3];
    UIButton *rotate = [self creatSetButtonWithTitle:@"旋    转:" tag:4];
    UIButton *rotateOn = [self creatSetButtonWithTitle:@"开启" tag:5];
    UIButton *rotateOff = [self creatSetButtonWithTitle:@"关闭" tag:6];
    
    CGSize btnSize = CGSizeMake(70, 25);
    
        [gyroOn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(btnSize);
            make.right.equalTo(self.view.mas_centerX).offset(-5);
            make.centerY.equalTo(@0);
        }];
        [gyroOff mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(btnSize);
            make.left.equalTo(self.view.mas_centerX).offset(5);
            make.top.equalTo(gyroOn.mas_top);
        }];
        [gyro mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(btnSize);
            make.top.equalTo(gyroOn.mas_top);
            make.right.equalTo(gyroOn.mas_left).offset(-10);
        }];
        
        [rotateOn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(btnSize);
            make.top.equalTo(gyroOn.mas_bottom).offset(16);
            make.left.equalTo(gyroOn.mas_left);
        }];
        
        [rotateOff mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(btnSize);
            make.top.equalTo(gyroOn.mas_bottom).offset(16);
            make.left.equalTo(gyroOff.mas_left);
        }];
        
        [rotate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(btnSize);
            make.left.equalTo(gyro.mas_left);
            make.top.equalTo(rotateOff.mas_top);
        }];
    
}

- (void)setupSetType {
    @weakify(self);
    //模式选择
    UIView *typeVertical = [[UIView alloc] init];
    typeVertical.hidden = YES;
    [self.view addSubview:typeVertical];
    [typeVertical mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    self.typeVertical = typeVertical;
    UIButton *backMask = [[UIButton alloc] init];
    [typeVertical addSubview:backMask];
    backMask.backgroundColor = [UIColor blackColor];
    backMask.alpha = maskAlpha;
    [backMask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    backMask.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        strongifyy
        self.typeVertical.hidden = YES;
        return [RACSignal empty];
    }];
    
    CGSize typeBtnSize = CGSizeMake(btnWidth, btnHeight);
    UIButton *panBtn = [self creatTypeButtonWithImage:@"mode-2" image_selected:@"mode2_hignlight" title:@"全景" superView:typeVertical];
    self.panBtn = panBtn;
    [panBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    
    UIButton *fishBtn = [self creatTypeButtonWithImage:@"mode-1" image_selected:@"mode1_highlight" title:@"鱼眼" superView:typeVertical];
    self.fishBtn = fishBtn;
    [fishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(typeBtnSize);
        make.right.equalTo(panBtn.mas_left).offset(0);
        make.top.equalTo(panBtn.mas_top);
    }];
    
    
    
    UIButton *planetBtn = [self creatTypeButtonWithImage:@"mode-3" image_selected:@"mode3_highlight" title:@"小行星" superView:typeVertical];
    self.planetBtn = planetBtn;
    [planetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(typeBtnSize);
        make.left.equalTo(panBtn.mas_right).offset(0);
        make.top.equalTo(panBtn.mas_top);
    }];
    
    UIButton *VrBtn = [self creatTypeButtonWithImage:@"mode-5" image_selected:@"mode5-highlight" title:@"VR" superView:typeVertical];
    self.VrBtn = VrBtn;
    [VrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(typeBtnSize);
        make.centerX.equalTo(@0);
        make.top.equalTo(panBtn.mas_bottom);
    }];
    
    
    
    UIButton *sphereBtn = [self creatTypeButtonWithImage:@"mode-4" image_selected:@"mode4_highlight" title:@"半球" superView:typeVertical];
    self.sphereBtn = sphereBtn;
    [sphereBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(typeBtnSize);
        make.right.equalTo(VrBtn.mas_left).offset(0);
        make.top.equalTo(VrBtn.mas_top);
    }];
    
    
    UIButton *label2 = [[UIButton alloc] init];
    self.label2 = label2;
    [label2 setTitle:@"播放模式选择" forState:UIControlStateNormal] ;
    label2.titleLabel.font  = [UIFont systemFontOfSize:14];
    [label2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [typeVertical addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@30);
        make.bottom.equalTo(panBtn.mas_top).offset(-25);;
    }];
    
}

- (void)initCommand {
    @weakify(self);
    
//    旋转
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIDeviceOrientationDidChangeNotification object:nil] subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            [self showAlign];
        });
    }];
    
//    点击全屏
    [[self.backgroundTap rac_gestureSignal] subscribeNext:^(id x) {
        strongifyy
        self.fullScreen = !self.fullScreen;
        self.navView.hidden = self.playerBarBackView.hidden = self.fullScreen;
        if (self.panoPlayerLoading == YES) {
            self.playerBarBackView.hidden = YES;
        }
        
    }];
    
//    播放item
    
    [RACObserve(self,item) subscribeNext:^(id x) {
        @strongify(self);
        if(x != nil){
            
            BOOL play = self.playMovStatus == STATUS_PLAYING || self.playMovStatus == STATUS_BUFFER_EMPTY;
            
            if (play) {
                self.panoplayer.item = self.item;
            } else {
                self.panoplayer.item = nil;
            }
            
            
        }
    }];
    
    [[self.slider rac_signalForControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside] subscribeNext:^(id x) {
        strongifyy
        self.videoplugin.currentTime = [(UISlider *)x value] * self.videoplugin.duration;
    }];
    
    RAC(self.playBtn, selected) = [RACObserve(self, playMovStatus) map:^id(id value) {
        return @([value integerValue] == STATUS_PLAYING || [value integerValue] == STATUS_BUFFER_EMPTY);
    }];
    
    [RACObserve(self, panoPlayerLoading) subscribeNext:^(id x) {
        strongifyy
        self.playerBarBackView.hidden = [x boolValue];
        
        if (self.navView.hidden == YES) {
            self.playerBarBackView.hidden = YES;
        }
        
    }];
    
}


- (void)showAlign {
    UIInterfaceOrientation toInterfaceOrientation = self.interfaceOrientation;
    
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        [self remasMakeForVertical];
    }else{
        [self remasMakeForLandscape];
        
    }
}

- (UIButton *)creatSetButtonWithTitle:(NSString *)title tag:(int )tag{
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.layer.cornerRadius = 12.5;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.layer.masksToBounds = YES;
    btn.tag = tag;
    if (btn.tag!=1 && btn.tag!=4 && btn.tag!=7) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn setBackgroundImage:[UIImage imageNamed:@"buttonBack"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        if (btn.tag == 3 || btn.tag == 6) {
            btn.selected = YES;
        }
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    @weakify(btn, self);
    btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(btn, self);
        if (btn.selected == YES) {
            
        } else {
            btn.selected = !btn.selected;
            if (btn.tag == 2) {//陀螺仪开启
                
                self.panoplayer.gyroEnable = YES;
                for (UIButton *b in self.settingsView.subviews) {
                    b.selected =  b.tag == 3 ? !btn.selected : b.selected;
                }
            } else if(btn.tag == 3){//陀螺仪关闭
                self.panoplayer.gyroEnable = NO;
                for (UIButton *b in self.settingsView.subviews) {
                    b.selected =  b.tag == 2 ? !btn.selected : b.selected;
                }
            } else if(btn.tag == 5){//旋转开启
                self.panoplayer.rotateEnable = YES;
                for (UIButton *b in self.settingsView.subviews) {
                    b.selected =  b.tag == 6 ? !btn.selected : b.selected;
                }
            } else if(btn.tag == 6){//旋转关闭
                self.panoplayer.rotateEnable = NO;
                for (UIButton *b in self.settingsView.subviews) {
                    b.selected =  b.tag == 5 ? !btn.selected : b.selected;
                }
            } else if(btn.tag == 8){//超清
            } else if(btn.tag == 9){//高清
            } else if(btn.tag == 10){//流畅
            }
        }
        
        return [RACSignal empty];
    }];
    [_settingsView addSubview:btn];
    return btn;
}


- (UIButton *)creatTypeButtonWithImage:(NSString *)image image_selected:(NSString *)image_selected title:(NSString *)title superView:(UIView *)superView {
    UIButton *btn = [UIButton ButtonWithFont:12 image:image imageH:image imageSlected:image_selected title:title imageCenterRatio:0.25 titleCenterRatio:0.75];
    
    [btn setTitleColor:ZZN_UI_COLOR_ORANGE forState:UIControlStateSelected];
    [superView addSubview:btn];
    
    
    @weakify(self);
    btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        strongifyy
        self.btn_typeSelecterd.selected = !self.btn_typeSelecterd.selected;
        self.btn_typeSelecterd = btn;
        self.btn_typeSelecterd.selected = YES;
        self.typeVertical.hidden = YES;
        if ([title isEqualToString:@"全景"]) {
            self.panoplayer.viewMode = self.viewMode = 2;
            [self setGyroWithMode:2];
        } else if([title isEqualToString:@"鱼眼"]){
            self.panoplayer.viewMode =  self.viewMode = 1;
            [self setGyroWithMode:1];
        } else if([title isEqualToString:@"小行星"]){
            self.panoplayer.viewMode = self.viewMode = 3;
            [self setGyroWithMode:3];
        } else if([title isEqualToString:@"半球"]){
            self.panoplayer.viewMode = self.viewMode = 4;
            [self setGyroWithMode:4];
        } else if([title isEqualToString:@"VR"]){
            self.panoplayer.viewMode = self.viewMode = 5;
            [self setGyroWithMode:5];
        }
        
        return [RACSignal empty];
    }];
    return btn;
    
    
    
}

//重新排列（竖屏）
- (void)remasMakeForVertical {
    CGSize typeBtnSize = CGSizeMake(btnWidth, btnHeight);
    [_panBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    
    [_fishBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(typeBtnSize);
        make.right.equalTo(_panBtn.mas_left).offset(0);
        make.top.equalTo(_panBtn.mas_top);
    }];
    
    [_planetBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(typeBtnSize);
        make.left.equalTo(_panBtn.mas_right).offset(0);
        make.top.equalTo(_panBtn.mas_top);
    }];
    
    [_VrBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(typeBtnSize);
        make.centerX.equalTo(@0);
        make.top.equalTo(_panBtn.mas_bottom);
    }];
    
    [_sphereBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(typeBtnSize);
        make.right.equalTo(_VrBtn.mas_left).offset(0);
        make.top.equalTo(_VrBtn.mas_top);
    }];
    
    [_label2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@30);
        make.bottom.equalTo(_panBtn.mas_top).offset(-25);;
    }];
    
}

//重新排列（横屏）
- (void)remasMakeForLandscape {
    CGSize typeBtnSize = CGSizeMake(btnWidth, btnHeight);
    CGFloat space = 0;
    [_panBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(typeBtnSize);
        make.centerY.equalTo(@0);
        make.right.equalTo(_planetBtn.mas_left).offset(space);
    }];
    
    [_fishBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(typeBtnSize);
        make.centerY.equalTo(@0);
        make.right.equalTo(_panBtn.mas_left).offset(space);
    }];
    
    [_planetBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(typeBtnSize);
        make.center.equalTo(@0);
    }];
    
    [_VrBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(typeBtnSize);
        make.centerY.equalTo(@0);
        make.left.equalTo(_sphereBtn.mas_right).offset(space);
        
    }];
    
    [_sphereBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(typeBtnSize);
        make.centerY.equalTo(@0);
        make.left.equalTo(_planetBtn.mas_right).offset(space);
        
    }];
    
    [_label2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@30);
        make.bottom.equalTo(_planetBtn.mas_top).offset(-40);;
    }];
    
}



//销毁播放器
-(void)dealloc{
    
    [self clearPlayer];
    [self.panoplayer removeFromSuperview];
}

////销毁播放器
-(void)clearPlayer{
    if(self.videoplugin && [self.videoplugin respondsToSelector:@selector(pause)]){
        [self.videoplugin pause];
    }
    if(self.panoplayer.panoPlayer){
        [self.panoplayer.panoPlayer cleargc];
        self.panoplayer.panoPlayer = nil;
    }
}

//返回
-(void)back{
    [self clearPlayer];
    [self.panoplayer removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setGyroWithMode:(int )mode {
    if (mode == 5) {
        for (UIButton *btn in self.settingsView.subviews) {
            if (btn.tag == 2) {
                btn.selected = YES;
            } else if(btn.tag == 3){
                btn.selected = NO;
            }
        }} else {
            
            for (UIButton *btn in self.settingsView.subviews) {
                if (btn.tag == 2) {
                    btn.selected = NO;
                } else if(btn.tag == 3){
                    btn.selected = YES;
                }
            }
        }
}
#pragma mark - PanoPlayDelegate
-(void)PanoPlayOnLoading{

    self.panoPlayerLoading = YES;
}
-(void)PanoPlayOnLoaded{
    
    if (self.btn_typeSelecterd == nil ) {
        
        for (UIButton *btn in self.typeVertical.subviews) {
            NSString *title = btn.titleLabel.text;
            
            if (self.panoplayer.panoPlayer.viewMode == VIEWMODE_SPHERE) {
                if ([title isEqualToString:@"鱼眼"]) {
                    self.btn_typeSelecterd.selected = !self.btn_typeSelecterd.selected;
                    self.btn_typeSelecterd = btn;
                    self.btn_typeSelecterd.selected = YES;
                }
            }
            if (self.panoplayer.panoPlayer.viewMode == VIEWMODE_DEF) { //VIEWMODE_DEF
                if ([title isEqualToString:@"全景"]) {
                    self.btn_typeSelecterd.selected = !self.btn_typeSelecterd.selected;
                    self.btn_typeSelecterd = btn;
                    self.btn_typeSelecterd.selected = YES;
                }
            }
        }
        
        
    }
    
   self.panoPlayerLoading = NO;

    
    
}
-(void)PanoPlayOnEnter:(PanoramaData*)curpanodata{
  
    self.videoplugin = [self.panoplayer.panoPlayer GetCurrentPluginObject];
}
-(void)PanoPlayonLeave:(PanoramaData*)prepanodata{
}
-(void)PanoPlayOnTapBeforeHotpot:(Hotspot*)hotspot{
}
-(void)PanoPlayOnTapAfterHotpot:(Hotspot*)hotspot{
}
-(void)PluginVideoOnStatusChanged:(PanoVideoPluginStatus)s{
    self.playMovStatus = s;
    switch (s) {
        case STATUS_PLAYING: {
            
            break;
        }
        case STATUS_PAUSE: {
            
            break;
        }
        case STATUS_STOP: {
            
            break;
        }
        case STATUS_FINISH:{
           
            self.replayBtn.hidden = NO;
            [self.slider setValue:1 animated:YES];
            NSString *total = [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.videoplugin.duration]];
            self.lab_time.text = [NSString stringWithFormat:@"%@ / %@",total,total];
            self.lab_playTime.text =  [self setTime:total];
            self.lab_totalTime.text = [self setTime:total];
            break;
        }
        case STATUS_BUFFER_EMPTY:{
            
            break;
        }
        default: {
            break;
        }
    }
    
    
    
}
-(void)PluginVideoOnProgessChanged{
    if (!self.slider.tracking && self.replayBtn.hidden) {
        [self.slider setValue:self.videoplugin.currentTime/self.videoplugin.duration animated:YES];
        NSString *played = [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.slider.value * self.videoplugin.duration]];
        NSString *total = [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.videoplugin.duration]];
        self.lab_time.text = [NSString stringWithFormat:@"%@ / %@",played,total];
        self.lab_playTime.text = [self setTime:played];
        self.lab_totalTime.text = [self setTime:total];
        
    }
}
-(void)PluginVideoOnSeekFinished{
}
-(void)PluginVideoOnPlayerError:(NSError *)e{
//    ZZNLogWarn(@"视频播放异常:%@",e);
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ((touch.view == self.slider)  || (touch.view == self.backMask1)) {
        return NO;
    }
    return YES;
}


- (NSString *)setTime:(NSString *)time {
    NSString *showTime;
    NSArray *array = [time componentsSeparatedByString:@":"];
    NSString *str1 = [NSString stringWithFormat:@"%d", [array[0] intValue] *60 + [array[1] intValue]];
    showTime = [str1 stringByAppendingString:[NSString stringWithFormat:@":%@", array[2]]];
    
    return showTime;
}

@end
