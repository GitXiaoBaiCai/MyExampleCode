//
//  WiFiConfigVC.m
//  MyCode
//
//  Created by 陈剑 on 2022/4/14.
//  Copyright © 2022 mycode. All rights reserved.
//

#import "WiFiConfigVC.h"



#import "BarcodeScannerVC.h"

@interface WiFiConfigVC ()

@property(nonatomic, strong) NSArray *functionName;
@property(nonatomic, strong) UILabel *textLab;
@property(nonatomic, strong) NEHotspotConfigurationManager *hotspotManager;
@end

@implementation WiFiConfigVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NEHotspotConfigurationManager，可以在app内配置wifi名称并连接
    

    _hotspotManager = [NEHotspotConfigurationManager sharedManager];
    
    _functionName = @[@"加入热点", @"获取配置" ];
    
    TestBtnView *testBtn = [[TestBtnView alloc]init];
    testBtn.btnTitleAry = _functionName;
    [self.view addSubview:testBtn];
    [testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(120);
        make.centerX.equalTo(self.view.mas_centerX); make.width.offset(330);
        make.height.offset(_functionName.count/2*70+(_functionName.count%2)*70 + 100);
    }];
    
    WeakSelf(weakSelf);
    testBtn.clickBtnBlock = ^(NSInteger btnTag) { [weakSelf clickTag:btnTag]; };
    

    _textLab = [UILabel labText:@"" color:color_blue font:font_s(14)];
    [self.view addSubview:_textLab];
    [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.offset(50);
    }];
    
}

 
-(void)clickTag:(NSInteger)tag {
   
    switch (tag) {
        case 1: {
            
            
            [self joinWifiName:@"shr-0"   password:@"123456789"];
//            WeakSelf(weakSelf)
//            BarcodeScannerVC *scannerVC = [[BarcodeScannerVC alloc]init];
//            navc_push(scannerVC, NO)
//            scannerVC.qrResultBlock = ^(NSString * _Nonnull qrString) {
//                NSArray *ary = [qrString componentsSeparatedByString:@"@"];
//                
//                if (ary.count==2) {
//                
//                    [weakSelf joinWifiName:null_str(ary[0])  password:null_str(ary[1])];
//                
//                }else{
//                    show_toast_msg(@"扫描结果异常！")
//                }
//            };
            
 
            
        } break;
            
        case 2: {
//            [self presentViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>]
//            [_hotspotManager getConfiguredSSIDsWithCompletionHandler:^(NSArray<NSString *> * _Nonnull configAry) {
//                C_LOG(@"%@", configAry);
//            }];
            
        } break;
            
            
            
        case 3: {
            
//            dispatch_queue_t queue = dispatch_queue_create("com.myapp.ex", 0);
//            [NEHotspotHelper registerWithOptions:nil queue:queue handler:^(NEHotspotHelperCommand * _Nonnull cmd) {
//                C_LOG(@"%@", cmd.networkList);
//            }];
//
//
//
//
//            C_LOG(@"supportedNetworkInterfaces -->: %@", [NEHotspotHelper supportedNetworkInterfaces]);
            
            
            
            
            
 
//
//            NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:@"Connect to MyWifi", kNEHotspotHelperOptionDisplayName, nil];
//
//            dispatch_queue_t queue = dispatch_queue_create("com.myapp.ex", 0);
//
//           [NEHotspotHelper registerWithOptions:nil queue:queue handler: ^(NEHotspotHelperCommand * cmd) {
//
//               NSMutableArray *hotspotList = [NSMutableArray new];
//
//               if(cmd.commandType == kNEHotspotHelperCommandTypeEvaluate || cmd.commandType == kNEHotspotHelperCommandTypeFilterScanList) {
//                     for (NEHotspotNetwork* network  in cmd.networkList) {
//                           C_LOG(@"network name:%@", network.SSID);
//                           if ([network.SSID isEqualToString:@"TP-LINK"]) {
//                               [network setConfidence:kNEHotspotHelperConfidenceHigh];
//                               [network setPassword:@"<wifi-password>"];
//                               [hotspotList addObject:network];
//                           }
//                     }
//
//                     NEHotspotHelperResponse *response = [cmd createResponse:kNEHotspotHelperResultSuccess];
//                     [response setNetworkList:hotspotList];
//                     [response deliver];
//                } else {
//                    C_LOG(@"there is no available wifi");
//                }
//              }
//           ];
            
        }
            
 
        default:
            break;
    }
    
    
}


-(void)joinWifiName:(NSString*)name password:(NSString*)password {
    
    mb_show_progress(@"正在加入wifi")
    NEHotspotConfiguration *config = [[NEHotspotConfiguration alloc]initWithSSID:name passphrase:password isWEP:false];

    //            NEHotspotConfiguration *config = [[NEHotspotConfiguration alloc]initWithSSID:ssid];
    
//            NEHotspotEAPSettings *setting = [[NEHotspotEAPSettings alloc]init];
//            setting.tlsClientCertificateRequired = false;
////            setting.trustedServerNames = @[*];
//            setting.username = @"username";
//            setting.password = @"1234567890";
//            setting.supportedEAPTypes = @[@13, @21, @25, @43,];
//            setting.preferredTLSVersion = NEHotspotConfigurationEAPTLSVersion_1_2;
//            NEHotspotConfiguration *config = [[NEHotspotConfiguration alloc]initWithSSID:ssid eapSettings:setting];

    
    [_hotspotManager applyConfiguration:config completionHandler:^(NSError * _Nullable error) {
        C_LOG(@"---> %@", error)
        mb_hidden_progress
        if (error.code==NEHotspotConfigurationErrorUserDenied) {
            NSLog(@"用户点击了取消");
        } else if (error==nil){
            show_toast_msg(@"加入wifi成功")
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"修改文本显示");
                
                _textLab.text = [NSString stringWithFormat:@"已成功加入:%@", name];
            });
        } else {
            NSLog(@"%@", error.domain);
        }
    }];
}


@end
