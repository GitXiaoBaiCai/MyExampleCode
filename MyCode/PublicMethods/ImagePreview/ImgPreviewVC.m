//
//  ImgPreviewVC.m
//  ImageBrowser
//
//  Created by msk on 16/9/1.
//  Copyright © 2016年 msk. All rights reserved.
//

#import "ImgPreviewVC.h"
#import "PhotoView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ImgPreviewVC ()<UIScrollViewDelegate,PhotoViewDelegate,UIActionSheetDelegate>{
    
    NSMutableArray *_subViewArray;//scrollView的所有子视图
}

/** 背景容器视图 */
@property(nonatomic,strong) UIScrollView *scrollView;

/** 外部操作控制器 */
@property (nonatomic,weak) UIViewController *handleVC;

/** 图片浏览方式 */
@property (nonatomic,assign) PhotoBroswerVCType type;

/** 图片数组 */
@property (nonatomic,strong) NSArray *imagesArray;

/** 初始显示的index */
@property (nonatomic,assign) NSUInteger index;

/** 圆点指示器 */
@property(nonatomic,strong) UIPageControl *pageControl;

/** 记录当前的图片显示视图 */
@property(nonatomic,strong) PhotoView *photoView;

//@property(nonatomic,strong) UIButton*btn;

@property(nonatomic,strong)UIImage*longPressImg;//记录长按的图片
@property(nonatomic,copy)NSString*cidResultStr;//识别图片中包含有二维码

@end

@implementation ImgPreviewVC

-(instancetype)init{
    self=[super init];
    if (self) {
        _subViewArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated: NO];
     self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    if (![[self.navigationController.viewControllers lastObject] isKindOfClass:[GoodsDetailsVC class]]) {
//        [self.navigationController setNavigationBarHidden:NO animated: animated];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片预览" ;
    
    self.view.backgroundColor=[UIColor whiteColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置contentSize
    self.scrollView.contentSize = CGSizeMake(WIDTH * self.imagesArray.count, 0);
    
    for (int i = 0; i < self.imagesArray.count; i++) {
        [_subViewArray addObject:[NSNull class]];
    }
    
    self.scrollView.contentOffset = CGPointMake(WIDTH*self.index, 0);//此句代码需放在[_subViewArray addObject:[NSNull class]]之后，因为其主动调用scrollView的代理方法，否则会出现数组越界
    
    if (self.imagesArray.count==1) {
        _pageControl.hidden=YES;
    }else{
        self.pageControl.currentPage=self.index;
    }
    
    [self loadPhote:self.index];//显示当前索引的图片
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideCurrentVC:)];
    [self.view addGestureRecognizer:tap];//为当前view添加手势，隐藏当前显示窗口
}

