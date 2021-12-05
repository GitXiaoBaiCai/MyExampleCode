//
//  ScrollStackView.h
//  MyCode
//
//  Created by New_iMac on 2021/11/30.
//  Copyright © 2021 mycode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScrollStackView : UIScrollView
@property(nonatomic, strong) UIStackView *stackView;
@end

NS_ASSUME_NONNULL_END
