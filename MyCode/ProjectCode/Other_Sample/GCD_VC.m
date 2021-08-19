//
//  GCD_VC.m
//  MyCode
//
//  Created by New_iMac on 2021/4/20.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "GCD_VC.h"
#import <libkern/OSAtomic.h> // 锁

#define slp_time 0.5

@interface GCD_VC ()
@property(nonatomic,strong) dispatch_semaphore_t semaphore; // 信号量
@end

@implementation GCD_VC

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSArray *functionName = @[@"全局主队列(并行)",
                              @"队列组(并行)",
                              @"延时执行",
                              @"只执行一次",
                              @"重复执行多次",
                              @"信号量测试",
                              @"",
                              @"",
                              @"",
                              @""];
    
    for (int i=0; i<functionName.count; i++) {
        NSString *title = functionName[i];
        if (!title||title.length<1) { break; }
        UIButton *button = [UIButton title:functionName[i] titColorN:color_white font:font_s(15) bgColor:color_theme];
        AddTarget_for_button(button, clickBtn:)
        [button cornerRadius:25];
        button.tag = i+1;
        [self.view addSubview:button];
//        float wi = StringSize(functionName[i], font_s(15)).width+15;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(navc_bar_h+30+i*70);
            make.width.offset(160); make.height.offset(50);
            make.centerX.equalTo(self.view.mas_centerX);
        }];
    }

    
    
    /*
    // 加锁（自旋锁，盲等）
    OSSpinLock osLock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&osLock); // 加锁
    // 此处是需要加锁的代码
    
    OSSpinLockUnlock(&osLock); // 解锁
    */
    
    // 创建信号量(参数必须大于0，数字代表：多个线程协作时，最多可以同时执行几个线程的任务)
    // 传2，代表，当有多个线程时，最多可以两个线程并行执行
    _semaphore = dispatch_semaphore_create(3);

    
}



-(void)clickBtn:(UIButton*)button{
    switch (button.tag) {
        case 1:{ [self global_queue]; } break;
            
        case 2:{ [self group_queue]; } break;
            
        case 3:{ [self dispatch_after]; } break;
            
        case 4:{ [self dispatch_oncet]; } break;
            
        case 5:{ [self queue_apply]; } break;

        case 6:{ [self signal_test];  } break;

        case 7:{   } break;

        case 8:{   } break;

            
        default: show_toast_msg(@"未实现该按钮事件！")  break;
    }
}


#pragma mark ==>> 全局队列，主队列

// 全局主队列(异步)
-(void)global_queue{
    
    // 多用于从其他线程回到主线程，将任务加入主线程队列
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@" %@ 回到主线程",[NSThread currentThread]);
//    });
    
    // 获取全局主队列（异步执行），参数1：调度优先级， 参数2：默认传0，官方解释，留待将来使用
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(globalQueue, ^{
        for (int a=0; a<100; a++) {
            [NSThread sleepForTimeInterval:slp_time];
            NSLog(@" %@ a --> %d",[NSThread currentThread],a);
        }
    });
    
    dispatch_async(globalQueue, ^{
        for (int b=100; b<200; b++) {
            [NSThread sleepForTimeInterval:slp_time];
            NSLog(@" %@ b --> %d",[NSThread currentThread],b);
        }
    });
    
    dispatch_async(globalQueue, ^{
        for (int c=200; c<300; c++) {
            [NSThread sleepForTimeInterval:slp_time];
            NSLog(@" %@ c --> %d",[NSThread currentThread],c);
        }
    });
    
    NSLog(@" ==>> %s ",__func__);
    
}

#pragma mark ==>> 队列组，自己创建

