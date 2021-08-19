//
//  UIButton+Category.h
//  MySlhb
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 chgyl. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Category)

+(UIButton*)title:(NSString*)title titColorN:(UIColor*)colorN font:(UIFont*)font bgColor:(UIColor*)bgColor;

-(void)startCountdown:(int)time;

@end

NS_ASSUME_NONNULL_END
