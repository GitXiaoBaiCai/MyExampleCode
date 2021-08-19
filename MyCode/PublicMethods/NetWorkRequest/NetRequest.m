//
//  NetRequest.m
//  MySlhb
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import "NetRequest.h"

#define  OutTime 16
#define whether_log 0  // 是否打印网络请求0:全都打印 1:只打印请求 2:只打印返回json和请求 3都不打印

@implementation NetRequest




#pragma mark ===>>> Get 和 Post 请求

+(void)requestType:(NSInteger)type url:(NSString*)url ptdic:(id __nullable)pdic success:(void (^)(id nwdic))completeS serverOrNetWorkError:(void(^)(NSInteger errorType, NSString * failure))completeErrorResults{
    
    @try {
        
        NSMutableDictionary * allPdic = [NSMutableDictionary dictionaryWithDictionary:pdic];
       
        NSString * urlStr = url;  // 链接
       
        if (type==0||type==1) { // 需要公共参数
            if (![[allPdic allKeys] containsObject:@"token"]&&user_token.length>0) {
                allPdic[@"token"] = user_token;
            }
        }
        
        if (type==1||type==3) { // get请求
            
            [self getRequest:urlStr pdic:allPdic success:^(NSDictionary *nwdic) { // 请求成功回调
                if (type==3) { completeS(nwdic); } else {
                    
                    NSString * code = null_str(nwdic[@"code"]);
                    if (code.length>0&&[code isEqualToString:@"0"]) {
                        completeS(nwdic);
                    }else{
                        completeErrorResults(0,null_str(nwdic[@"message"]));
                    }
                    
                }
            } failure:^(NSString *failure) { // 请求失败的回调
                // 出现网络错误在重新请求一次
                if ([failure containsString:@"网络连接已中断"]||[failure containsString:@"未能找到使用指定主机名的服务器"]) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self getRequest:urlStr pdic:allPdic success:^(NSDictionary *nwdic) {
                            if (type==3) { completeS(nwdic); } else {
                                NSString * code = null_str(nwdic[@"code"]);
                                if (code.length>0&&[code isEqualToString:@"0"]) {
                                    completeS(nwdic);
                                }else{
                                    completeErrorResults(0,null_str(nwdic[@"message"]));
                                }
                            }
                        } failure:^(NSString *failure) { completeErrorResults(1,failure); }];
                    });
                    
                }else{ completeErrorResults(1,failure); }
                
            }];
            
        } else { // post请求
            
            [self postRequest:urlStr pdic:allPdic success:^(NSDictionary *nwdic) { // 请求成功回调
                if (type==2) { completeS(nwdic); } else {
                    NSString * code = null_str(nwdic[@"code"]);
                    if (code.length>0&&[code isEqualToString:@"0"]) {
                        completeS(nwdic);
                    }else{
                        completeErrorResults(0,null_str(nwdic[@"message"]));
                    }
                }
            } failure:^(NSString *failure) { // 请求失败的回调
                // 出现网络错误在重新请求一次
                if ([failure containsString:@"网络连接已中断"]||[failure containsString:@"未能找到使用指定主机名的服务器"]) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self postRequest:urlStr pdic:allPdic success:^(NSDictionary *nwdic) {
                            if (type==2) { completeS(nwdic); } else {
                                NSString * code = null_str(nwdic[@"code"]);
                                if (code.length>0&&[code isEqualToString:@"0"]) {
                                    completeS(nwdic);
                                }else{
                                    completeErrorResults(0,null_str(nwdic[@"message"]));
                                }
                            }
                        } failure:^(NSString *failure) { completeErrorResults(1,failure); }];
                    });
                    
                }else{ completeErrorResults(1,failure); }
                
            }];
        }
    } @catch (NSException *exception) {
        completeErrorResults(1,@"请求接口出现异常!");
    } @finally { }
    
    
}

