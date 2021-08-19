//
//  UIAlertController+Category.h
//  PeanutLK
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 cj.All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Category)
//警告框
+(void)showIn:(UIViewController*)spview title:(NSString*)title content:(NSString*)content ctAlignment:(NSTextAlignment)ag btnAry:(NSArray*)ary indexAction:(void(^)(NSInteger indexTag))complete;

@end
