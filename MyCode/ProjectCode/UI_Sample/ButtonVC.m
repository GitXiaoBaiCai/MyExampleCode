//
//  ButtonVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "ButtonVC.h"

@interface ButtonVC ()
@property(nonatomic, strong) UIButton *button;
@end

@implementation ButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self button];
    
    // Do any additional setup after loading the view.
}


-(UIButton*)button{
    if (!_button) {
        _button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_button setTitle:@"按钮" forState:(UIControlStateNormal)];
        [_button setTitleColor:black_1 forState:(UIControlStateNormal)];
        [_button setTitleColor:black_2 forState:(UIControlStateHighlighted)];
        [_button setImageEdgeInsets:UIEdgeInsetsMake(9, 0, 9, 0)];
        _button.layer.cornerRadius = 25;
        _button.layer.shadowColor = color_random.CGColor;
        _button.layer.shadowOffset = CGSizeMake(2, 2);
        _button.layer.shadowRadius = 25;
        _button.layer.shadowOpacity = 0.8;
        _button.layer.masksToBounds = YES;
        [_button addTarget:self action:@selector(clickButton:) forControlEvents:(UIControlEventTouchUpInside)];
        _button.backgroundColor = color_random;

        [self.view addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.offset(navc_bar_h+50);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(50);
        }];
    }
    return _button;
}

-(void)clickButton:(UIButton*)btn{
    [self addLocalNotice];
}

- (void)addLocalNotice {
    if (@available(iOS 10.0, *)) {
   
        NSString *htmlStr = @"<p>爱客宝按以下结算规则，系统自动结算至余额，用户自行提现到支付宝。规则如下：</p> <p> 一丶总收入＜ 100元的用户，只需要有结算订单即可。 <br /> <br /> 二丶总收入≥ 100元的用户，订单总收入≥8元的正常用户即可。</p> <p> </p> <p>温馨提示：</p> <p>1.总收入=自购和分享商品的订单总佣金收入，包括淘宝丶京东丶拼多多。</p> <p>2.当月收入结算时间为次月的26号后。<br /><br />3.系统自动结算至爱客宝APP余额内。（余额内收入，用户可随时提现至支付宝，约3个工作日到账。）</p> <p>4.没有自动结算到余额的收入，会持续积累，达到结算规则条件即可自动结算至余额。</p>";
        
        htmlStr = @"爱客宝按以下结算规则，\n系统自动结算至余额，用户自行提现到支付宝\n总收入＜ 100元的用户，只需要有结算订单即可。";
        
        // Configure the notification's payload.
        UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
        content.title = [NSString localizedUserNotificationStringForKey:@"标题标题!" arguments:nil];
//        content.subtitle = [NSString localizedUserNotificationStringForKey:@"副标题副标题!" arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey:htmlStr arguments:nil];
        content.sound = [UNNotificationSound defaultSound];
        content.badge = [NSNumber numberWithInt:1];

        // Deliver the notification in five seconds.
        UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                    triggerWithTimeInterval:5 repeats:NO];
        UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"DelayFiveSecond"
                    content:content trigger:trigger];

        // Schedule the notification.
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
             if (error) {
                 NSLog(@"%@",error);
             }else{
                 NSLog(@"成功添加推送");
             }
        }];
    }else{
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        // 发出推送的日期
        notif.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
        // 推送的内容
        notif.alertBody = @"你已经10秒没出现了";
        // 可以添加特定信息
        notif.userInfo = @{@"noticeId":@"00001"};
        // 角标
        notif.applicationIconBadgeNumber = 1;
        // 提示音
        notif.soundName = UILocalNotificationDefaultSoundName;
        // 每周循环提醒
        notif.repeatInterval = NSCalendarUnitWeekOfYear;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 自定义按钮使用
//- (CGRect)backgroundRectForBounds:(CGRect)bounds;
//- (CGRect)contentRectForBounds:(CGRect)bounds;
//- (CGRect)titleRectForContentRect:(CGRect)contentRect;
//- (CGRect)imageRectForContentRect:(CGRect)contentRect;
//



@end
