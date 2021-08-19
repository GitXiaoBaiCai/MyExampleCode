//
//  ProjectDefClass.m
//  MySlhb
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import "ProjectDefClass.h"


@implementation ProjectDefClass


#pragma mark ===>>> 放大系数
+(float)screen_w_font_bili{

    NSInteger screen_w = [FORMATSTR(@"%f",ScreenW) integerValue];
    float bili = 1.0;
    switch (screen_w) {
        case 320:{ bili = 1.0; } break;  // 4英寸 @2x
        case 375:{ bili = 1.15; } break; // 4.7英寸 @2x / 5.8英寸 @3x
        case 414:{ bili = 1.2; } break;  // 5.5英寸 @3x / 6.5英寸 @3x
        case 1024:{ bili = 1.6; } break; // 12.9英寸pro @3x
        default:{ bili = 1.1; } break;
    }
    return bili;
}

+(float)screen_w_size_bili{
    NSInteger screen_w = [FORMATSTR(@"%f",ScreenW) integerValue];
    float bili = 1.0;
    switch (screen_w) {
        case 320:{ bili = 1.0; } break;  // 4英寸 @2x
        case 375:{ bili = 1.15; } break; // 4.7英寸 @2x / 5.8英寸 @3x
        case 414:{ bili = 1.2; } break;  // 5.5英寸 @3x / 6.5英寸 @3x
        case 1024:{ bili = 1.6; } break; // 12.9英寸pro @3x
        default:{ bili = 1.1; } break;
    }
    return bili;
}


#pragma mark ===>>> 获取主导航或顶层导航视图
+(UIViewController*)huoquCurrentTopVC{
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if ([window.rootViewController isKindOfClass:[MainTabBarNavc class]]) {
//        MainTabBarNavc * mian = (MainTabBarNavc*)window.rootViewController;
//        UINavigationController * naVC = (UINavigationController*)mian.selectedViewController;
//        UIViewController * topvc = naVC.topViewController;
//        return topvc;
//    }
    return nil;
}

+(UINavigationController*)huoquCurrentSltNavc{
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if ([window.rootViewController isKindOfClass:[MainTabBarNavc class]]) {
//        MainTabBarNavc * mian = (MainTabBarNavc*)window.rootViewController;
//        UINavigationController * naVC = (UINavigationController*)mian.selectedViewController;
//        return naVC;
//    }
    return nil;
}


#pragma mark ===>>> 存值、取值、删值
// MMKV存值取值
+(id)mmkv_take_data:(NSString*)keyName class:(Class)classN{
    MMKV * mmkv = [MMKV defaultMMKV];
    id takeData = [mmkv getObjectOfClass:classN forKey:keyName];
    return takeData;
}

+(void)mmkv_save_data:(id)data key:(NSString*)keyName{
    MMKV * mmkv = [MMKV defaultMMKV];
    [mmkv setObject:data forKey:keyName];
//    if ([data isKindOfClass:[NSString class]]) {
//        [mmkv setString:(NSString*)data forKey:keyName]; // 存字符串
//    }else if ([data isKindOfClass:[NSData class]]){
//        [mmkv setData:(NSData*)data forKey:keyName];  // 存data数据
//    }else if ([data isKindOfClass:[NSDate class]]){
//        [mmkv setDate:(NSDate *)data forKey:keyName]; // 存date时间
//    }else{
//        [mmkv setValue:data forKey:keyName];          // 存数组，字典等
//    }
}

+(void)mmkv_delete_data:(NSString*)keyName{
    MMKV * mmkv = [MMKV defaultMMKV];
    [mmkv removeValueForKey:keyName];
}

+(void)mmkv_delete_all_dada{
    MMKV * mmkv = [MMKV defaultMMKV];
    [mmkv clearAll];
}


#pragma mark ===>>> sign签名加密
+(NSString*)parameterSignStr:(NSDictionary*)pdic{
    
    NSArray * arraykey = [pdic allKeys];
    NSMutableArray * allAry = [NSMutableArray arrayWithArray:arraykey];
    NSArray * resultSortingAry = [allAry sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2]; // 升序: A~Z
    }];
    
    NSString * format_key_value = @"";
    for (int i=0; i<resultSortingAry.count; i++) {
        NSString * key = resultSortingAry[i];
        if (i==0) { // 第一个
            format_key_value = FORMATSTR(@"%@=%@",key,pdic[key]);
        }else{
            format_key_value = FORMATSTR(@"%@&%@=%@",format_key_value,key,pdic[key]);
        }
    }
    format_key_value = FORMATSTR(@"%@%@",format_key_value,app_secret);
    C_LOG(@"[%@]",format_key_value)
    
    return md5_str(format_key_value);
    
}


+(NSString*)jsonStrByDictionary:(NSDictionary *)dic{
    NSError * parseError = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    LOG(@"字典转json：\n%@",jsonString)
    return null_str(jsonString);
}
+(NSDictionary*)dictionaryByJsonStr:(id)json{
    if ([json isKindOfClass:[NSData class]]) {
        NSDictionary * dicData = [NSJSONSerialization JSONObjectWithData:(NSData*)json options:NSJSONReadingMutableContainers error:nil];
//        LOG(@"json转字典：\n%@",dicData)
        return  null_dic(dicData);
    }
    NSData * jsonData = [null_str(json) dataUsingEncoding:(NSUTF8StringEncoding)];
    NSDictionary * dicData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//    LOG(@"json转字典：\n%@",dicData)
    return  null_dic(dicData);
}


+(void)playSound:(NSString*)name ofType:(NSString*)type whetherAlert:(BOOL)alert{
    @try {
        NSString * audioFile = [[NSBundle mainBundle] pathForResource:name ofType:type];
        if (audioFile) {
            NSURL * fileUrl = [NSURL fileURLWithPath:audioFile];
            
            // 1.获得系统声音ID
            SystemSoundID soundID = 0;
            /**
             * inFileUrl:音频文件url
             * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
             */
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
            
            //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
            //     AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, NULL , NULL);
            
            
            if (alert==YES) {
                if (@available(iOS 9.0, *)) {
                    AudioServicesPlayAlertSoundWithCompletion(soundID, ^{
                        AudioServicesDisposeSystemSoundID(soundID);
                    });
                } else { AudioServicesPlayAlertSound(soundID); }
            }else{
                if (@available(iOS 9.0, *)) {
                    AudioServicesPlaySystemSoundWithCompletion(soundID, ^{
                        AudioServicesDisposeSystemSoundID(soundID);
                    });
                } else {
                    AudioServicesPlaySystemSound(soundID);
                }
            }
        }
        
    } @catch (NSException *exception) { } @finally { }
   
}




@end
