# iOS SDK使用指南 #
## 产品概述 
###iOS SDK包含全景图片、VR视频、漫游主题等多种展示方式,支持小行星模式、陀螺仪、VR双屏沉浸式观看。您只需一个链接地址或是一条配置即可展现炫酷的全景效果。


## 下载并集成SDK  **（注意：仅支持真机调试）**


### 配置说明 ###

###下载sdk包之后，将sdk包复制项目目录下

做以下配置

 在Linked Frameworks and Libraries 添加三个库

libz2.tbd

libxml2.tbd

libc++.tbd
![](http://developer.detu.com/Public/Uploads/2016-04-20/5716e60b489d7.png)

### 添加相关路径 ###

#### 将IJKMediaFramework.framework 和opencv2 所在路径添加到   Framework search Paths
 
 将include文件夹所在路径和IJKMediaFramework.framework的headers文件夹路径添加到Header Search Paths
 
 将libPanoPlayerStatic.a 和 thirdPart文件夹所在路径添加到Library Search Paths




## 播放器的引入 ##

### 在控制器添加播放器 ###


播放器PanoPlayer继承自UIView 播放器协议：PanoPlayDelegate

	PanoPlayer *panoPlayer = [[PanoPlayer alloc] init];
    self.panoPlayer = panoPlayer;
    [self.view addSubview:panoPlayer];
    panoPlayer.frame = self.view.frame;
    self.panoPlayer.delegate = self; 
	
### 播放本地视频和图片 ###

需要创建 PanoPlayerUrl类
	
	PanoPlayerUrl *panoplayerurl = [[PanoPlayerUrl alloc] init]
	
创建xml

	NSString *tempURl = @"<?xml version=\"1.0\" encoding=\"UTF-8\" ?> \
    <DetuVr> \
    <settings init=\"pano1\" initmode=\"default\" enablevr=\"false\" title=\"\"></settings> \
    \
    \
    <scenes> \
    <scene name=\"pano1\" title=\"%title\" thumburl=\"%thumburl\"> \
    <preview url=\"\" /> \
    <image type=\"%type\"  url=\"%url\" \
    \
    \
    device=\"0\" \
    \
    /> <view hlookat='0' vlookat='90' fov='110' viewmode='default' /> \
    </scene> \
    </scenes> \
    </DetuVr>";
	

替换XML相关配置

|  配置 | 类型   |参数|
| :------------ | :------------ |:------------ |
|  fileType | 图片  |@"sphere"|
|  fileType | 视频  |@"video"|


 	NSString *fileType = @"sphere";
    //替换文件类型
    tempUrl = [tempUrl stringByReplacingOccurrencesOfString:@"%type" withString:fileType];

 

    //替换文件地址 （若是本地文件， 完整路径必须带  file：//）路径不能带中文
    tempUrl = [tempUrl stringByReplacingOccurrencesOfString:@"%ul" withString:url];


    //加载xml 播放资源
    [panoplayerurl SetXmlContent:tempUrl];
    [self.panoPlayer Play:panoplayerurl];
	

### 播放网络图片 ###
实例一个panoPlayerUrl，然后传入图片地址

	PanoPlayerUrl *panoPlayerUrl = [[PanoPlayerUrl alloc] init];
	//示例图片
    NSString *app_config_pic = @"http://www.detu.com/ajax/pano/xml/61505";
    [panoPlayerUrl SetXMlUrl:app_config_pic];
    [self.panoPlayer Play:panoPlayerUrl];
	
	

### 播放网络视频 ###
实例一个panoPlayerUrl，然后传入视频地址

	PanoPlayerUrl *panoPlayerUrl = [[PanoPlayerUrl alloc] init];
    //示例视频
    NSString *app_config_mov =  @"http://www.detu.com/ajax/pano/xml/68356";
    [panoPlayerUrl SetXMlUrl:app_config_pic];
    [self.panoPlayer Play:panoPlayerUrl];
	


###  播放器代理方法 ###

| 代理方法  |方法说明  |
| ------------ | ------------ | 
| -(void)PanoPlayOnLoading  | 加载中|  
   |-(void)PanoPlayOnLoaded   |加载结束   |
   | -(void)PanoPlayOnEnter:(PanoramaData*)curpanodata   |进入场景   |
  | -(void)PanoPlayonLeave:(PanoramaData*)prepanodata  |离开场景   |
   | -(void)PluginVideoOnStatusChanged:(PanoVideoPluginStatus)s|video Plugin的回调  |
   | -(void)PluginVideoOnProgessChanged|视频进度的改变   |
   | -(void)PluginVideoOnSeekFinished|播放结束   |
   | -(void)PluginVideoOnPlayerError:(NSError *)e|视频播放异常  |



        

### 视频进度条相关 ###

get插件 :`self.videoplugin = [self.panoPlayer GetCurrentPluginObject];`

当前时间 :`self.videoplugin.currentTime`

视频总长 :`self.videoplugin.duration`

开始播放 :`[self.videoplugin start];`

暂停播放 ：`[self.videoplugin pause];`


正在播放：`        STATUS_PLAYING`
暂停：`       STATUS_PAUSE`
停止：`       STATUS_STOP`
结束：`        STATUS_FINISH`
空状态：`        STATUS_BUFFER_EMPTY`




### 播放器视角相关模式设置 ###


播放器的陀螺仪开启 /关闭
	
   ` self.panoPlayer.gyroEnable = YES; //NO`

播放器的VR模式开启

    `[self.panoPlayer setViewMode:VIEWMODE_VR];`

模式说明

|  模式 |说明   |
| :------------ | :------------ |
| VIEWMODE_SPHERE  | 鱼眼模式  |
| VIEWMODE_DEF  | 全景模式  |
| VIEWMODE_LITTLEPLANET |小行星模式   |
| ViewMode.VIEWMODE_FLAT  | 平面模式  |
| ViewMode.VIEWMODE_VR  |VR 模式   |



设置完相关角度之后  给播放器set viewMode

     [self.panoPlayer setViewMode:mode];
	 
### 注意事项 ###
播放结束退出控制器的时候 一定要销毁播放器

        [self.panoPlayer cleargc];
		
如果播放的是视频，需要停止视频

		[self.videoplugin pause];
