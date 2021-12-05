//
//  ScrollStackView.m
//  MyCode
//
//  Created by New_iMac on 2021/11/30.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "ScrollStackView.h"

@implementation ScrollStackView

-(instancetype)init {
    self = [super init];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self stackView];
    }
    return self;
}

-(UIStackView*)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc]init];
//        _stackView.spacing = 10; // 间距
        _stackView.axis = UILayoutConstraintAxisVertical; // 布局方向
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.alignment = UIStackViewAlignmentCenter;
        [self addSubview:_stackView];
        [_stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
//            make.top.left.right.offset(0);
//            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return _stackView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
