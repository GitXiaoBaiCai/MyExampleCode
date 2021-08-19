//
//  UIImageView+Category.m
//  MySlhb
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import "UIImageView+Category.h"

static NSString * net_work_imgKey = @"net_work_imgKey";

@implementation UIImageView (Category)

-(void)setImgWithUrlStr:(NSString*)urlStr{
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr]];
}
-(void)setImgWithUrlStr:(NSString*)urlStr placeholderImg:(NSString*)imgName{
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:imgName?img_str(imgName):nil];
}

@end
