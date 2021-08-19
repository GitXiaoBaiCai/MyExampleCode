//
//  Block_VC.m
//  MyCode
//
//  Created by New_iMac on 2021/7/27.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "Block_VC.h"

@interface Block_VC ()

typedef void(^TestBlock)(NSString*explain);
@property(nonatomic, copy) TestBlock testBlock;
@property(nonatomic, strong) Block_Model *bModel;

@property(nonatomic, copy) NSString *testStr1;
@property(nonatomic, assign) int testInt1;

@end

@implementation Block_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTestBtn];
    
    
    _testStr1 = @"测试字符串1";
    _testInt1 = 10;
 
}


-(Block_Model*)bModel{
    if (!_bModel) {
        _bModel = [[Block_Model alloc]init];
        _bModel.modelName = @"全局变量";
    }
    return _bModel;
}


-(void)addTestBtn{
    
    NSArray *functionName = @[@"局部变量调用",
                              @"全局变量调用",
                              @"加号方法调用",
                              @"加号方法传参",
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
    
}


-(void)clickBtn:(UIButton*)btn{
    switch (btn.tag) {
        case 1:{
            Block_Model *model = [[Block_Model alloc]init];
            model.modelName = @"局部变量";
//            [model clickSelect:^(NSInteger selectTag, NSString *title) {
//                NSLog(@"1->title: %@",title);
//                self.testStr1 = @"哈哈哈";
//                self.testInt1 = 20;
//            }];
//
//            NSLog(@"testStr1: %@  testInt1:%d",self.testStr1,self.testInt1);

            model.selectTagBlock = ^(NSInteger selectTag, NSString *title) {
                NSLog(@"2->title: %@",title);
                self.testStr1 = @"呵呵呵呵";
                self.testInt1 = 32;
            };
            
            NSLog(@"testStr1: %@  testInt1: %d",self.testStr1,self.testInt1);

        } break;
            
        case 2:{
            
            @autoreleasepool {}
            __weak __typeof__(self) self_weak = self;
            
//            weakify(self)
//            @weakify(self)
//            __weak typeof(self) weakSelf = self;
            [self.bModel clickSelect:^(NSInteger selectTag, NSString *title) {
//                __strong typeof(weakSelf) stongSelf = weakSelf;
                @strongify(self)
                NSLog(@"1->title: %@",title);
                self.testStr1 = @"呵呵呵呵";
                self.testInt1 = 32;
            }];
            NSLog(@"全局：testStr1: %@  testInt1: %d",self.testStr1,self.testInt1);


            
//            _bModel.selectTagBlock = ^(NSInteger selectTag, NSString *title) {
//
//            };
            
        } break;
            
        case 3:{
            [Block_Model requestAndSuccess:^(NSInteger code, id  _Nonnull data) {
                NSLog(@"self: %p  %s",self,__func__);
                self.testStr1 = @"哈哈哈";
                self.testInt1 = 20;
            } error:^(NSInteger code, NSString * _Nonnull errorMsg) {
                NSLog(@"self: %p  %s",self,__func__);
                self.testStr1 = @"执行的错误";
                self.testInt1 = 20;
            }];
            
            NSLog(@"testStr1: %@  testInt1: %d",self.testStr1,self.testInt1);

        } break;
            
            
        case 4:{
            
            [Block_Model requestStr:self.testStr1 andSuccess:^(NSInteger code, id  _Nonnull data) {
                NSLog(@"使用了self参数+1->title: %@",data);
                self.testStr1 = @"哈哈哈";
                self.testInt1 = 20;
                
                
                
                
            } error:^(NSInteger code, NSString * _Nonnull errorMsg) {
                NSLog(@"使用了self参数+2->title: %@",errorMsg);
                self.testStr1 = @"执行的错误";
                self.testInt1 = 20;
            }];

            NSLog(@"testStr1: %@  testInt1: %d",self.testStr1,self.testInt1);

        } break;
            
            
        default:
            break;
    }
    
    NSLog(@"---------------------------------------------");
}


-(void)dealloc{
    NSLog(@"%s",__func__);
}

@end












@implementation Block_Model

-(instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"%p 初始化",self);
    }
    return self;
}

+(void)requestAndSuccess:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock{
    NSLog(@"SuccessBlock : BlockType: %p",object_getClass([successBlock class]));
    NSLog(@"ErrorBlock : BlockType: %p",object_getClass([errorBlock class]));

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"self: %p  %s",self,__func__);
        if (successBlock&&errorBlock) {
            int rand = arc4random()%20+10;
            if (rand%2) {
                successBlock(200,@"成功成功。。。");
            }else{
                errorBlock(400,@"失败失败。。。");
            }
        }
    });
}


+(void)requestStr:(NSString*)name andSuccess:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock{
    NSLog(@"SuccessBlock : BlockType: %p",object_getClass([successBlock class]));
    NSLog(@"ErrorBlock : BlockType: %p",object_getClass([errorBlock class]));

    int rand = arc4random()%20+10;
    if (rand%2) {
        successBlock(200,FORMATSTR(@"%@ 成功成功。。。",name));
    }else{
        errorBlock(400,FORMATSTR(@"%@ 失败失败。。。",name));
    }
}
 

-(void)clickSelect:(SelectTagBlock)tagBlock{
    self.selectTagBlock = tagBlock;
   
    if (self.selectTagBlock) {
        self.selectTagBlock(2,self.modelName);
    }
    
    NSLog(@"BlockType: %p",object_getClass([tagBlock class]));
    
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}



@end
