//
//  TestOtherVC.m
//  MyCode
//
//  Created by chj on 2024/1/2.
//  Copyright © 2024 mycode. All rights reserved.
//

#import "TestOtherVC.h"
//#import <MobileVLCKit/MobileVLCKit.h>

@interface TestOtherVC ()
//@property(nonatomic, strong) VLCMediaPlayer *playerController;//播放器
//@property(nonatomic, strong) UIView *playView;//展示的View
@end

@implementation TestOtherVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.playView = [[UIView alloc]init];
//    self.playView.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:self.playView];
//    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.width.equalTo(self.view.mas_width);
//        make.height.equalTo(self.view.mas_width).multipliedBy(0.56);
//    }];
    
    
//    self.playerController = [[VLCMediaPlayer alloc]initWithOptions:@[]];
//    NSString *videoUrl = @"rtp://192.168.3.47:1234";
//    NSURL *remoteUrl = [NSURL URLWithString:videoUrl];
//    VLCMedia *media = [VLCMedia mediaWithURL:remoteUrl];
//    NSDictionary *dic = @{
//        @"network-caching": @"200",
//        @"file-caching":@"200",
//        @"sout-delay-delay": @"0",
//    };
//    [media addOptions:dic];
//    self.playerController.media = media;
//    self.playerController.drawable = self.playView;
//    [self.playerController play];
}

-(void)dealloc{
//    [self.playerController stop];
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
