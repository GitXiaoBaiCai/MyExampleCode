//
//  TextViewVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "TextViewVC.h"

@interface TextViewVC () <UITextViewDelegate>

@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) NSMutableArray *shouldChangeStrAry;
@property(nonatomic,strong) NSRegularExpression *regex;
@property(nonatomic,assign) NSRange nowSelectRange;
 
@end

@implementation TextViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self textView];
    _shouldChangeStrAry = [NSMutableArray array];
    [self receiveTopicCountWithContent:_textView];
    UITextInputTraits *aa;
    
    
}



-(UITextView*)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.backgroundColor = color_black;
        _textView.font = font_s(15);
        _textView.textColor = color_white;
        _textView.delegate = self;
        _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _textView.tintColor = color_white;
        [_textView cornerRadius:10];
        _textView.text = @"#今日天气#天气很好#今日心情#开心😊\nright";
        _textView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
        _textView.allowsEditingTextAttributes = YES;
        _textView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:20]};

        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.top.offset(100);
            make.right.offset(-20);
            make.height.offset(200);
        }];
    }
    return _textView;
}


-(void)textViewDidChange:(UITextView *)textView{
    [self receiveTopicCountWithContent:textView];
}

-(void)receiveTopicCountWithContent:(UITextView*)textView{
    NSString *content = textView.text;
    
    NSRange  contentRange = NSMakeRange(0, content.length);
    
    // 设置普通文本属性
    [_textView.textStorage addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:contentRange];
    [_textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:contentRange];

    // 使用正则匹配需要设置富文本的文字
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"#(.*?)#" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *textCheckingResultAry = [regex matchesInString:content options:NSMatchingReportProgress range:contentRange];
    for (NSTextCheckingResult *checkResult in textCheckingResultAry){
        [textView.textStorage addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:checkResult.range];
    }
    
//    NSTextAttachment * att;

    
//    [textView.textStorage addAttribute:NSAttachmentAttributeName value:NSTextAlignmentRight range:checkResult.range];
    
}




@end
