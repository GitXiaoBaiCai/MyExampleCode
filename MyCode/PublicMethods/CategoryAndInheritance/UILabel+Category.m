//
//  UILabel+Category.m
//  MySlhb
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)

+(UILabel*)labText:(NSString*)text color:(UIColor*)color font:(UIFont*)font{
    UILabel * label = [[UILabel alloc]init];
    label.text = text; label.textColor = color;
    label.font = font;
    return label;
}


-(void)changeLabelTxtSpacing_V:(float)spacing_v Spacing_H:(float)spacing_h{
    
    NSString * labelText = self.text;
    self.numberOfLines = 0;
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing_v];
    NSDictionary * attributedDic = @{NSForegroundColorAttributeName:self.textColor,
                                    NSFontAttributeName:self.font,
                                    NSParagraphStyleAttributeName:paragraphStyle,
                                    NSKernAttributeName:@(spacing_h) };
    
    NSMutableAttributedString * attributedLab = [[NSMutableAttributedString alloc] initWithString:labelText attributes:attributedDic];
    
    self.attributedText = attributedLab;
    
}

@end
