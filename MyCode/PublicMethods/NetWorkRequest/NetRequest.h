//
//  NetRequest.h
//  MySlhb
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetRequest : NSObject

/**
 请求数据接口
 
 @param type 请求类型  0:Post需要公共参数  1:Get需要公共参数  2:post不需要公共参数的 3:get不需要公共参数
 @param url 请求链接
 @param pdic 请求的参数
 @param completeS 请求成功的回调(有公共参数，rsult:ok 才回调)
 @param completeErrorResults 请求失败的回调(有公共参数，回调rsult:失败原因和网络错误；没有公共参数:只回调网络错误)
 */
+(void)requestType:(NSInteger)type url:(NSString*)url ptdic:(id __nullable)pdic success:(void (^)(id nwdic))completeS serverOrNetWorkError:(void(^)(NSInteger errorType, NSString * failure))completeErrorResults;

+(void)getRequest:(NSString*)url pdic:(id __nullable)pdic success:(void (^)(NSDictionary *nwdic))completeS failure:(void(^)(NSString*failure))completeF;
+(void)postRequest:(NSString*)url pdic:(id __nullable)pdic success:(void (^)(NSDictionary *nwdic))completeS failure:(void(^)(NSString*failure))completeF;


/**
 上传文件接口
 
 @param url 链接地址
 @param pdic 其他参数
 @param name 文件名参数
 @param upType 文件类型后缀名(1:txt文档 其它:图片类型),
 @param data 文件( 支持类型: 数组(data或image类型)、单个data、单个image类型)
 @param completeS 成功回调
 @param completeUploadProgress 返回上传进度
 @param completeErrorResults 失败回调 (0(已请求成功，但服务器查询失败或未达到相关条件) 1:访问服务器失败(超时，网关错误，等等))
 */
+(void)urlUpFile:(NSString*)url ptdic:(id __nullable)pdic pName:(NSString*)name upType:(NSInteger)upType data:(id)data success:(void (^)(id nwdic))completeS progress:(void(^)(NSProgress * uploadProgress))completeUploadProgress serverOrNetWorkError:(void(^)(NSInteger errorType, NSString * failure))completeErrorResults;


/**
 下载图片
 
 @param url 图片链接(字符串或数组)
 @param completeS 下载成功的图片或图片数组
 @param completeErrorResults 失败原因
 */
+(void)downloadImageByUrl:(id)url success:(void (^)(id result))completeS serverOrNetWorkError:(void(^)(NSInteger errorType, NSString * failure))completeErrorResults;







#pragma mark //************ 动态域名有关 ************//

// 请求动态域名
+(void)requestDynamicDNS;


/*
 读取本地存储的动态域名
 0: 主域名  1: socket域名
 */
+(NSString*)get_local_dns_by_type:(NSInteger)type;


@end

NS_ASSUME_NONNULL_END
