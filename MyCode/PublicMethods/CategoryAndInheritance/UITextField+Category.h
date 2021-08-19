//
//  UITextField+Category.h
//  MySlhb
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 chgyl. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Category)

+(UITextField*)textColor:(UIColor*)color phtxt:(NSString*)phStr font:(UIFont*)font;

-(void)addTarget_KeyboardDown;

+(void)jishubianji;
-(void)jishubianji;

@end

NS_ASSUME_NONNULL_END
