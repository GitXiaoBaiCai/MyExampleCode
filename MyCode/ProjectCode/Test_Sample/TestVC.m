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

int a4 = 10;
int a5;

@interface TestVC (){
    int a3;
};
@property(nonatomic, strong) TestModel *testModel1;
@property(nonatomic, strong) TestModel *testModel2;

@property(nonatomic, strong) CADisplayLink *link;
@property(nonatomic, copy) NSString *str;

@property(strong, nonatomic) TestView *baseView;

@property(assign, nonatomic) int a1;
@property(assign, nonatomic) int a2;

@property(nonatomic, strong) NSObject *object1;
@property(assign, nonatomic) BOOL isSelect;

typedef void(^TestBlock)(NSString *string);
@property(nonatomic, copy) TestBlock testBlock;

@end

@implementation TestVC

 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Test";
    
    NSArray *functionName = @[@"测试1",
                              @"测试2",
                              @"测试3",
                              @"测试4",
                              @"",
                              @"",
                              @"",
                              @"",
                              @"",
                              @""];
    
    
    [TestBtnView showViewOn:self.view btnTitleAry:functionName clickComplete:^(NSInteger btnTag) {
        [self clickBtn:btnTag];
    }];

}



-(void)clickBtn:(NSInteger)tag {

    NSLog(@"点击了第 %ld 个功能",tag);
    
    switch (tag) {
        case 1: {
            
            
        } break;
            
         case 2: {
 
            
        } break;
            
            
        case 3:  {
 
            
            
        } break;
            
                       
        case 4: {
            
    
            
        } break;
            
        case 5: {
 
        }
            
        default:
            break;
    }
}




@end





