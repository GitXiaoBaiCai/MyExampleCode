//
//  ShowEwmView.m
//  MyCode
//
//  Created by 陈剑 on 2022/4/20.
//  Copyright © 2022 mycode. All rights reserved.
//

#import "ShowEwmView.h"


#define content_h (i_x_safe_b+450)

@implementation ShowEwmView


-(void)setShow:(BOOL)show{
    if (_show==show) { return; }
    _show = show;
    if (_show) {
        [self showSelfView];
    }else{
        [self hideSelfView];
    }
}

-(void)setContent:(NSString *)content{
    _content = content;
    self.ewmImageView.image = Qr_code_img(_content, 500, nil);
    self.ewmContent.text = _content;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor = color_clear;
        self.hidden = YES;
    
        [self creatOtherView];
        [self addLayout];
                
    }
    return self;
}


-(void)addLayout{
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(content_h);
        make.height.offset(content_h);
    }];
    
    [self.ewmImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(60);
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.offset(260);
    }];
    
    [self.ewmContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ewmImageView.mas_bottom).offset(10);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(80);
    }];
}


-(UIView*)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = color_white;
        [self addSubview:_contentView];
    }
    return _contentView;
}

-(void)creatOtherView{
    UIButton *closeBtn = [UIButton title:@"关闭二维码" titColorN:color_red font:font_b(14) bgColor:color_group];
    AddTarget_for_button(closeBtn, hideSelfView)
    [self.contentView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.offset(40);
        make.width.offset(100);
        make.top.offset(10);
    }];
}


-(UIImageView*)ewmImageView{
    if (!_ewmImageView) {
        _ewmImageView = [[UIImageView alloc]init];
        [_ewmImageView cornerRadius:5];
        _ewmImageView.backgroundColor = color_group;
        [self.contentView addSubview:_ewmImageView];
    }
    return _ewmImageView;
}
 

-(UITextView*)ewmContent {
    
    if (!_ewmContent) {
    
        _ewmContent = [[UITextView alloc]init];
        _ewmContent.editable = NO;
        _ewmContent.text = @"内容";
        _ewmContent.font = font_s(13);
        _ewmContent.textColor = color_blue;
        _ewmContent.backgroundColor = color_group;
        _ewmContent.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        [_ewmContent cornerRadius:10];
        [self.contentView addSubview:_ewmContent];
        
    }
    return _ewmContent;
}


-(void)showSelfView{
    _show = YES;
    self.hidden = NO;
    [UIView animateWithDuration:0.26 animations:^{
        self.backgroundColor = color_rgba(0, 0, 0, 0.4);
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(0);
        }];
        [self layoutIfNeeded];
    }];

}

-(void)hideSelfView{
    _show = NO;

    [UIView animateWithDuration:0.26 animations:^{
        self.backgroundColor = color_rgba(0, 0, 0, 0.4);
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(content_h+5);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
