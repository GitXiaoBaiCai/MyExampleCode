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
#import "Aaaaaa.h"

#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#include <net/if.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
  
    
//    NSLog(@"ip地址：%@", [self getIPAddress]);
    
    
    [self addMainViewController];
        
 
    
    UIDevice *device = [UIDevice currentDevice];

    NSLog(@"name: %@", device.name);
    NSLog(@"systemName: %@", device.systemName);
    NSLog(@"model: %@", device.model);
    NSLog(@"localizedModel: %@", device.localizedModel);
    NSLog(@"systemName: %@", device.systemName);
    NSLog(@"systemVersion: %@", device.systemVersion);
    NSLog(@"orientation: %ld", (long)device.orientation);
    NSLog(@"identifierForVendor: %@", device.identifierForVendor);
    NSLog(@"batteryState: %ld", (long)device.batteryState);
    NSLog(@"batteryLevel: %f", device.batteryLevel);
    NSLog(@"proximityMonitoringEnabled: %d", device.proximityMonitoringEnabled);
    NSLog(@"proximityState: %d", device.proximityState);
    NSLog(@"multitaskingSupported: %d", device.multitaskingSupported);
    
    
    
//    NSURL *url = [NSURL URLWithString:@"aaa://"];
//
//    [[UIApplication sharedApplication] openURL:url options:nil completionHandler:^(BOOL success) {
//        NSLog(@"--> %d", success);
//    }];
    
 

    
    
    

    
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
    NSLog(@"didBecomeActive: %f",[NSDate date].timeIntervalSince1970);
    NSLog(@"App已经进入前台");
}
//
//- (void)applicationWillTerminate:(UIApplication *)application {
//    NSLog(@"App进程将要被结束");
//}
 

/*
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

*/


-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"%@、 %@", url, options);
    return  YES;
}



//Save NSlog print information to a file in the Document directory
- (void)redirectNSlogToDocumentFolder{
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"Simulator"]) {
        return;
    }

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    NSString *documentDirectory = [paths objectAtIndex:0];

    NSString *fileName = [NSString stringWithFormat:@"test.log"];

    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];

    // Delete existing files
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:logFilePath error:nil];

    //Enter the log into the file
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);

}



-(NSString *)getIPAddress {
    
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
 
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0) {
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ) {
            
            ifr = (struct ifreq *)ptr;
            
            int len = sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            
            if ((cptr = (char *)strchr(ifr->ifr_name,':')) != NULL) *cptr = 0;
            
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0)continue;
            
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            
            ifrcopy = *ifr;
            
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString stringWithFormat:@"%s",inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            
            [ips addObject:ip];
        }
        
    }
    
    close(sockfd);
    
    NSString *deviceIP = @"";
    for (int i = 0; i < ips.count; i++) {
        if(ips.count > 0) {
            deviceIP = [NSString stringWithFormat:@"%@", ips.lastObject];
        }
    }
    
    return deviceIP;
}



@end







/*
 
 
 1.04    1.06    1.10    1.09    1.08    1.09    1.07    1.05    1.04

 1.69    1.63    1.66    1.48    1.58    1.54    1.59    1.70    1.48
 
 
 
 
 
 
 
 
 
 
 
 */




