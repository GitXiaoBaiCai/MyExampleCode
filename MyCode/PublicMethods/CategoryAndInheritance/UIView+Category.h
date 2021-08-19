//
//  UIView+Category.h
//  MySlhb
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 chgyl. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIView (Category)

@property (nonatomic, strong) NSString *newName;

@property(nonatomic) float radius;

-(void)cornerRadius:(CGFloat)cornerRadius;

-(void)boardWidth:(CGFloat)width boardColor:(UIColor*)color cornerRadius:(CGFloat)radius;

-(void)logAllSubviews;



@end

NS_ASSUME_NONNULL_END
