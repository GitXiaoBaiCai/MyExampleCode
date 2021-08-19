//
//  AFNetManager.m
//  MySlhb
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import "AFNetManager.h"

@implementation AFNetManager


+(AFHTTPSessionManager *)shareManager {
    
    static AFHTTPSessionManager *manager=nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
    });
    
    return manager;
    
}


#pragma mark === >>> 检测网络
+(void)networkMonitoring{
    
    @try {
        AFNetworkReachabilityManager * netManager = [AFNetworkReachabilityManager sharedManager];
        
        [netManager startMonitoring];
        
        [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:{ //未知网络
                    [self postNetWorkingChange:@1];
//                    NSUDSaveData(@"1", @"NOW_NETWORK_STATE")
                    NSLog(@"《《 未知网络 》》");
                }break;
                    
                case AFNetworkReachabilityStatusNotReachable:{ //无法联网
                    [self postNetWorkingChange:@2];
//                    NSUDSaveData(@"2", @"NOW_NETWORK_STATE")
                    NSLog(@"《《 无法联网、网络链接已断开 》》");
                }break;
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:{ //手机自带网络
                    [self postNetWorkingChange:@3];
//                    NSUDSaveData(@"3", @"NOW_NETWORK_STATE")
                    NSLog(@"《《 当前使用的是2g/3g/4g网络 》》");
                }break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:{ //WIFI
                    [self postNetWorkingChange:@4];
//                    NSUDSaveData(@"4", @"NOW_NETWORK_STATE")
                    NSLog(@"《《 当前在WIFI网络下 》》");
                }
                    
            }
        }];
    } @catch (NSException *exception) { } @finally { }
    
}

+(void)postNetWorkingChange:(NSNumber*)state{
    [[NSNotificationCenter defaultCenter] postNotificationName:notice_net_work_change object:state];
}

@end
