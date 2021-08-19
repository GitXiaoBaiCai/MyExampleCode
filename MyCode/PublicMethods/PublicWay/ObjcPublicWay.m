//
//  ObjcPublicWay.m
//  MySlhb
//
//  Created by mac on 2019/3/20.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import "ObjcPublicWay.h"

@implementation ObjcPublicWay

+(void)photoPermissionsNoOpenShowVC:(UIViewController*)topvc photoPermissionsType:(void(^)(NSInteger type))photoPermissionsType{
    // 判断相册权限
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        NSLog(@"权限状态: %ld",(long)status);
        if (system_version>=11.0) {
            if (status==PHAuthorizationStatusAuthorized||status==PHAuthorizationStatusDenied) {
                photoPermissionsType(1);
            }else{
                [UIAlertController showIn:topvc title:@"提示" content:@"\n您还没有开启app相册权限，无法保存图片，是否开启？" ctAlignment:(NSTextAlignmentCenter) btnAry:@[@"取消",@"开启"] indexAction:^(NSInteger indexTag) {
                    if (indexTag==1) {
                        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if ([[UIApplication sharedApplication]canOpenURL:url]) {
                            [[UIApplication sharedApplication]openURL:url];
                        }else{ show_toast_msg(@"无法开启权限，请手动前往系统的app设置") }
                    }
                }];
            }
        }else{
            if (status==PHAuthorizationStatusAuthorized) { photoPermissionsType(1); }
            else{
                [UIAlertController showIn:topvc title:@"提示" content:@"您还没有开启app相册权限，是否开启？" ctAlignment:(NSTextAlignmentCenter) btnAry:@[@"取消",@"开启"] indexAction:^(NSInteger indexTag) {
                    if (indexTag==1) {
                        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if ([[UIApplication sharedApplication]canOpenURL:url]) {
                            [[UIApplication sharedApplication]openURL:url];
                        }else{ show_toast_msg(@"无法开启权限，请手动前往系统的app设置") }
                    }
                }];
            }
        }
    }];
}

+(void)playSound:(NSString*)name ofType:(NSString*)type whetherAlert:(BOOL)alert playEnd:(void(^)(BOOL is_end))playEnd{
    NSString * audioFile = [[NSBundle mainBundle] pathForResource:name ofType:type];
    NSURL * fileUrl = [NSURL fileURLWithPath:audioFile];
    
    // 1.获得系统声音ID
    SystemSoundID soundID = 0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
//     AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, playEnd(YES) , NULL);
    
    //2.播放音频
    if (alert==YES) { AudioServicesPlayAlertSound(soundID); }  // 播放音效并震动
    if (alert==NO) {  AudioServicesPlaySystemSound(soundID); } // 播放音效
    //3.销毁声音
    AudioServicesDisposeSystemSoundID(soundID);
}


@end
