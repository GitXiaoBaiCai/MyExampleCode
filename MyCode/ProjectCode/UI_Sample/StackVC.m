//
//  StackVC.m
//  MyCode
//
//  Created by New_iMac on 2021/11/30.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "StackVC.h"
#import "ScrollStackView.h"


@interface StackVC ()

@property(nonatomic, strong) ScrollStackView *ssView; // 封装的带滑动的 UIStackView
@property(nonatomic, strong) UIStackView *stackView;

@end

@implementation StackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    WeakSelf(weakSelf)
//    NSArray *btnTitleAry = @[@"测试1",@"测试2"];
//    [TestBtnView showViewOn:self.view btnTitleAry:btnTitleAry clickComplete:^(NSInteger btnTag) {
//        [weakSelf clickTag:btnTag];
//    }];
    
    
//    for (NSInteger i=0; i<8; i++) {
//        IconButton *iconBtn = [IconButton buttonWithType:(UIButtonTypeCustom)];
//        [iconBtn setImage:[UIImage imageNamed:@"yan_wen_zi"] forState:(UIControlStateNormal)];
//        [iconBtn setTitle:@"颜文字" forState:(UIControlStateNormal)];
//        iconBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        iconBtn.backgroundColor = color_random;
//        [self.ssView.stackView addArrangedSubview:iconBtn];
//        [iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            if (i%3==0) {
//                make.height.equalTo(self.ssView.mas_height);
//            }else {
//                make.height.offset(80);
//            }
//
//            make.width.offset(70);
//        }];
//    }
  
    for (NSInteger i=0; i<4; i++) {
        IconButton *iconBtn = [IconButton buttonWithType:(UIButtonTypeCustom)];
        [iconBtn setImage:[UIImage imageNamed:@"yan_wen_zi"] forState:(UIControlStateNormal)];
        [iconBtn setTitle:@"颜文字" forState:(UIControlStateNormal)];
        iconBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        iconBtn.backgroundColor = color_random;
        iconBtn.tag = i+1;
        [iconBtn addTarget:self action:@selector(clickTag:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.stackView addArrangedSubview:iconBtn];
        [iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.offset(75);
            if (i<2) {
                make.width.offset(70);
            }else if(i==2){
//                make.width.offset((ScreenW-140)/2);
                make.width.equalTo(self.stackView.mas_width);
            }
                
            
        }];
    }

}

-(ScrollStackView*)ssView {
    if (!_ssView) {
        _ssView = [[ScrollStackView alloc]init];
        _ssView.backgroundColor = [UIColor lightGrayColor];
        _ssView.stackView.spacing = 10;
        _ssView.stackView.backgroundColor = [UIColor redColor];
        _ssView.stackView.axis = UILayoutConstraintAxisHorizontal;
        _ssView.stackView.distribution = UIStackViewDistributionFillProportionally;
        _ssView.stackView.alignment = UIStackViewAlignmentCenter;
        [self.view addSubview:_ssView];
        [_ssView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.right.offset(-20);
            make.height.offset(100);
            make.top.offset(navc_bar_h+300);
        }];
    }
    return _ssView;
}



-(UIStackView*)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc]init];
        _stackView.backgroundColor = [UIColor lightGrayColor];
//        _stackView.spacing = 10; // 间距
        _stackView.axis = UILayoutConstraintAxisHorizontal; // 布局方向

        /*
         填充模式
         UIStackViewDistributionFill // 撑满
         UIStackViewDistributionFillEqually // 宽高度平分相等
         UIStackViewDistributionFillProportionally // (addArrangedSubview的view可以设置宽或高)
         UIStackViewDistributionEqualSpacing
         UIStackViewDistributionEqualCentering
        */
        
        _stackView.distribution = UIStackViewDistributionFillProportionally;
        
        
       /*
        对齐方式
        UIStackViewAlignmentFill,
        UIStackViewAlignmentTop = UIStackViewAlignmentLeading,
        UIStackViewAlignmentFirstBaseline,
        UIStackViewAlignmentCenter,
        UIStackViewAlignmentBottom = UIStackViewAlignmentTrailing,
        UIStackViewAlignmentLastBaseline,
       */
        
        _stackView.alignment = UIStackViewAlignmentCenter; // 对齐方式
        _stackView.clipsToBounds = YES;
        [self.view addSubview:_stackView];
        [_stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.right.offset(-20);
            make.top.offset(navc_bar_h+100);
            make.height.offset(80);
        }];
    }
    return _stackView;
}


-(void)clickTag:(IconButton*)btn {
    switch (btn.tag) {
        case 3: {
            [UIView animateWithDuration:0.25 animations:^{
                _stackView.arrangedSubviews[2].hidden = YES;
            }];
           
        } break;

        case 4: {
            [UIView animateWithDuration:0.25 animations:^{
                _stackView.arrangedSubviews[2].hidden = NO;
            }];
        } break;

        default:
            break;
    }
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
 






@implementation IconButton


- (CGRect)titleRectForContentRect:(CGRect)contentRect {
//    float w = StringSize(self.titleLabel.text, self.titleLabel.font).width;
    return CGRectMake(frame_w(self)/2-50, frame_h(self)/2+20, 100, 18);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake((frame_w(self)-50)/2, frame_h(self)/2-37, 50, 50);
}

 
@end




 
