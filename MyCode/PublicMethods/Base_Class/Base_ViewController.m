//
//  Base_ViewController.m
//  MySlhb
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import "Base_ViewController.h"

@interface Base_ViewController ()

@end

@implementation Base_ViewController


+(void)load{
    NSLog(@"%s",__func__);
}


//+(void)pushSelfViewController:(id __nullable)parameter{
//    @try {
//        if (top_navc) {
//            Class vcClass = self;
//            Base_ViewController * objcVC = [[vcClass alloc]init];
//            objcVC.hidesBottomBarWhenPushed = YES;
//            if (parameter) { objcVC.publicParameter = parameter; }
//            [top_navc pushViewController:objcVC animated:YES];
//        }else{ show_toast_msg(@"页面打开失败!") }
//    } @catch (NSException *exception) {
//        show_toast_msg(@"页面打开失败！")
//    } @finally { }
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = color_white;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

//    self.navigationController.navigationBar.hidden = YES;
//    [self creatObjcTopView];

-(void)creatObjcTopView{
    _barView = [[UIImageView alloc]init];
    _barView.userInteractionEnabled = YES;
    [self.view addSubview:_barView];
    [_barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(navc_bar_h);
    }];
    
    _barLinesImgV = [[UIImageView alloc]init];
    _barLinesImgV.backgroundColor = black_5;
    [_barView addSubview:_barLinesImgV];
    [_barLinesImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(0.5);
    }];
    
    _barTitLab = [UILabel labText:@" " color:black_1 font:font_b(14)];
    _barTitLab.textAlignment = NSTextAlignmentCenter;
    _barTitLab.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self.barView addSubview:_barTitLab];
    [_barTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-10); make.height.offset(24);
        make.centerX.equalTo(self->_barView.mas_centerX);
        make.width.offset(ScreenW/1.8);
    }];
    
    _goBackBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_goBackBtn setImage:img_str(@"go_back") forState:(UIControlStateNormal)];
    AddTarget_for_button(_goBackBtn, clickGoBackBtnObjc)
    [_barView addSubview:_goBackBtn];
    [_goBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self->_barTitLab.mas_centerY);
        make.left.offset(ss_x(4));
        make.height.offset(36);
        make.width.offset(40);
    }];
    
}

-(void)clickGoBackBtnObjc{
    mb_hidden_progress
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{ [self dismissViewControllerAnimated:YES completion:nil]; }
}


// 视图将要出现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSLog(@"=*=*=*=*=*=*=*=*=*=  %@ (%@) 将要显示",self,self.title);
    [self.view bringSubviewToFront:_barView];
    if (self.title) { _barTitLab.text = self.title; }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.navigationController==nil) { mb_hidden_progress }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


-(void)dealloc{
//    NSLog(@"%s",__func__);
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
