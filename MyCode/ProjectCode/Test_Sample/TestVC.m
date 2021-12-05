//
//  TestVC.m
//  MyCode
//
//  Created by New_iMac on 2021/3/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "TestVC.h"
#import "TestView.h"
#import "TestModel.h"
#import <objc/runtime.h>
#import <pthread/pthread.h>
#import <malloc/malloc.h>
//#import <QuartzCore/CALayer.h>
#import <sqlite3.h>
#import <mach/mach_host.h>

#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <SafariServices/SFSafariViewController.h>

#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>


@interface TestVC (){

};

@property(nonatomic, strong) UILabel *txtLab;
@property(nonatomic, strong) UILabel *txtLab2;
@property(nonatomic, copy) NSMutableString *testStr1;
@property(nonatomic, copy) NSMutableString *testStr2;

@end

@implementation TestVC

 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Test";
    
    NSArray *functionName = @[@"测试1", @"测试2", @"测试3", @"测试4", @"测试5", @"测试6"];
    
    WeakSelf(weakSelf)
    [TestBtnView showViewOn:self.view btnTitleAry:functionName clickComplete:^(NSInteger btnTag) {
        [weakSelf clickBtn:btnTag];
    }];
    
    
    _testStr2 = [[NSMutableString alloc]initWithString:@"哈哈哈"];
    
}




-(void)test {
    NSLog(@"222222");
}


-(void)clickBtn:(NSInteger)tag {
    
    switch (tag) {
        case 1: {
                           
//            C_LOG(@"%@",[RuntimeApi classIvars:[UILabel class]]);
//            C_LOG(@"%@",[RuntimeApi classPropertys:[UILabel class]]);
            
            NSThread *thread = [[NSThread alloc]initWithBlock:^{
                NSLog(@"111111");
            }];
            
            [thread start];
            
            [self performSelector:@selector(test) onThread:thread withObject:nil waitUntilDone:NO];
        
            
            
        } break;
            
        case 2: {
            _testStr1 = _testStr2;
            [_testStr1 insertString:@"哦哦哦" atIndex:2];
            
            NSLog(@"1: %@   2: %@", _testStr1, _testStr2);
            NSLog(@"1: %p   2: %p", _testStr1, _testStr2);
            NSLog(@"1: %p   2: %p", &_testStr1, &_testStr2);

            
            
            
            
        } break;
            
            
        case 3:  {
 
            
            
        } break;
            
                       
        case 4: {
            
    
            
        } break;
            
        case 5: {
 
        }
            
        case 6: {
               
            
        }
            
        default:
            break;
    }
}




@end





