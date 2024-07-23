//
//  TestVC.m
//  MyCode
//
//  Created by New_iMac on 2021/3/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "TestVC.h"
#import "TestView.h"
#import "TestModel.h"
#import <objc/runtime.h>
#import <pthread/pthread.h>
#import <malloc/malloc.h>
//#import <QuartzCore/CALayer.h>
#import <sqlite3.h>
#import <mach/mach_host.h>

#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <SafariServices/SFSafariViewController.h>

#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "Positioning.h"

typedef int td_bb;
typedef void(*td_aa) (void*, td_bb);

@interface TestVC (){

};

@property(nonatomic, strong) UILabel *txtLab;
@property(nonatomic, strong) UILabel *txtLab2;
@property(nonatomic, copy) NSMutableString *testStr1;
@property(nonatomic, copy) NSMutableString *testStr2;
@property(nonatomic, strong) TestBtnView *btnView;
@property(nonatomic, strong) NSArray *functionName;

@end

@implementation TestVC

 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"Test";
    
    _functionName = @[@"测试1", @"测试2", @"测试3", @"测试4", @"黑暗模式", @"正常模式", @"弹窗", @"获取当前位置", @"获取粘贴板" ,@"模态导航"];
    _testStr2 = [[NSMutableString alloc] initWithString:@"哈哈哈"];
    [self btnView];
    
    
    
}

-(TestBtnView*)btnView{
    if (!_btnView) {
        _btnView = [[TestBtnView alloc]init];
        _btnView.backgroundColor = UIColor.clearColor;
        _btnView.btnTitleAry = _functionName;
        [self.view addSubview:_btnView];
        [_btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(navc_bar_h+20);
            make.width.offset(330);
            make.centerX.equalTo(self.view.mas_centerX);
            make.height.offset(_functionName.count/2*70+(_functionName.count%2)*70);
        }];
        WeakSelf(weakSelf)
        _btnView.clickBtnBlock = ^(NSInteger btnTag) {
            [weakSelf clickBtn:btnTag];
        };
    }
    return _btnView;
}



-(void)test {
    NSLog(@"222222");
}


-(void)clickBtn:(NSInteger)tag {
    
    switch (tag) {
        case 1: {
            
            @try {
                [self removeObserver:self forKeyPath:@"aaa"];
            } @catch (NSException *exception) {
                C_LOG(@"%@", exception);
            } @finally {
                 
            }
            
            
            
//            ns_user_defaults_save(@"哈哈哈 哦哦", @"kye1");
        
            //            C_LOG(@"%@",[RuntimeApi classIvars:[UILabel class]]);
            //            C_LOG(@"%@",[RuntimeApi classPropertys:[UILabel class]]);
            
            //            NSThread *thread = [[NSThread alloc]initWithBlock:^{
            //                NSLog(@"111111");
            //            }];
            //
            //            [thread start];
            //
            //            [self performSelector:@selector(test) onThread:thread withObject:nil waitUntilDone:NO];
            //
            
//            NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
//                
//            }];
            //            [[UIApplication sharedApplication] canOpenURL:url];
            
            
            
            
        } break;
            
        case 2: {
            
            NSLog(@"%@", ns_user_defaults_take(@"kye1"));
            
            //            _testStr1 = _testStr2;
            //            [_testStr1 insertString:@"哦哦哦" atIndex:2];
            //
            //            NSLog(@"1: %@   2: %@", _testStr1, _testStr2);
            //            NSLog(@"1: %p   2: %p", _testStr1, _testStr2);
            //            NSLog(@"1: %p   2: %p", &_testStr1, &_testStr2);
            
            
            
            
            
        } break;
            
            
        case 3:  {
            
            NSString * urlStr = FORMATSTR(@"https://itunes.apple.com/cn/lookup?id=%@",@"1275860706");
            //            urlStr = @"https://www.qimai.cn/app/rank/appid/1347047530";
            AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            // 苹果服务器
            //            [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
            //                NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            //                NSLog(@"app再App Store中的内容:\n%@",str);
            //                NSDictionary * appInfoDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //                NSArray * resultArray = [appInfoDict objectForKey:@"results"];
            //
            //            } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
            //                // 获取苹果服务器失败
            //
            //            }];
            
        } break;
            
            
        case 4: {
            UIImage *testImg = [UIImage imageNamed:@"test_1"];
            
            NSLog(@"%@", testImg);
            
            NSData *data =  UIImagePNGRepresentation(testImg); //(testImg, 0.8);
            
            
            
        } break;
            
        case 5: {
            if (@available(iOS 13.0, *)) {
                [UIApplication sharedApplication].delegate.window.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
                printf("黑暗模式。。。");
            } else {
                // Fallback on earlier versions
            }
            
            
        } break;
            
        case 6: {
            
            if (@available(iOS 13.0, *)) {
                [UIApplication sharedApplication].delegate.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
                printf("正常模式。。。");
            } else {
                // Fallback on earlier versions
            }
            
            
        } break;
            
            
        case 7: {
            
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"\n請先授權app使用藍牙權限\n" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            //            UIAlertAction *cancleAction2 = [UIAlertAction actionWithTitle:@"取消2" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            //
            //            }];
            
            UIAlertAction *openAction = [UIAlertAction actionWithTitle:@"前往授權" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
                NSURL *openSetting = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:openSetting options:@{} completionHandler:^(BOOL success) { }];
                } else {
                    [[UIApplication sharedApplication] openURL:openSetting];
                }
                
            }];
            [alertVC addAction: cancleAction];
            //            [alertVC addAction: cancleAction2];
            [alertVC addAction: openAction];
            
            [self presentViewController:alertVC animated:YES completion:nil];
            
            
            
        } break;
            
            
        case 8: { // 获取当前位置
            
            [Positioning weiZhiInfo:^(AddressInfo *location) {
                NSLog(@"%@",location);
            } userRefused:^(NSInteger state2) {
                
            } systemRefused:^(NSInteger state6) {
                
            } shiBai:^(NSInteger state1) {
                
            }];
            
        }
            break;
            
        case  9: { // 获取粘贴板
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            
//            C_LOG(@"类型：%@", pasteboard.pasteboardTypes);
            
//            C_LOG(@"%@", pasteboard.items);
            
            
            NSArray *itemsTypes = [pasteboard pasteboardTypesForItemSet:nil];
            
            C_LOG(@"类型数组：%@", itemsTypes);

            
            
//            NSData *data = [pasteboard dataForPasteboardType:@"com.apple.WebKit.custom-pasteboard-data"];
//            
//           
//            NSLog(@"data %@", data);
//            
//            for (NSDictionary *dic in pasteboard.items) {
//                C_LOG(@"%@ ", dic);
//
////                NSData *file = dic[@"com.apple.WebKit.custom-pasteboard-data"];
////                NSLog(@"file: %@", file.description);
////                NSLog(@"\n");
//            }
//            
//            UIImage *image = pasteboard.image;
//            NSData *imgData = 
            
//            C_LOG(@"image: %@", image)
//            C_LOG(@"name: %@",pasteboard.name);
//            C_LOG(@"color: %@",pasteboard.color);
//            C_LOG(@"string: %@",pasteboard.string);
        }
            break;

        case  10: {
            
        }
        
        default:
            break;
    }
}


 