+(void)getRequest:(NSString*)url pdic:(id __nullable)pdic success:(void (^)(NSDictionary *nwdic))completeS failure:(void(^)(NSString*failure))completeF{
    
    @try {
        AFHTTPSessionManager * manager = [AFNetManager shareManager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = OutTime ;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [self http:url pdic:pdic]; // 打印请求链接
        [manager GET:url parameters:pdic progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
            
            [self nalogHttp:url pdic:pdic resdate:responseObject type:2];
            NSDictionary * dicData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dicData) { completeS(null_dic(dicData)); }
            else{ completeF(@"返回数据为空，或数据格式有误!"); }
            
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
            NSString * codeStr = [self codeStr:responses.statusCode];
            if (codeStr.length > 0) { completeF(codeStr); }
            else{  completeF(error.localizedDescription);  }
            [self nalogHttp:url pdic:pdic error:error type:2];
        }];
    } @catch (NSException *exception) { completeF(@"请求失败!"); } @finally { }
    
}

+(void)postRequest:(NSString*)url pdic:(id __nullable)pdic success:(void (^)(NSDictionary *nwdic))completeS failure:(void(^)(NSString*failure))completeF{
    
    @try {
        AFHTTPSessionManager *manager = [AFNetManager shareManager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = OutTime ;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        [self http:url pdic:pdic]; //打印请求链接
        
        [manager POST:url parameters:pdic progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
            
            [self nalogHttp:url pdic:pdic resdate:responseObject type:1];
            NSDictionary * dicData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dicData) { completeS((dicData)); }
            else{ completeF(@"返回数据为空，或JSON格式有误!"); }
            
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
            NSString * codeStr = [self codeStr:responses.statusCode];
            if (codeStr.length > 0) { completeF(codeStr); }
            else{  completeF(error.localizedDescription);  }
            [self nalogHttp:url pdic:pdic error:error type:1];
        }];
    } @catch (NSException *exception) { completeF(@"请求失败!"); } @finally { }
    
}

