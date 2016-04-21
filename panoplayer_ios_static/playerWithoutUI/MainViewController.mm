//
//  MainViewController.m
//  PanoPlayer
//
//  Created by apple on 15/7/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MainViewController.h"

#import "PanoPlayView.h"



#define SETBANQIUPANO panoview.panoplayer.viewMode=VIEWMODE_SPHERE; \
  [panoview.panoplayer setVLookAt:10]; \
   [panoview.panoplayer setFov:90]; \

@interface MainViewController (){
    PanoPlayView* panoview;
    NSString* tpl;
    NSString *xmlurl;
    UIImageView *iview;
    PanoPlayerUrl* panoplayerurl;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    panoview = [[PanoPlayView alloc] init];
    [self.view addSubview:panoview];
    panoview.frame = self.view.frame;
   
    
    
    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(20, 0, 50, 25)];
    [btn1 setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    [btn1 setTitleColor:[UIColor colorWithWhite:0 alpha:1] forState:UIControlStateNormal];
    [btn1 setTitle:@"加载" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(imgclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
   
    UIButton *btn12=[[UIButton alloc]initWithFrame:CGRectMake(80, 0, 50, 25)];
    [btn12 setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    [btn12 setTitleColor:[UIColor colorWithWhite:0 alpha:1] forState:UIControlStateNormal];
    [btn12 setTitle:@"合成" forState:UIControlStateNormal];
    [btn12 addTarget:self action:@selector(img3click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn12];

    
    UIButton *btnBack=[[UIButton alloc]initWithFrame:CGRectMake(160, 0, 50, 25)];
    [btnBack setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    [btnBack setTitleColor:[UIColor colorWithWhite:0 alpha:1] forState:UIControlStateNormal];
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    tpl = @"<?xml version=\"1.0\" encoding=\"UTF-8\" ?> \
    <DetuVr> \
    <settings init=\"pano1\" initmode=\"default\" enablevr=\"false\" title=\"\"></settings> \
     \
     \
    <scenes> \
    <scene name=\"pano1\" title=\"\" thumburl=\"\"> \
    <preview url=\"[IOS_DEFAULT_PATH]/ew_detunew.jpg\" /> \
    <image type=\"video\"  url=\"rtsp://192.168.1.254/xxx.mov\" \
     \
     \
    device=\"1\" \
     \
    /> <view hlookat='0' vlookat='90' fov='110' viewmode='sphere' /> \
    </scene> \
    </scenes> \
    </DetuVr>";
    
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/public_timeline.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    
   panoplayerurl = [[PanoPlayerUrl alloc] init];
    
 
  // xmlurl = @"http://192.168.0.108:8080/xml.xml?kkk";
   xmlurl = @"http://www.detu.com/ajax/pano/xml/90805/app";
 [panoplayerurl SetXMlUrl:xmlurl];
  //      [panoplayerurl SetXmlContent:tpl];
    [panoview setPath:panoplayerurl];
    
    
}

-(void)back{
    [panoview cleargc];
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)imgclick{

     [panoview setPath:panoplayerurl];
}

-(void)img3click{
    int a = panoview.panoplayer.viewMode;
    [panoview.panoplayer cleargc];
  
    [panoview.panoplayer getVLookAt];
    [panoview.panoplayer getFov];
    
    [panoview.panoplayer getCurrentPanoramaData].image.rz=-90;
    [panoview.panoplayer getCurrentPanoramaData].image.ry=-90;
   
    UIImage* panoimage;
    UIImage* resimg;
  //  UIImage* image1 =  [UIImage imageWithContentsOfFile:@"/Users/qiruisun/Desktop/test/4/1.jpg"];
  //  UIImage* image2 =  [UIImage imageWithContentsOfFile:@"/Users/qiruisun/Desktop/test/4/2.jpg"];
 //   UIImage* image240 =  [UIImage imageWithContentsOfFile:@"/Users/qiruisun/Desktop/test/4/1.jpg"];
    
  //
  //  GLStitchImage *stitchimage = [[GLStitchImage alloc]init];
  //  resimg = [stitchimage stitchPanoUIImage:image1 fisheyeimage2:image2];
    
  //  GLProjectiveImage *prejectimage = [[GLProjectiveImage alloc]init];
    
   
    resimg = [panoview.panoplayer getScreenShot];
   // resimg = [prejectimage convertFisheyeToRect:image240 deviceid:1];

    //resimg = [prejectimage convertPanoUIImage:image240 deviceid:1];
    
    
    //panoimage = [prejectimage convertPanoUIImage:image7 deviceid:1 iscrop:true];
    //[UIImageJPEGRepresentation(panoimage, 1) writeToFile:@"/Users/qiruisun/Desktop/test/3_pano_1.jpg" atomically:true];
    
    //panoimage = [prejectimage convertFisheyeToRect:image7 deviceid:1];
    //[UIImageJPEGRepresentation(panoimage, 1) writeToFile:@"/Users/qiruisun/Desktop/test/3_rect.jpg" atomically:true];
    
    
  
   //resimg = [prejectimage convertDistortUIImage:image2 deviceid:2];
    
  //  [self saveImageToPhotos:resimg];

 // [iview setImage:resimg];

    return;
    /*
 [UIImageJPEGRepresentation(resimg, 1) writeToFile:@"/Users/qiruisun/Desktop/test/result.jpg" atomically:true];
    NSLog(@"success");
    */
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
