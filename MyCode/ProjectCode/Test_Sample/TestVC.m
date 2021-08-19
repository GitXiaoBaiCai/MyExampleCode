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

    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    NSLog(@"%f %f",[UIApplication sharedApplication].statusBarFrame.size.height,[UIApplication sharedApplication].statusBarFrame.size.width);
    NSLog(@"%f",self.navigationController.navigationBar.frame.size.height);
    if (@available(iOS 11.0, *)) {
        NSLog(@"safeAreaInsets --> top:%f  bottom:%f  left:%f  right:%f", window.safeAreaInsets.top,window.safeAreaInsets.bottom,window.safeAreaInsets.left,window.safeAreaInsets.right);
    } else {
        // Fallback on earlier versions
    }


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
    
    for (int i=0; i<functionName.count; i++) {
        NSString *title = functionName[i];
        if (!title||title.length<1) { break; }
        UIButton *button = [UIButton title:functionName[i] titColorN:color_white font:font_s(15) bgColor:color_theme];
        AddTarget_for_button(button, clickBtn:)
        [button cornerRadius:25];
        button.tag = i+1;
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(navc_bar_h+30+(i/2)*70);
            make.width.offset(150); make.height.offset(50);
            if (i%2==0) {
                make.right.equalTo(self.view.mas_centerX).offset(-10);
            }else{
                make.left.equalTo(self.view.mas_centerX).offset(10);
            }
        }];
    }

    _testModel1 = [[TestModel alloc]init];
    _testModel1.age = @"20";
     

    
    // 保证调用频率和屏幕刷新频率一致，60FPS
//    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkTest)];
//    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

    // 专门用来做代理，消息转发
//    NSProxy * proxy;
    
    
    
   
    
    [self baseView];
    
    
}


-(TestView*)baseView{
    if (!_baseView) {
        _baseView = [[TestView alloc]init];
        _baseView.backgroundColor = color_random;
        _baseView.frame = CGRectMake(100, 400, 260, 160);
        [self.view addSubview:_baseView];
//        _baseView.translatesAutoresizingMaskIntoConstraints = NO;
//
//        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:_baseView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200];
//        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:_baseView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
//        [_baseView addConstraints:@[width,height]];
//
//        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:_baseView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
//
//        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:_baseView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
//
//        [self.view addConstraints:@[centerX,centerY]];
                
        
        // VFL抽象语言编写 LayoutConstraint
//        [NSLayoutConstraint constraintsWithVisualFormat:<#(nonnull NSString *)#> options:<#(NSLayoutFormatOptions)#> metrics:<#(nullable NSDictionary<NSString *,id> *)#> views:<#(nonnull NSDictionary<NSString *,id> *)#>]
        
        
//        [_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view.mas_centerY).offset(0);
//            make.centerX.equalTo(self.view.mas_centerX);
//            make.width.mas_equalTo(320);
//            make.height.offset(220);
//        }];
    }
    return _baseView;
}


 
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"object: %@ ",object_getClass(_testModel1));
    NSLog(@"object: %@ \n%@",object_getClass(object),change);
}



-(void)clickBtn:(UIButton*)btn{
    switch (btn.tag) {
        case 1:{
            
            NSObject *objc1 = [[NSObject alloc]init];
            NSObject *objc2 = [[NSObject alloc]init];

            NSLog(@"%zu %zu",malloc_size((__bridge const void *)(objc1)),class_getInstanceSize([objc1 class]));
            NSLog(@"%zu %zu",malloc_size((__bridge const void *)(objc2)),class_getInstanceSize([objc2 class]));

            NSLog(@"objc1 : %p",objc1);
            NSLog(@"objc2 : %p",objc2);
            
            printf("\na1 : %p\na2 : %p\na3 : %p\na4 : %p\na5 : %p\n",&_a1,&_a2,&a3,&a4,&a5);
            
            int a6 = 60;
            int a7;
            printf("\na6 : %p\na7 : %p\n",&a6,&a7);

            
        } break;
            
            
        case 2: //{
            
//            SCNetworkReachabilityRef networkReachability;
//            struct sockaddr_in address;
//
//            NSLog(@"%ld",sizeof(address));
//
//            bzero(&address, sizeof(address));
//            address.sin_len = sizeof(address);
//            address.sin_family = AF_INET;
//
//            const struct sockaddr *addr = (const struct sockaddr *)&address;
//
//
//            SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault,addr);
//
//
//
//            NSLog(@"hahah");
            
//            [_baseView removeFromSuperview];
//
//            NSLog(@"%@",_baseView);
//
//        } break;
            
            
        case 3:{
            
//            [self.view addSubview:_baseView];
            NSLog(@"case3也执行了");
            
   
//            int a = 10;
//            int b = 20;
//            int c = 30;
//
//            int d = a + b;
//
//            NSLog(@"a=%d b=%d c=%d d=%d",a,b,c,d);
//
//            int *p = &a;
//
//            memset(p,0,4);

            
            
        } break;
            
                       
        case 4:{
            
            [TestModel mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
                
            }];
            
        }
            
        default:
            break;
    }
}


-(void)recursionFunc{
    static int a = 0;
    NSLog(@"调用次数: %d",++a);
    [self recursionFunc];
}




-(void)funcTestBlock{

//    NSLog(@"11111111");
    
//    self.testBlock = ^(NSString *string) {
////        NSLog(@"33333333");
//        NSLog(@"%d",self.isSelect);
//
//    };
//
//    NSLog(@"22222222");
//    self.testBlock(@"哈哈哈，传了一个字符串");
//    NSLog(@"%@",object_getClass(self.testBlock));
    
    
}




// 动态修改logo
-(void)dynamicSetAlternateIconName{
    if (@available(iOS 10.3, *)) {
        if ([UIApplication sharedApplication].supportsAlternateIcons) {
            [[UIApplication sharedApplication] setAlternateIconName:@"icon1" completionHandler:^(NSError * _Nullable error) {
                NSLog(@"%@",error);
            }];
        }
    } else {
        
    }
}
 
//-(void)testTryCatch{
//    NSArray *ary = @[@"1",@"2",@"3"];
//    NSLog(@"%@",ary[2]);
//    [self testTryCatch2];
//}
//
-(void)testTryCatch2{
    NSArray *ary = @[@"1",@"2",@"3"];
    NSLog(@"%@",ary[4]);
}





-(void)linkTest{
    NSLog(@"%s",__func__);
}




 



//获得所有变量
- (NSArray *)getAllIvar:(id)object{
    NSMutableArray *array = [NSMutableArray array];
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList([object class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *keyChar = ivar_getName(ivar);
        NSString *keyStr = [NSString stringWithCString:keyChar encoding:NSUTF8StringEncoding];
        @try {
            id valueStr = [object valueForKey:keyStr];
            NSDictionary *dic = nil;
            if (valueStr) {
                dic = @{keyStr : valueStr};
            } else {
                dic = @{keyStr : @"值为nil"};
            }
            [array addObject:dic];
        }
        @catch (NSException *exception) {}
    }
    return [array copy];
}
 
//获得所有属性
- (NSArray *)getAllProperty:(id)object{
    NSMutableArray *array = [NSMutableArray array];
    
    unsigned int count;
    objc_property_t *propertys = class_copyPropertyList([object class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertys[i];
        const char *nameChar = property_getName(property);
        NSString *nameStr = [NSString stringWithCString:nameChar encoding:NSUTF8StringEncoding];
        [array addObject:nameStr];
    }
    return [array copy];

}






 
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    
    
    
    
}





@end