#pragma mark ===>>> 上传文件
+(void)urlUpFile:(NSString *)url ptdic:(id __nullable)pdic pName:(NSString *)name upType:(NSInteger)upType data:(id)data success:(void (^)(id))completeS progress:(void (^)(NSProgress *))completeUploadProgress serverOrNetWorkError:(void (^)(NSInteger, NSString *))completeErrorResults{
    
    NSString * upUrl = url;
    AFHTTPSessionManager * manager = [AFNetManager shareManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 请求体中最终参数
    NSMutableDictionary * allPdic = [[NSMutableDictionary alloc]initWithDictionary:pdic];
    
    NSInteger ftype = 2;  // 记录当前data类型 1:数组 2:image 3:data
    if (data) {
        if ([data isKindOfClass:[NSArray class]]||[data isKindOfClass:[NSMutableArray class]]) { ftype = 1 ; }
        if ([data isKindOfClass:[UIImage class]]) { ftype = 2; }
        if ([data isKindOfClass:[NSData class]]) { ftype = 3; }
    }
    
    // 图片大小不能超过500kb
    // Content-type 对照表:http://tool.oschina.net/commons
    
    NSString * fileName = @"image/jpeg";
    if (upType==1) { fileName = @"text/plain"; }
    
    [manager POST:upUrl parameters:allPdic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        @try {
            switch (ftype) {
                case 1:{ // 数组类型(二进制或图片)
                    NSArray * dataAry = (NSArray*)data;
                    if (dataAry.count>0) {
                        
                        for (id dt in dataAry) {
                            if ([dt isKindOfClass:[NSData class]]) {
                                [formData appendPartWithFileData:dt name:name fileName:fileName mimeType:fileName];
                                NSData * d = (NSData*)dt;
                                float dataLength = [FORMATSTR(@"%lu",(unsigned long)d.length) floatValue]/1000;
                                C_LOG(@"文件大小: %.2fKb",dataLength);
                            }
                            if ([dt isKindOfClass:[UIImage class]]) {
                                NSData * upDt = UIImageJPEGRepresentation(dt, 1);
                                float dataLength = [FORMATSTR(@"%lu",(unsigned long)upDt.length) floatValue]/1000;
                                C_LOG(@"文件大小: %.2fKb",dataLength);
                                if (dataLength>500) {
                                    float  bili = 1.0 , fl1 ;
                                    for (int i=9; i<10;i--) {
                                        bili = [FORMATSTR(@"%d",i) floatValue]/10 ;
                                        upDt = UIImageJPEGRepresentation(dt,bili);
                                        fl1 = [FORMATSTR(@"%lu",(unsigned long)upDt.length) floatValue]/1000;
                                        if (fl1<=500) {
                                            C_LOG(@"压缩后文件大小约为: %.2fkb",fl1);
                                            [formData appendPartWithFileData:upDt name:name fileName:fileName mimeType:fileName];
                                            break ;
                                        }
                                    }
                                }else{
                                    [formData appendPartWithFileData:upDt name:name fileName:fileName mimeType:fileName];
                                }
                            }
                        }
                        
                    }
                } break;
                    
                case 2:{ // 单张图片
                    NSData * upDt = UIImageJPEGRepresentation(data, 1);
                    float dataLength = [FORMATSTR(@"%lu",(unsigned long)upDt.length) floatValue]/1000;
                    C_LOG(@"文件大小: %.2fKb",dataLength);
                    if (dataLength>500) {
                        float  bili = 1.0 , fl1 ;
                        for (int i=9; i<10;i--) {
                            bili = [FORMATSTR(@"%d",i) floatValue]/10 ;
                            upDt = UIImageJPEGRepresentation(data,bili);
                            fl1 = [FORMATSTR(@"%lu",(unsigned long)upDt.length) floatValue]/1000;
                            if (fl1<=500) {
                                C_LOG(@"压缩后文件大小约为: %.2fkb",fl1);
                                [formData appendPartWithFileData:upDt name:name fileName:fileName mimeType:fileName];
                                break ;
                            }
                        }
                    }else{
                        [formData appendPartWithFileData:upDt name:name fileName:fileName mimeType:fileName];
                    }
                } break;
                    
                case 3:{ // data为NSData类型
                    NSData * dt = (NSData*)data;
                    [formData appendPartWithFileData:dt name:name fileName:fileName mimeType:fileName];
                    float dataLength = [FORMATSTR(@"%lu",(unsigned long)dt.length) floatValue]/1000;
                    C_LOG(@"文件大小: %.2fKb",dataLength);
                } break;
                    
                default:  break;
            }
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        C_LOG(@"上传进度: %.2f",uploadProgress.fractionCompleted);
        completeUploadProgress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self nalogHttp:url pdic:allPdic resdate:responseObject type:1];
        NSDictionary * dicData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dicData) {
            completeS(dicData);
        }else{
            completeErrorResults(0,@"返回数据为空，或JSON格式有误!");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        NSString * codeStr = [self codeStr:responses.statusCode];
        if (codeStr.length > 0) { completeErrorResults(1,codeStr); }
        else{  completeErrorResults(1,error.localizedDescription);  }
        [self nalogHttp:url pdic:pdic error:error type:1];
    }];
    
}

#pragma mark ===>>> 下载图片 (支持多张)

+(void)downloadImageByUrl:(id)url success:(void (^)(id result))completeS serverOrNetWorkError:(void(^)(NSInteger errorType, NSString * failure))completeErrorResults{
    
    @try {
        C_LOG(@"下载的图片链接: \n%@",url)
        SDWebImageDownloader * downloader = [SDWebImageDownloader sharedDownloader];
        downloader.downloadTimeout = 6;
        
        if ([url isKindOfClass:[NSString class]]) { // 一个链接
            NSString * urlStr = (NSString*)url;
            SDImageCache * cache = [SDImageCache sharedImageCache];
            UIImage * cacheImg = [cache imageFromCacheForKey:urlStr];
            if (cacheImg) {  completeS(cacheImg); } // 有缓存直接拿缓存
            else{
                if ([urlStr hasPrefix:@"http"]) {
                    [downloader downloadImageWithURL:[NSURL URLWithString:urlStr]  options:SDWebImageDownloaderScaleDownLargeImages progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *  targetURL) {
                    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                        if (image!=nil) { completeS(image); }
                        else{ completeErrorResults(2,@"图片下载失败!"); }
                    }];
                }else{ completeErrorResults(2,@"图片链接错误!"); }
            }
            
        }else if ([url isKindOfClass:[NSArray class]]){ // 链接数组
            
            NSArray * urlAry = (NSArray*)url;
            if (urlAry.count>0) {
                NSMutableArray * mtUrlAry = [NSMutableArray arrayWithArray:urlAry];
                NSMutableArray * imageAry = [NSMutableArray array];
                for (NSInteger i=0; i<urlAry.count; i++) {
                    NSString * urlStr = null_str(urlAry[i]);
                    if ([urlStr hasPrefix:@"http"]) {
                        [downloader downloadImageWithURL:[NSURL URLWithString:urlStr]  options:SDWebImageDownloaderScaleDownLargeImages progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *  targetURL) {
                        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                            if (image!=nil) { [imageAry addObject:image]; }
                            else{ [mtUrlAry removeObject:urlStr]; }
                            // 所有图片下载完成
                            if (mtUrlAry.count>0&&imageAry.count>0&&mtUrlAry.count==imageAry.count) {
                                completeS(imageAry);
                                if (urlAry.count!=imageAry.count) {
                                    NSInteger errorCount = urlAry.count-imageAry.count;
                                    completeErrorResults(1,FORMATSTR(@"共%lu张图片，其中%ld张获取失败!",(unsigned long)urlAry.count,(long)errorCount));
                                }
                            }
                        }];
                    }else{
                        [mtUrlAry removeObject:urlStr];
                    }
                }
            }
            
        }else{
            completeErrorResults(2,@"参数格式不正确!");
        }
    } @catch (NSException *exception) {
        completeErrorResults(2,@"图片下载失败!");
    } @finally { }
    
}


