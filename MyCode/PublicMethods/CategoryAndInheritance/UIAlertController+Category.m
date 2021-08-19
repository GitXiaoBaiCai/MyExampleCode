//
//  UIAlertController+Category.m
//  PeanutLK
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 cj.All rights reserved.
//

#import "UIAlertController+Category.h"

@implementation UIAlertController (Category)

+(void)showIn:(UIViewController*)spview title:(NSString*)title content:(NSString*)content ctAlignment:(NSTextAlignment)ag btnAry:(NSArray*)ary indexAction:(void(^)(NSInteger indexTag))complete{
    UIAlertController*aleartVC=[UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    
    for (NSInteger i=0; i<ary.count; i++) {
         UIAlertAction*alert=[UIAlertAction actionWithTitle:ary[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
             complete(i);
         }];
        [aleartVC addAction:alert];
    }
    UIView *subView1 = aleartVC.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
//    NSLog(@"%@",subView5.subviews);
    //取title和message：
//    UILabel *titlel = subView5.subviews[0];
    UILabel * message = subView5.subviews[1];
    
    UILabel *contextLab = [UILabel labText:@"啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊" color:color_random font:font_s(20)];
    
    message = contextLab;
    
    message.textAlignment = ag ;
    
    
//    NSString *agreeTitle = @"登录代表您已同意《爱客宝用户协议和隐私政策》";
//    NSString *rangeTitle = @"《爱客宝用户协议和隐私政策》";
//
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:agreeTitle];
//    [text addAttribute:NSFontAttributeName value:font_s(20) range:NSMakeRange(0, agreeTitle.length)];
//    [text addAttribute:NSForegroundColorAttributeName value:color_blue range:[agreeTitle rangeOfString:rangeTitle]];
//
//    [message setValue:text forKeyPath:@"attributedMessage"];
    
    
    [spview presentViewController:aleartVC animated:YES completion:nil];
}

@end
