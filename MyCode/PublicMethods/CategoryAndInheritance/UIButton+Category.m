//
//  UIButton+Category.m
//  MySlhb
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)


/// 创建一个按钮
/// @param title 标题
/// @param colorN 标题颜色
/// @param font 字体
/// @param bgColor 背景色
+(UIButton*)title:(NSString*)title titColorN:(UIColor*)colorN font:(UIFont*)font bgColor:(UIColor*)bgColor{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    if(bgColor!=nil){ btn.backgroundColor = bgColor; }
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:colorN forState:UIControlStateNormal];
    return btn;
}


-(void)startCountdown:(int)time{
    // 倒计时总时间
    __block int timeOut = time;
    // 创建子线程队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 设置定 时器  每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self!=nil) {
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    self.userInteractionEnabled = YES;
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self!=nil) {
                    [self setTitle:[NSString stringWithFormat:@"剩余:%0.2ds",timeOut] forState:UIControlStateNormal];
                    self.userInteractionEnabled = NO;
                }
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}


@end