-(void)hideCurrentVC:(UIGestureRecognizer *)tap{
    [self hideScanImageVC];
}
#pragma mark - 显示图片
-(void)loadPhote:(NSInteger)index{
    if (index<0 || index >=self.imagesArray.count) {
        return;
    }
    id currentPhotoView = [_subViewArray objectAtIndex:index];
    if (![currentPhotoView isKindOfClass:[PhotoView class]]) {
        //url数组或图片数组
        CGRect frame = CGRectMake(index*_scrollView.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        PhotoView *photoV = [[PhotoView alloc] initWithFrame:frame withPhotoUrl:[self.imagesArray objectAtIndex:index]];
        photoV.delegate = self;
        [self.scrollView insertSubview:photoV atIndex:0];
        [_subViewArray replaceObjectAtIndex:index withObject:photoV];
        self.photoView=photoV;

    }
}

#pragma mark - 生成显示窗口
+(void)show:(UIViewController *)handleVC type:(PhotoBroswerVCType)type index:(NSUInteger)index imagesAry:(NSArray*)imagesAry{

    NSArray * photoModels = imagesAry;//取出相册数组
    if(photoModels == nil || photoModels.count == 0) { return; }
    
    ImgPreviewVC *imgBrowserVC = [[self alloc] init];
    imgBrowserVC.hidesBottomBarWhenPushed = YES;
    if(index >= photoModels.count){ return; }
    imgBrowserVC.index = index;
    imgBrowserVC.imagesArray = photoModels;
    imgBrowserVC.type =type;
    imgBrowserVC.handleVC = handleVC;
    [imgBrowserVC show]; //展示
}

//跳转进图片浏览
-(void)show{
    switch (_type) {
        case PhotoBroswerVCTypePush:{[self pushPhotoVC];} break;
        case PhotoBroswerVCTypeModal:{[self modalPhotoVC];}break;
        case PhotoBroswerVCTypeZoom:{[self zoomPhotoVC];}break;
        default:    break;
    }
}

#pragma mark - 界面跳转方式
-(void)pushPhotoVC{
    [_handleVC.navigationController pushViewController:self animated:YES];
}
-(void)modalPhotoVC{
    
    [_handleVC presentViewController:self animated:YES completion:nil];
}
-(void)zoomPhotoVC{
    //拿到window
    UIWindow *window = _handleVC.view.window;
    if(window == nil){
        NSLog(@"错误：窗口为空！");
        return;
    }
    self.view.frame=[UIScreen mainScreen].bounds;
    [window addSubview:self.view]; //添加视图
    [_handleVC addChildViewController:self]; //添加子控制器
}

#pragma mark - 退出当前显示视图
-(void)hideScanImageVC{
    switch (_type) {
        case PhotoBroswerVCTypePush://push
            
            [self.navigationController popViewControllerAnimated:YES];
            
            break;
        case PhotoBroswerVCTypeModal://modal
            
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
            
        case PhotoBroswerVCTypeZoom://zoom
            
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            
            break;
            
        default:
            break;
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (page<0||page>=self.imagesArray.count) {
        return;
    }
    self.pageControl.currentPage = page;
    
    for (UIView *view in scrollView.subviews) {
        if ([view isKindOfClass:[PhotoView class]]) {
            PhotoView *photoV=(PhotoView *)[_subViewArray objectAtIndex:page];
            if (photoV!=self.photoView) {
                [self.photoView.scrollView setZoomScale:1.0 animated:YES];
                self.photoView=photoV;
            }
        }
    }
    
    [self loadPhote:page];
}

#pragma mark - 自定义PhotoViewDelegate
//单击图片
-(void)tapHiddenPhotoView{
    [self hideScanImageVC];//隐藏当前显示窗口
}
//长按图片
-(void)longPressImg:(UIImage *)img{
    _longPressImg=img;
    
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:_longPressImg.CGImage]];
    _cidResultStr=@"";
    if(features.count>0) {
        CIQRCodeFeature *feature = [features objectAtIndex:0];
        _cidResultStr= feature.messageString;
        NSLog(@"识别到的二维码字符串: %@",_cidResultStr);
    }

    UIAlertController*sheetImg;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        sheetImg=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    }else{
        sheetImg=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    }
    
     UIAlertAction*calcel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *  action) {
         
    }];
    UIAlertAction*saveImg=[UIAlertAction actionWithTitle:@"保存到手机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        UIImageWriteToSavedPhotosAlbum(_longPressImg,self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    /*
    UIAlertAction*ciqCode=[UIAlertAction actionWithTitle:@"识别图中二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {

        UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"识别结果" message:FORMATSTR(@"\n%@",_cidResultStr) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*quXiao=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
        }];
        UIAlertAction*fuZhi=[UIAlertAction actionWithTitle:@"复制" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
            [UIPasteboard generalPasteboard].string =_cidResultStr;
        }];
        
        UIAlertAction*open=[UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
            if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:_cidResultStr]]) {
                if ([_cidResultStr hasPrefix:@"http"]) {
                    [WebVC pushWebViewUrlOrStr:_cidResultStr title:@"二维码链接" isSHowType:1];
                }else{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_cidResultStr]];
                }
            }
        }];
        [alert addAction:quXiao];
        [alert addAction:fuZhi];
        [alert addAction:open];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];*/
    
    [sheetImg addAction:calcel];
    [sheetImg addAction:saveImg];
//    if (_cidResultStr.length>0) {
//        [sheetImg addAction:ciqCode];
//    }
    [self presentViewController:sheetImg animated:YES completion:nil];
    
}
//保存图片到相册
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) { show_toast_msg(@"保存成功") }
    else{ show_toast_msg(@"保存失败，请检查相册权限!"); }
}



#pragma mark - 创建大的scrollView
-(UIScrollView *)scrollView{
    if (_scrollView==nil) {
        self.automaticallyAdjustsScrollViewInsets = NO ;
//        _scrollView.contentInsetAdjustmentBehavior
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _scrollView.delegate=self;
        _scrollView.pagingEnabled=YES;
        _scrollView.contentOffset=CGPointZero;
        //设置最大伸缩比例
        _scrollView.maximumZoomScale=3;
        //设置最小伸缩比例
        _scrollView.minimumZoomScale=1;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = color_rgba(0, 0, 0, 0.9);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
#pragma mark - 创建pageControl(页数控制控件)
-(UIPageControl *)pageControl{
    if (_pageControl==nil) {
        UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-40, WIDTH, 30)];
        bottomView.backgroundColor=[UIColor clearColor];
        _pageControl = [[UIPageControl alloc] initWithFrame:bottomView.bounds];
        _pageControl.currentPage = self.index;
        _pageControl.numberOfPages = self.imagesArray.count;
        _pageControl.currentPageIndicatorTintColor = color_red;
        _pageControl.pageIndicatorTintColor = color_white;
        [bottomView addSubview:_pageControl];
        [self.view addSubview:bottomView];
    }
    return _pageControl;
}


- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }


@end