#pragma mark ===>>> 打印请求内容
// 打印请求链接和参数
+(void)http:(NSString*)url pdic:(id)dic{
    
    if (whether_log==0||whether_log==1) {
        NSString * pjurl = [self pinJieUrl:url pdic:dic];
        [self nslogRequestUrlJson:pjurl];
    }
    
}

// 打印请求链接和请求成功的参数
+(void)nalogHttp:(NSString*)url pdic:(id)dic resdate:(id)objc type:(NSInteger)type{
    
    @try {
        if (whether_log==0||whether_log==2) {
            NSString * getStr = [self pinJieUrl:url pdic:dic];
            
            NSString * str = [[NSString alloc]initWithData:objc encoding:NSUTF8StringEncoding];
            NSString * postget = @"POST" ; if( type == 2 ) { postget = @"GET" ; }
            C_LOG(@"%@ 请求成功的链接 : \n\n%@\n\n返回的数据 : \n\n%@\n",postget,getStr,str)
        }else{
            
        }
    } @catch (NSException *exception) { } @finally { }
    
}

// 打印请求失败错误信息
+(void)nalogHttp:(NSString*)url pdic:(id)dic error:(NSError*)error type:(NSInteger)type{
    
    NSString * getStr = [self pinJieUrl:url pdic:dic];
    NSString * postget = @"POST" ; if(type==2) { postget = @"GET" ; }
    C_LOG(@"%@请求失败的链接:\n\n%@\n\n失败错误信息:\n\n%@\n",postget,getStr,error)
    
}
// 将请求接口和参数拼接成完整的get链接
+(NSString*)pinJieUrl:(NSString*)url pdic:(id)dic{
    @try {
        if ([dic isKindOfClass:[NSDictionary class]]||[dic isKindOfClass:[NSMutableDictionary class]]) {
            NSArray * aryKey = [dic allKeys];
            NSString * getStr = url;
            if (![getStr containsString:@"?"]) {
                if (aryKey.count>0) {
                    NSString * key0 = aryKey[0];
                    getStr = FORMATSTR(@"%@?%@=%@",getStr,key0,dic[key0]);
                }
            }
            if (aryKey.count>=2) {
                for (int a = 1; a < aryKey.count; a++) {
                    NSString * key = aryKey[a];
                    getStr = FORMATSTR(@"%@&%@=%@",getStr,key,dic[key]);
                }
            }
            return getStr;
        }else{ return url; }
    } @catch (NSException *exception) { return @""; } @finally { }
    
}

