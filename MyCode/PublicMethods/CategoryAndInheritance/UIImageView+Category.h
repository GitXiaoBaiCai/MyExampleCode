//
//  UIImageView+Category.h
//  MySlhb
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 chgyl. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Category)

-(void)setImgWithUrlStr:(NSString*)urlStr;
-(void)setImgWithUrlStr:(NSString*)urlStr placeholderImg:(NSString*)imgName;

//@property(nonatomic,copy) NSString * net_work_img;

@end

NS_ASSUME_NONNULL_END