// 创建一个队列组(并行或串行)
-(void)group_queue{
    dispatch_group_t group = dispatch_group_create();
    // DISPATCH_QUEUE_CONCURRENT 并行(异步)
    // DISPATCH_QUEUE_SERIAL 或者 NULL  // 串行，先进先出
    // DISPATCH_QUEUE_SERIAL_INACTIVE  // 串行，先进先出，最初是闲置(不活跃)的
//    dispatch_queue_t queue = dispatch_queue_create("my_test_queue_0", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = dispatch_get_main_queue();

    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        for (int a=1; a<100; a++) {
            [NSThread sleepForTimeInterval:slp_time];
            NSLog(@" %@ x --> %d",[NSThread currentThread],a);
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    WeakSelf(weakSelf)
    dispatch_group_async(group, queue, ^{
//        for (int b=100; b<200; b++) {
//            [NSThread sleepForTimeInterval:slp_time];
//            NSLog(@" %@ y --> %d",[NSThread currentThread],b);
//        }
        [weakSelf newThread];
        dispatch_group_leave(group);

    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        
        [NetRequest requestType:3 url:@"https://www.baidu.com" ptdic:nil success:^(id  _Nonnull nwdic) {
            NSLog(@"------》》》成功 回调");
        } serverOrNetWorkError:^(NSInteger errorType, NSString * _Nonnull failure) {
            NSLog(@"------》》》失败 回调");
        }];
        
        for (int c=200; c<300; c++) {
            [NSThread sleepForTimeInterval:slp_time];
            NSLog(@" %@ z --> %d",[NSThread currentThread],c);
        }
        
        dispatch_group_leave(group);
        
    });
    
    // 上面三个任务完成后会在此处收到通知（该方法最好只实现一次）
    dispatch_group_notify(group, queue, ^{
        NSLog(@" %@ --> 队列中的三个任务都执行完了。。。",[NSThread currentThread]);
        NSLog(@"group => %@",group);
    });
    
    
//    dispatch_group_enter(group); // 进入队列组，标志着一个任务追加到 group，相当于 group 中未执行完毕任务数+1
//    dispatch_group_leave(group); // 离开队列组，标志着一个任务离开了 group，执行一次，相当于 group 中未执行完毕任务数-1
//    dispatch_suspend(queue); // 挂起队列(暂停)
//    dispatch_resume(queue); // 恢复队列
//    当 group 中未执行完毕任务数为0的时候，才会使dispatch_group_wait解除阻塞，以及执行追加到dispatch_group_notify中的任务

    
    NSLog(@" ==>> %s ",__func__);

}


#pragma mark ==>> 延时执行

// 延时执行(dispatch_after) 需要注意的是：dispatch_after函数并不是在指定时间之后才开始执行处理，而是在指定时间之后将任务追加到队列中。严格来说，这个时间并不是绝对准确的，但想要大致延迟执行任务，dispatch_after函数是很有效。
-(void)dispatch_after{
    NSLog(@"%@  --> 添加延时执行",[NSThread currentThread]);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2秒后异步追加任务代码到主队列
        NSLog(@"%@  --> 延时执行",[NSThread currentThread]);
    });
    
    NSLog(@" ==>> %s ",__func__);

}


#pragma mark ==>> 只执行一次

// 只执行一次(dispatch_once) 通常在创建单例时使用，多线程环境下也能保证线程安全
-(void)dispatch_oncet{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"%@  --> 只执行一次",[NSThread currentThread]);
    });
    NSLog(@"%s   onceToken：%ld",__func__,onceToken);
}


#pragma mark ==>> 多线程，重复执行多次某个任务

// 串行或并行(由参数决定)，重复执行多次
-(void)queue_apply{
    // 可以自己创建队列，也可以使用全局并发队列
    dispatch_queue_t queue = dispatch_queue_create("my_test_queue_1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(10000, queue, ^(size_t index) {
//        [NSThread sleepForTimeInterval:slp_time];
        NSLog(@"%@ 并行第 --> %zd 次任务",[NSThread currentThread],index);
    });
}


#pragma mark ==>> 信号量使用

// 信号量
-(void)signal_test{
    // 获取全局主队列(异步)
    dispatch_queue_t mian_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    for (int a=0; a<10; a++) {
        NSLog(@"for 循环开始： a = %d",a);
        dispatch_async(mian_queue, ^{
            NSLog(@"往全局队列添加任务： a = %d",a);
            NSLog(@"等待信号：--> %ld",dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER));
            NSLog(@"开始调用任务： a = %d",a);
            [self test_log:a];
        });
    }
     
}

-(void)test_log:(int)aaa{
    for (int i=0; i<10; i++) {
        [NSThread sleepForTimeInterval:slp_time];
        NSLog(@"self=%@  %@ ---> a=%d  ---  i=%d",self,[NSThread currentThread],aaa,i);
    }
    NSLog(@"信号：-->> %ld",dispatch_semaphore_signal(_semaphore));
    
}


#pragma mark ==>> 栅栏
// 可以保证线程安全（比如读写操作，可以做到，写的时候，其它线程不能读取，相当于是围了个栅栏，操作完成后，放开栅栏，其它线程才能操作）
-(void)barrier_test{

}
// 读
-(void)readFile{
    //    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    //    NSLog(@"%s",__FUNCTION__);
    //    dispatch_semaphore_signal(self.semaphore);
}
// 写
-(void)writeFile{
    //    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    //    NSLog(@"%s",__FUNCTION__);
    //    dispatch_semaphore_signal(self.semaphore);
}

 

#pragma mark ==>> 定时器

-(void)dispatch_timer{
    // 创建子线程队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 设置定 时器  每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        // 定时器内要执行的事情
    });
    dispatch_resume(_timer); // 启动定时器
//    dispatch_source_cancel(_timer); // 取消定时器
    
}






-(void)newThread{
    if (@available(iOS 10.0, *)) {
        [NSThread detachNewThreadWithBlock:^{
            for (int i=1000; i<2000; i++) {
                NSLog(@" %@ ------>> %d",[NSThread currentThread],i);
            }
        }];
    } else {
        // Fallback on earlier versions
    }
}


@end
