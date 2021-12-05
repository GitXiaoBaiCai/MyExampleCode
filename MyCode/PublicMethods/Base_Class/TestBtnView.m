//
//  TestBtnView.m
//  MyCode
//
//  Created by New_iMac on 2021/11/29.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "TestBtnView.h"

@implementation TestBtnView

+(void)showViewOn:(UIView*)superView btnTitleAry:(NSArray*)titleAry clickComplete:(void(^)(NSInteger btnTag))completeBlock {
    TestBtnView *testBtn = [[TestBtnView alloc]init];
    testBtn.btnTitleAry = titleAry;
    testBtn.clickBtnBlock = completeBlock;
    [superView addSubview:testBtn];
    [testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset([UIApplication sharedApplication].statusBarFrame.size.height+44+20);
        make.centerX.equalTo(superView.mas_centerX); make.width.offset(330);
        make.height.offset(titleAry.count/2*70+(titleAry.count%2)*70);
    }];
}

-(void)setBtnTitleAry:(NSArray *)btnTitleAry {
    
    for (int i=0; i<btnTitleAry.count; i++) {
        NSString *title = btnTitleAry[i];
        if (!title||title.length<1) { break; }
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:btnTitleAry[i] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        button.backgroundColor = [UIColor colorWithRed:88/255.0f green:86/255.0f blue:213/255.0f alpha:1];
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 23;
        button.tag = i+1;
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset((i/2)*70);
            make.width.offset(150);
            make.height.offset(46);
            if (i%2==0) {
                make.right.equalTo(self.mas_centerX).offset(-10);
            }else {
                make.left.equalTo(self.mas_centerX).offset(10);
            }
          }];
    }
    
}
 
-(void)clickBtn:(UIButton*)btn {
    if (self.clickBtnBlock) {
        self.clickBtnBlock(btn.tag);
    }
}

@end
