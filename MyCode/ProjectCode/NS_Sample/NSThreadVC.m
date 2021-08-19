//
//  NSThreadVC.m
//  MyCode
//
//  Created by New_iMac on 2021/4/20.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "NSThreadVC.h"

@interface NSThreadVC ()

@end

@implementation NSThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button1 = [UIButton title:@"按钮1" titColorN:color_white font:font_s(15) bgColor:color_theme];
    AddTarget_for_button(button1, clickButton1)  [button1 cornerRadius:25];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(navc_bar_h+30);
        make.width.offset(120); make.height.offset(50);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    UIButton *button2 = [UIButton title:@"按钮2" titColorN:color_white font:font_s(15) bgColor:color_theme];
    AddTarget_for_button(button2, clickButton2)  [button2 cornerRadius:25];
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button1.mas_bottom).offset(30);
        make.width.offset(120); make.height.offset(50);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    UIButton *button3 = [UIButton title:@"按钮3" titColorN:color_white font:font_s(15) bgColor:color_theme];
    AddTarget_for_button(button1, clickButton3)  [button3 cornerRadius:25];
    [self.view addSubview:button3];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button2.mas_bottom).offset(30);
        make.width.offset(120); make.height.offset(50);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    

 
    
    
}


#pragma mark ==>> 按钮事件

-(void)clickButton1{
    
    // 创建一个线程，传递一个参数(直接创建)
    NSThread *thred1 = [[NSThread alloc]initWithTarget:self selector:@selector(taskThred1:) object:@100];
    thred1.name = @"button1触发的线程";
    [thred1 start];
    
    // block创建一个线程（block创建，ios10.0以后才支持）
//    if (@available(iOS 10.0, *)) {
//        NSThread *thred2 = [[NSThread alloc]initWithBlock:^{
//            [self printTest:90];
//        }];
//        thred2.name = @"button2触发的线程";
//        [thred2 start];
//    } else {
//        // Fallback on earlier versions
//    }
    
    // 直接用加号方法创建线程，
//    [NSThread detachNewThreadSelector:<#(nonnull SEL)#> toTarget:<#(nonnull id)#> withObject:<#(nullable id)#>];

    // 加号方法block创建线程
//    [NSThread detachNewThreadWithBlock:^{  }];
    
}

-(void)clickButton2{

}

-(void)clickButton3{
    
}

#pragma mark ==>> 线程方法

-(void)taskThred1:(NSNumber*)num{
    [self printTest:[num intValue]];
}




-(void)printTest:(int)num{
    for (int a = 0; a<num; a++) {
        // 使当前线程休眠0.1秒
        [NSThread sleepForTimeInterval:0.1];
        // 使当前线程休眠到某个时间，（当前时间往后的10秒）
//        [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
        NSLog(@"==> %@  for： a = %d",[NSThread currentThread],a);
    }
}








@end
