//
//  TextFieldVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "TextFieldVC.h"

@interface TextFieldVC ()
@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UILabel *textLab;
@end

@implementation TextFieldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self textField1];
    
    
    UIButton *btn = [UIButton title:@"点击" titColorN:color_black font:font_s(15) bgColor:color_blue];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(100);
        make.height.offset(50);
        make.width.offset(200);
        make.top.offset(400);
    }];
    
    
    _textLab = [UILabel labText:@"" color:color_black font:font_s(16)];
    [self.view addSubview:_textLab];
    [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(100);
        make.height.offset(50);
        make.width.offset(200);
        make.top.offset(500);
    }];
    
    
    
}

-(void)clickBtn{
    NSString *str = FORMATSTR(@"%@", _textField1.text);
    NSLog(@"text类：%@", object_getClass(_textField1.text));
    NSLog(@"str类：%@", object_getClass(str));
    NSString *str1 = @"aaaaaa";
    NSLog(@"str1类：%@", object_getClass(str1));

    
    _textLab.text = str;
    NSLog(@"---> %@", str);
}


-(UITextField*)textField1 {
    if (!_textField1) {
        _textField1 = [[UITextField alloc]init];
//        _textField1.secureTextEntry = YES;
        _textField1.placeholder = @"请输入内容";
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
        _textField1.leftView = view1;
        _textField1.leftViewMode = UITextFieldViewModeAlways;
//        _textField1.textContentType = UITextContentTypePassword;
        _textField1.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textField1 boardWidth:1 boardColor:color_black cornerRadius:20];
        [self.view addSubview:_textField1];
        [_textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(status_bar_h+navc_bar_h+20);
            make.centerX.equalTo(self.view);
            make.width.offset(300);
            make.height.offset(40);
        }];
    }
    return _textField1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
