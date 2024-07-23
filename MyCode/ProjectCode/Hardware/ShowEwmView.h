//
//  ShowEwmView.h
//  MyCode
//
//  Created by 陈剑 on 2022/4/20.
//  Copyright © 2022 mycode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowEwmView : UIView

@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UIImageView *ewmImageView;
@property(nonatomic, strong) UITextView *ewmContent;

@property(nonatomic, copy) NSString *content;

@property(nonatomic, assign) BOOL show;

-(void)showSelfView;
-(void)hideSelfView;




@end

NS_ASSUME_NONNULL_END
