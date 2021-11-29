//
//  TestBtnView.h
//  MyCode
//
//  Created by New_iMac on 2021/11/29.
//  Copyright © 2021 mycode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestBtnView : UIView

+(void)showViewOn:(UIView*)superView btnTitleAry:(NSArray*)titleAry clickComplete:(void(^)(NSInteger btnTag))completeBlock;

typedef void(^ClickBtnBlock)(NSInteger btnTag);
@property(nonatomic, strong) NSArray *btnTitleAry;
@property(nonatomic, copy) ClickBtnBlock clickBtnBlock;

@end

NS_ASSUME_NONNULL_END
