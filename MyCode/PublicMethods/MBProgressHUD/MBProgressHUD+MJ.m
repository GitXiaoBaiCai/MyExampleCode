//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"
//#import "MShowView.h"

@implementation MBProgressHUD (MJ)

#pragma mark --> 事件进行提醒
//提示信息(带有菊花样式的)
+ (MBProgressHUD *)showMessage:(NSString *)message{
//    if (TopNavc.topViewController.view) {
//        UIView * view = TopNavc.topViewController.view;
//        return [self showMessage:message toView:view];
//    }
    return [self showMessage:message toView:nil];
}
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {

    @try {
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        for (UIView * view in window.subviews) {
            if ([view isKindOfClass:[MShowView class]]||[view isKindOfClass:[MBProgressHUD class]]) {
                return nil;
            }
        }
        
        if (view == nil){
            MShowView * showView = [[MShowView alloc]init];
            showView.center = window.center;
            showView.bounds = CGRectMake(0, 0, ScreenW-40,ScreenH-navc_bar_h*2);
            [window addSubview:showView];
            showView.tag = 888;
            view = showView;
        }
        // 快速显示一个提示信息
        __block  MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:NO];
        hud.label.text = message;
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        hud.margin = 16.0;
        return hud;
    } @catch (NSException *exception) {
        return nil;
    } @finally { }

}

#pragma mark ===>>> 提示成功信息
+ (void)showSuccess:(NSString *)success{
    [self showSuccess:success toView:nil];
}
+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark ===>>> 显示错误信息
+ (void)showError:(NSString *)error{
    [self showError:error toView:nil];
}
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

//成功和失败调用
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    if (view == nil) view =[UIApplication sharedApplication].keyWindow;
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.margin = 12.0;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1.6秒之后再消失
    [hud hideAnimated:YES afterDelay:1.6];
}


#pragma mark ===>>> 隐藏
+ (void)hideHUD{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    @try {
        MShowView * showView = [window viewWithTag:888];
        if (showView==nil) {
            for (UIView * view in window.subviews) {
                if ([view isKindOfClass:[MShowView class]]) {
                    showView = (MShowView*)view;
                    [self hideHUDForView:showView];
                    [showView removeFromSuperview];
                    showView = nil;
                }
            }
        }else{
            [self hideHUDForView:showView];
            [showView removeFromSuperview];
            showView = nil;
        }
       
    } @catch (NSException *exception) {
        for (UIView * view in window.subviews) {
            if ([view isKindOfClass:[MShowView class]]||[view isKindOfClass:[MBProgressHUD class]]) {
                [view removeFromSuperview];
            }
        }
    } @finally { }
    
}

+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}


@end







@implementation MShowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
