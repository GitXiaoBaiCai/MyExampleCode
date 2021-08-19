//
//  NSRunLoopVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/24.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "NSRunLoopVC.h"

@interface NSRunLoopVC ()

@end

@implementation NSRunLoopVC

- (void)viewDidLoad {
    [super viewDidLoad];
/**
 RunLoop
 
 基本作用
 保持程序持续运行
 处理app中的各种事件（比如触摸，定时器等）
 节省CPU资源，提高程序性能；该做事的时候做事，该休息的时候休息
 
 ios中有两种方式访问RunLoop
 1：Foundation中的 NSRunLoop
 2：Core Foundation 中的 CFRunLoopRef
 
 每条线程都有唯一的一个与之对应的RunLoop对象
 RunLoop保存在一个全局的Dictionary里，线程作为key，RunLoop作为value
 线程刚创建的时候并没有RunLoop对象，RunLoop会在第一次获取它时创建
 RunLoop会在线程结束时销毁
 主线程的RunLoop已经自动获取(创建)，子线程默认没有开启runloop
 
 每个RunLoop包含若干个mode，每个mode又包含若干个Source0/Source1/Timer/Observer
 
 RunLoop启动时只能选择其中一个mode作为currentMode
 如果需要切换mode只能退出当前mode(不是退出RunLoop)，再重新选择一个model进入
 不同组的Source0/Source1/Timer/Observer能分割开来，互不影响
 如果mode里没有任何Source0/Source1/Timer/Observer，RunLoop会里面退出
 
 */
    
    //    NSDefaultRunLoopMode   // 默认mode，主线程

    //    UITrackingRunLoopMode  // 界面跟踪mode，用于手势等UI和刷新操作，保证界面滑动时不受影响

    //    NSRunLoopCommonModes   // 通用模式(包含以上两种)

    // NSDefaultRunLoopMode、UITrackingRunLoopMode才是真正存在的模式
    // NSRunLoopCommonModes并不是一个真的模式，它只是一个标记，
    
    
    
    
    // 获取当前runloop，两种方式
    //    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    //    CFRunLoopRef runloop2 = CFRunLoopGetCurrent();
    
    
    
}


-(void)addObserverRunloop{
    
    // 创建Observer
//    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, observeRunLoopActicities, NULL);
//    // 添加Observer到RunLoop中
//    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
//    // 释放
//    CFRelease(observer);
    
    
    //    CFRunLoopObserverCreateWithHandler(<#CFAllocatorRef allocator#>, <#CFOptionFlags activities#>, <#Boolean repeats#>, <#CFIndex order#>, <#^(CFRunLoopObserverRef observer, CFRunLoopActivity activity)block#>)
        // 监听runloop的所有状态
        CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            switch (activity) {
                case kCFRunLoopEntry:{
                    NSLog(@"kCFRunLoopEntry");
                } break;
                    
                case kCFRunLoopBeforeTimers:{
                    NSLog(@"kCFRunLoopBeforeTimers");
                } break;
                    
                case kCFRunLoopBeforeSources:{
                    NSLog(@"kCFRunLoopBeforeSources");
                } break;
                    
                case kCFRunLoopBeforeWaiting:{
                    NSLog(@"kCFRunLoopEntry");
                } break;
                    
                case kCFRunLoopAfterWaiting:{
                    NSLog(@"kCFRunLoopEntry");
                } break;
                    
                case kCFRunLoopExit:{
                    NSLog(@"kCFRunLoopEntry");
                } break;
                
                default:
                    break;
            }
        });
        
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
        CFRelease(observer); // C语言要手动释放

}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
