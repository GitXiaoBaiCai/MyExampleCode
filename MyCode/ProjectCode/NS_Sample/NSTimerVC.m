//
//  NSTimerVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/24.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "NSTimerVC.h"

@interface NSTimerVC ()
@property(nonatomic,strong) NSTimer *strongTimer;
@end

@implementation NSTimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _strongTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(testStrongTimer) userInfo:nil repeats:YES];
     
    
    
    NSArray *functionName = @[@"timer1",
                              @"timer2",
                              @"strongTimer",
                              @"",
                              @"",
                              @"",
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
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(navc_bar_h+30+i*70);
            make.width.offset(160); make.height.offset(50);
            make.centerX.equalTo(self.view.mas_centerX);
        }];
    }
        
    
    
}

-(void)clickBtn:(UIButton*)btn{
    switch (btn.tag) {
        case 1:{
            
            
        } break;
            
        case 2:{
            
            
        } break;
            
        case 3:{
//            if ([_strongTimer isValid]) {
                [_strongTimer fire];
//            }else{
//                [_strongTimer invalidate];
//            }
        } break;
            
        default:
            break;
    }
}


-(void)testTimer1{
    static int count = 0;
    if (@available(iOS 10.0, *)) {
        
        __weak typeof(self) weakSelf = self;
        NSTimer *timer1 = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"timer1 --> %d", ++count);
            if (!weakSelf) {
                [timer invalidate];
            }
        }];
        // 防止timer滑动时失效，将timer加入runloop通用mode
        [[NSRunLoop currentRunLoop] addTimer:timer1 forMode:NSRunLoopCommonModes];
        // NSDefaultRunLoopMode、UITrackingRunLoopMode才是真正存在的模式
        // NSRunLoopCommonModes并不是一个真的模式，它只是一个标记
        // timer能在_commonModes数组中存放的模式下工作
        
        // 其它创建方式
        
        // NSTimer *timer2 = [[NSTimer alloc]initWithFireDate:[NSDate date] interval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) { NSLog(@"timer2 -->"); }];
        // [[NSRunLoop currentRunLoop] addTimer:timer1 forMode:NSRunLoopCommonModes];
    
        
    } else {
        // Fallback on earlier versions
    }
}

-(void)testTimer2{

}


-(void)testStrongTimer{
    NSLog(@"--> %s",__func__);
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


 


@implementation TimerTarget

// #define proxyObjc  [TimerTarget initNewTarget:self]
// TimerTarget *proxyObjc = [TimerTarget initNewTarget:self];
// 其它地方使用时，只需要初始化下，将proxyObjc对象设置为target
+(instancetype)initNewTarget:(id)target{
    TimerTarget *tTarget = [TimerTarget alloc];
    tTarget.target = target;
    return tTarget;
}

// 返回方法签名
-(NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector{
    return [self.target methodSignatureForSelector:aSelector];
}

// 消息转发
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    [anInvocation invokeWithTarget:self.target];
}



@end
