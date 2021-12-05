//
//  LabelVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "LabelVC.h"

@interface LabelVC ()

@end

@implementation LabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [UILabel new];
    label.font = font_s(14);
    label.numberOfLines = 0;
    label.textColor = color_random;
    
//    [label setValue:@(10) forKeyPath:@"_lineSpacing"];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.top.offset(navc_bar_h+30);
        make.height.offset(300);
    }];
        
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}


//    [self praseHtmlStr:@"<p>爱客宝伙伴们：</p> <p> </p> <p>     关于65%VIP用户分红上报规则，参与上报分红的65%vip需要当月有效结算订单≥1单，才属于有效上报分红点。此规则即日起开始执行。如有任何疑问，点击本通知添加爱客宝官方指导老师微信咨询。</p> <p> </p> <p> </p> <p> </p> <p> </p> <p>                                                                                                                 爱客宝市场部</p> <p>                                                                                                                2021年2月1日</p>"];

//转化html标签为富文本
- (NSMutableString *)praseHtmlStr:(NSString *)htmlStr {
//    NSCharacterEncodingDocumentOption
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding]
                                                                                          options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
//                                                                                                    NSCharacterEncodingDocumentOption:@(NSUTF8StringEncoding),
                                                                                                    NSCharacterEncodingDocumentAttribute:@(NSUTF8StringEncoding)
                                                                                                    
                                                                                          }
                                                                               documentAttributes:nil error:nil];
//    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, attributedString.length)];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:color_hex(@"#333333") range:NSMakeRange(0, attributedString.length)];
    
    return attributedString.mutableString;
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
