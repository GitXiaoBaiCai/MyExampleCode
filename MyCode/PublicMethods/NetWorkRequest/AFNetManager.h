//
//  AFNetManager.h
//  MySlhb
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFNetManager : AFHTTPSessionManager

+(AFHTTPSessionManager *)shareManager;

/**
 网络监测(监测结果发送全局通知)
 */
+(void)networkMonitoring;

@property (nonatomic,strong) AFNetworkReachabilityManager * netManager;


@end

NS_ASSUME_NONNULL_END