// 打印所有参数（已拼接成json格式，方便看）
+(void)nslogRequestUrlJson:(NSString*)getStr{
    @try {
        if ([getStr containsString:@"?"]) {
            NSArray * fenge = [getStr componentsSeparatedByString:@"?"] ;
            NSString * canshuStr = [fenge lastObject];
            NSArray * arr = [canshuStr componentsSeparatedByString:@"&"];
            NSArray * a0 = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSUInteger len0 = [(NSString *)obj1 length];
                NSUInteger len1 = [(NSString *)obj2 length];
                return len0 > len1 ? NSOrderedAscending : NSOrderedDescending;
            }];
            canshuStr = [a0 componentsJoinedByString:@"\",\n   \""];
            canshuStr = [canshuStr stringByReplacingOccurrencesOfString:@"=" withString:@"\":\""];
            canshuStr = FORMATSTR(@" {\n   \"域名和接口名:\":\"%@\",\n\n   \"*** 参数名 ***\":\"---------- ****** 参数值 ****** ----------\",\n\n   \"%@\"\n }",[fenge firstObject],canshuStr);
            C_LOG(@" ==================== ****** 请求的域名、方法名、参数 ****** ====================\n%@",canshuStr)
        }else{
            
        }
    } @catch (NSException *exception) { } @finally { }
}




#pragma mark ===>>> 失败状态码
+(NSString*)codeStr:(NSInteger)code{
    // http://tool.oschina.net/commons?type=5 // 错误码大全
    NSString * scode = @"" ;
    switch (code) {
        case 400: { scode = @"(400)请求参数有误!"; } break;
        case 401: { scode = @"(401)当前用户无法验证!"; } break;
        case 403: { scode = @"(403)请求资源不可用!"; } break;
        case 404: { scode = @"(404)请求失败，服务器地址不存在!"; } break;
        case 408: { scode = @"(408)请求超时!"; } break;
        case 409: { scode = @"(409)请求内容和请求资源存在冲突!"; } break;
        case 410: { scode = @"(410)请求资源不可用!"; } break;
        case 413: { scode = @"(413)请求内容过多，暂时无法处理!"; } break;
        case 414: { scode = @"(414)请求链接过长，暂时无法处理!"; } break;
        case 415: { scode = @"(415)请求格式不支持，暂时无法处理!"; } break;
        case 421: { scode = @"(421)服务器爆满，请稍后尝试!";  } break;
        case 500: { scode = @"(500)服务器出错，请稍后再试!"; } break;
        case 501: { scode = @"(501)服务器不支持当前请求!"; } break;
        case 502: { scode = @"(502)服务器未响应，请稍后再试!"; } break;
        case 503: { scode = @"(503)服务器繁忙，请稍后再试!"; } break;
        case 504: { scode = @"(504)哎呀，请求服务器超时啦!"; } break;
        case 505: { scode = @"(505)服务器不支持当前请求!"; } break;
        default: break;
    }
    return scode;
}






#pragma mark //************ 动态域名有关 ************//

#define dns_main_key      @"Slhb_dns_main"     // 主域名
#define dns_socket_key    @"dns_socket_key"    // 主长连接域名

+(void)requestDynamicDNS{
    
    [NetRequest getRequest:default_dns_mian pdic:nil success:^(NSDictionary * _Nonnull nwdic) {
        
        NSString * mian_dns = null_str(nwdic[@"api"]);
        if ([mian_dns hasPrefix:@"http"]) { ns_user_defaults_save(mian_dns, dns_main_key) }
        
        NSString * socket_dns = null_str(nwdic[@"socket"]);
        if (socket_dns.length>0) { ns_user_defaults_save(socket_dns, dns_socket_key) }
        
    } failure:^(NSString * _Nonnull failure) {
        ns_user_defaults_delete(dns_main_key)
        ns_user_defaults_delete(dns_socket_key)
        C_LOG(@"动态域名获取失败。。。");
    }];
    
}

+(NSString*)get_local_dns_by_type:(NSInteger)type{
    
    switch (type) {
            
        case 0:{ // 主域名
            if (ns_user_defaults_take(dns_main_key)) {
                return  (NSString*)ns_user_defaults_take(dns_main_key);
            }else{ return default_dns_mian; }
        } break;
            
        case 1:{ // socket域名
            if (ns_user_defaults_take(dns_socket_key)) {
                return  (NSString*)ns_user_defaults_take(dns_socket_key);
            }else{ return default_dns_socket; }
        } break;
            
        default:{ return default_dns_mian; } break;
            
    }
}




@end