- (void)showDynamicPicturesButtonWithData:(NSData *)data {
    
    
    NSLog(@"%ld\n\n", data.length);
    
//    NSLog(@"%p\n\n", data.bytes);
    
    Byte baseImgLength[4];
    [data getBytes:baseImgLength range:NSMakeRange(data.length - 4, 4)];
    // 结尾处为0xffd9，标识图片数据结束，不可能是动图
    if (baseImgLength[2] == 0xFF && baseImgLength[3] == 0xD9) {
        return;
    }
    

    int a = baseImgLength[0] & 0xff;
    int b = (baseImgLength[1]<<8) & 0xff00;
    int c = (baseImgLength[2]<<16) & 0xff0000;
    int d = (baseImgLength[3]<<24) & 0xff000000;

    
    NSLog(@"位移结果");
    NSLog(@"与结果--> %d、 %d、 %d、 %d ", a, b, c, d);
    
    NSLog(@"或结果--> %d ", a|b|c|d);

    
    
    
    // 图片数据长度
    int baseImageLength = (unsigned int)((baseImgLength[0]&0xff) | ((baseImgLength[1] << 8)&0xff00) | ((baseImgLength[2]<<16)&0xff0000) | ((baseImgLength[3]<<24)&0xff000000));
    
    int length =  [NSNumber numberWithInt:baseImageLength].intValue;

    NSLog(@"--> %d", length);
    // 动态图片数量
    Byte picturesNum[1];
    [data getBytes:picturesNum range:NSMakeRange(length, 1)];
    if ((int)picturesNum[0] > 0) {
        int rangeLoc = baseImageLength + 1;
        for (int i = 0; i < (int)picturesNum[0]; i++) {
            // 图片数据长度
            Byte imgLength[4];
            [data getBytes:imgLength range:NSMakeRange(rangeLoc, 4)];
            int imageLength = (int)((imgLength[0]&0xff) | ((imgLength[1] << 8)&0xff00) | ((imgLength[2]<<16)&0xff0000) | ((imgLength[3]<<24)&0xff000000));
            rangeLoc += 4;
            // 图片数据
            Byte dynamicImg[imageLength];
            if (rangeLoc+imageLength >= data.length) {
                NSLog(@"......");
                return;
            }
            [data getBytes:dynamicImg range:NSMakeRange(rangeLoc, imageLength)];
            NSData *imgData = [NSData dataWithBytes:dynamicImg length:imageLength];
            rangeLoc += imageLength;
            // 图片对象
            UIImage *img = [UIImage imageWithData:imgData];
            NSLog(@"--> %@", img);
            
        }
    }
}


 



@end





