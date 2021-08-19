//
//  UILabel+Category.h
//  MySlhb
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 chgyl. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Category)

+(UILabel*)labText:(NSString*)text color:(UIColor*)color font:(UIFont*)font;


/**
 修改字体和字体的间距

 @param spacing_v 上下间距
 @param spacing_h 水平左右间距
 */
-(void)changeLabelTxtSpacing_V:(float)spacing_v Spacing_H:(float)spacing_h;

@end

NS_ASSUME_NONNULL_END
