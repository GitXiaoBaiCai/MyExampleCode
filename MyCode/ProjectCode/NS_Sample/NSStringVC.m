//
//  NSStringVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/24.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "NSStringVC.h"

@interface NSStringVC ()

@end

@implementation NSStringVC

- (void)viewDidLoad {
    [super viewDidLoad];


    NSString *htmlStr = @"<p>爱客宝按以下结算规则，系统自动结算至余额，用户自行提现到支付宝。规则如下：</p> <p> 一丶总收入＜ 100元的用户，只需要有结算订单即可。 <br /> <br /> 二丶总收入≥ 100元的用户，订单总收入≥8元的正常用户即可。</p> <p> </p> <p>温馨提示：</p> <p>1.总收入=自购和分享商品的订单总佣金收入，包括淘宝丶京东丶拼多多。</p> <p>2.当月收入结算时间为次月的26号后。<br /><br />3.系统自动结算至爱客宝APP余额内。（余额内收入，用户可随时提现至支付宝，约3个工作日到账。）</p> <p>4.没有自动结算到余额的收入，会持续积累，达到结算规则条件即可自动结算至余额。</p>";
    
    NSLog(@"\n\n%@",[self praseHtmlStr:htmlStr]);
    

    
    
    
    
    
}


//正则去除标签
-(NSString *)getZZwithString:(NSString *)string{
    NSRegularExpression *regularExpretion = [NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n" options:0 error:nil];
    string = [regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}

//转化html标签为富文本
- (NSMutableString *)praseHtmlStr:(NSString *)htmlStr {
//    NSCharacterEncodingDocumentOption
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUTF8StringEncoding]
                                                                                          options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                                    NSCharacterEncodingDocumentOption:@(NSUTF8StringEncoding),
                                                                                                    NSCharacterEncodingDocumentAttribute:@(NSUTF8StringEncoding)}
                                                                               documentAttributes:nil error:nil];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color_hex(@"#333333") range:NSMakeRange(0, attributedString.length)];
    
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
