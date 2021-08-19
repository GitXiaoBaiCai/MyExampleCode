//
//  AppDelegate.m
//  MyCode
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 mycode. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TestVC.h"

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self addMainViewController];
        
    
    
    
    
    
    
    
    
    return YES;
}

// 示例vc
-(void)addMainViewController{
    ViewController *vc = [[ViewController alloc]init];
    _rootNavc = [[Base_NavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = _rootNavc;
}

 
 
//#pragma mark ===>>> app生命周期
//- (void)applicationWillResignActive:(UIApplication *)application {
//    NSLog(@"App将要进入后台");
//}
//
//- (void)applicationDidEnterBackground:(UIApplication *)application {
//    NSLog(@"App已经进入后台");
//}
//
- (void)applicationWillEnterForeground:(UIApplication *)application {
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; // .applicationIconBadgeNumber = 0;
    NSLog(@"App将要进入前台");
}
//
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    NSLog(@"App已经进入前台");
}
//
//- (void)applicationWillTerminate:(UIApplication *)application {
//    NSLog(@"App进程将要被结束");
//}
 


// 注册本地通知
-(void)registLocalNotification{
    if (@available(iOS 10.0, *)) { // iOS10 以上
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            NSLog(@"通知权限状态：%@",granted?@"已开启":@"未开启");
        }];
    } else {// iOS8.0 以上
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }    
}



-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler NS_AVAILABLE_IOS(10.0){
    C_LOG(@"收到的推送消息：\n\n title: %@\n\n subtitle: %@\n\n body: %@\n\n badge: %@\n\n sound: %@\n\n categoryIdentifier: %@\n\n threadIdentifier: %@\n\n launchImageName: %@\n\n userInfo: %@\n\n attachments: %@\n",
               notification.request.content.title,
               notification.request.content.subtitle,
               notification.request.content.body,
               notification.request.content.badge,
               notification.request.content.sound,
               notification.request.content.categoryIdentifier,
               notification.request.content.threadIdentifier,
               notification.request.content.launchImageName,
               notification.request.content.userInfo,
               notification.request.content.attachments);
    
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    }
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler __API_AVAILABLE(ios(10.0)){
    
    C_LOG(@"点击通知栏后获取的推送消息：\n\n title: %@\n\n subtitle: %@\n\n body: %@\n\n badge: %@\n\n sound: %@\n\n categoryIdentifier: %@\n\n threadIdentifier: %@\n\n launchImageName: %@\n\n userInfo: %@\n\n attachments: %@\n",
               response.notification.request.content.title,
               response.notification.request.content.subtitle,
               response.notification.request.content.body,
               response.notification.request.content.badge,
               response.notification.request.content.sound,
               response.notification.request.content.categoryIdentifier,
               response.notification.request.content.threadIdentifier,
               response.notification.request.content.launchImageName,
               response.notification.request.content.userInfo,
               response.notification.request.content.attachments);
        
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {

        }
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    C_LOG(@"IOS7以上应用程序内部接收到的通知：\n%@",userInfo);
}












@end
