//
//  ImageViewVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "ImageViewVC.h"
#import "TestModel.h"
@interface ImageViewVC ()
@property(nonatomic, strong) UIImageView *imageview;

@end

@implementation ImageViewVC

- (void)viewDidLoad {
    [super viewDidLoad];

//    _imageview = [[UIImageView alloc]init];
//    _imageview.frame = CGRectMake(20, 150, 350, 200);
//    UIImage *img;
////    UIImagePNGRepresentation();
////    _imageview.image = [self gradientImage:@[color_random, color_random]];
////    _imageview.image = [self gradientImage:@[color_hex(@"#FD4903"), color_hex(@"#FF3445")]];
//    [self.view addSubview:_imageview];
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = color_white;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(200);
        make.height.width.offset(300);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    
    
    UIImageView *imageTop = [[UIImageView alloc]init];
    imageTop.image = [UIImage imageNamed:@"album_icon-min"];
    imageTop.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageTop];
    [imageTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.height.offset(220);
        make.width.offset(220);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    
    UIImageView *imageBot = [[UIImageView alloc]init];
    imageBot.image = [UIImage imageNamed:@"addcn_logo"];
    imageBot.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageBot];
    [imageBot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-20);
        make.height.offset(45);
        make.width.offset(300);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    
    
    
    
}



typedef NS_ENUM(NSInteger,GradientDirection){
    grd_left = 1,  // 色值从右到左
    grd_right,     // 色值从左到右
    grd_top,       // 色值从下到上
    grd_bottom     // 色值从上到下
};
-(UIImage*)gradientImage:(NSArray<UIColor*>*)colors direction:(GradientDirection)direction{

    @autoreleasepool {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, 20, 20);
        
        switch (direction) {
            case grd_left: {
                gradientLayer.startPoint = CGPointMake(1, 0.5);
                gradientLayer.endPoint = CGPointMake(0, 0.5);
            } break;

            case grd_top: {
                gradientLayer.startPoint = CGPointMake(0.5, 1);
                gradientLayer.endPoint = CGPointMake(0.5, 0);
            } break;
                
            case grd_bottom: {
                gradientLayer.startPoint = CGPointMake(0.5, 0);
                gradientLayer.endPoint = CGPointMake(0.5, 1);
            } break;
                
            default:{ // 默认用 grd_right
                gradientLayer.startPoint = CGPointMake(0, 0.5);
                gradientLayer.endPoint = CGPointMake(1, 0.5);
            } break;
        }
        NSMutableArray *colorAry = [NSMutableArray array];
        for (UIColor *color in colors) {
            [colorAry addObject:(__bridge id)color.CGColor];
        }
        gradientLayer.colors = colorAry;
        
        UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, NO, [UIScreen mainScreen].scale);
        [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if (image) { return image; }
        return [UIImage imageNamed:@""];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
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
