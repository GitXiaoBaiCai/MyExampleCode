//
//  NSObjCRuntimeVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/24.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "NSObjCRuntimeVC.h"
#import <objc/runtime.h>
@interface NSObjCRuntimeVC ()

@end

@implementation NSObjCRuntimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    
}


// 测试动态添加方法
void testPrint(id self,SEL _cmd){
    NSLog(@"------>> %@  %@",self,NSStringFromSelector(_cmd));
}

// 动态创建一个类
-(void)creatClass{
    // 创建一个MJPerson类，继承于RuntimeTestModel，最后一个参数，跟内存对齐有关，默认写0，
    Class NewClass = objc_allocateClassPair([NSObject class], "NewClass", 0);
    NSLog(@"创建了一个class: %@",NewClass);

    // 给类动态添加成员变量(要放在注册类之前，已注册的类不能添加成员变量)
    // 参数1：类， 2：变量名， 3：字节数, 4：内存对齐， 5：类型编码格式
    class_addIvar(NewClass, "_age", sizeof(int), 1, @encode(int));
    class_addIvar(NewClass, "_weight", sizeof(int), 1, @encode(int));
    // 添加方法
    class_addMethod(NewClass, sel_registerName("testPrint"), (IMP)testPrint, "v@:");
    // 创建类后需要注册后才能使用
    objc_registerClassPair(NewClass);
    
    id person = [[NewClass alloc]init];
    [person setValue:@10 forKey:@"age"];
    [person setValue:@60 forKey:@"weight"];
//    [person testPrint];
    NSLog(@"age=%@ weight=%@",[person valueForKey:@"age"],[person valueForKey:@"weight"]);
    
    
    // 销毁一个类(当person实例对象存在时，或者有类继承于MJPerson时，不需要调用销毁方法)
    // objc_disposeClassPair(newClass);
 }



// 获取一个类的所有实例变量信息
-(void)printClassIvars:(Class)cls{
    
    // 遍历所有实例变量
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([cls class], &count); // copy成员变量
    for (int a=0; a<count; a++) {
        Ivar ivar = ivarList[a];
        // 获取变量名和变量类型
        NSLog(@"==>> %s %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
    free(ivarList); // C语言方法，需要手动释放
    
    // 获取和修改某个成员变量(用RuntimeTestModel测试，)
//    Ivar iver = class_getInstanceVariable([_RuntimeTestModel class], "_name");
//    NSLog(@"getIvar: %@",object_getIvar(_RuntimeTestModel, iver));
//    NSLog(@"修改前：%@",_RuntimeTestModel.name);
//    object_setIvar(_RuntimeTestModel, iver, @"myname");
//    NSLog(@"修改后：%@",_RuntimeTestModel.name);
    
}

// 获取一个类的所有属性
-(void)printPropertyNamesOfClass:(Class)cls{
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList(cls, &count);
    // 遍历所有的属性
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        NSLog(@"==>> %s",property_getName(property));
    }
    free(propertyList);
 }


// 获取类的所有方法
- (void)printMethodNamesOfClass:(Class)cls{
    unsigned int count;
    // 获得方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    // 遍历所有的方法
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        // 获得方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        NSLog(@"==>> %@",methodName);
    }
    // 释放(C语言方法，需要手动释放)
    free(methodList);
 }


// 获得所有变量
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
    free(ivars);
    return [array copy];
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









@implementation RuntimeTestModel

{
    NSString *tttttt;
}
#pragma mark ==>> oc消息机制

// 动态方法解析（类方法）
+(BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel==@selector(subModelPrint)) {
//         struct method_t{
//             SEL name;  // 函数名
//             const char *types;  // 编码
//             IMP imp;  // 指向函数的指针(函数地址)
//         }; // Method实际是个结构体
         
        // 获取其它方法
        Method method = class_getInstanceMethod(self, @selector(testPrint));
        // 动态添加方法（添加testPrint方法）
        class_addMethod(self, sel,method_getImplementation(method),method_getTypeEncoding(method));
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

// 动态方法解析（元类方法）
//+(BOOL)resolveClassMethod:(SEL)sel{
//    if (sel==@selector(runtimeAddFunc)) {
//        // 获取其它方法
//        Method method = class_getInstanceMethod(object_getClass(self), @selector(testPrint));
//        // 动态添加方法（添加testPrint方法）
//        class_addMethod(self, sel,method_getImplementation(method),method_getTypeEncoding(method));
//
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}
 
// 如果动态解析没有添加方法，就会执行消息转发

// 消息转发
// 返回值不为空，会将返回值放入消息发送 objc_msgSend(返回值，SEL)
-(id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector==@selector(subModelPrint)) {
        return [[RuntimeTestSubModel alloc]init];
        // 返回值返回后,会转发消息，相当于下方的伪代码
        // objc_msgSend([[RuntimeTestSubModel alloc]init],aSelector);
        
        // return nil; 当返回nil时，
        // 会调用 methodSignatureForSelector:(SEL)aSelector
    }
    return [super forwardingTargetForSelector:aSelector];
}
// 当上面方法返回nil时会调用 (返回方法签名)
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    // 返回方法签名（编码 testAge:height:", "i24@0:8i16i20 ）
    if (aSelector==@selector(subModelPrint)) {
        // 当此处返回nil时，会调用 doesNotRecognizeSelector
        return [NSMethodSignature signatureWithObjCTypes:"v16@0:8"];
    }
    return [super methodSignatureForSelector:aSelector];
}

// 返回方法签名后会执行(不管有没有数据都会到这)
// NSInvocation封装了一个方法调用，
// 包括：方法调用者、方法名、方法参数
// anInvocation.target;
// anInvocation.selector;
// [anInvocation getArgument:NULL atIndex:0];
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    // [anInvocation invokeWithTarget:[[RuntimeTestSubModel alloc]init]];
    // 或者
    anInvocation.target = [[RuntimeTestSubModel alloc]init];
    [anInvocation invoke];
    // 或者，可以不管传进来的方法，在这里可以任意写代码等比如，打印，修改传入值等等。。
}

// 最终报错(经典错误)，方法找不到错误
-(void)doesNotRecognizeSelector:(SEL)aSelector{
    
}


//+ (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)aSelector{
//
//}

// 方法调用分为三步
/*
 消息发送（objc_msgSend），找不到方法后会进入动态解析步骤，
 动态解析（resolveInstanceMethod或resolveClassMethod，在里面使用class_addMethod()动态添加方法）
 消息转发
 */
 

#pragma mark ==>> 父类系统方法

+(void)load{
    log_point_func
}

+(void)initialize{
    log_point_func
}


#pragma mark ==>> 元类方法

+(void)metalTestWay1:(NSString*)str{
    log_point_func
}

+(void)metalTestWay2{
    log_point_func
}


#pragma mark ==>> get、set方法



#pragma mark ==>> 类方法

-(int)testAge:(int)age height:(int)hi{
    NSLog(@"=>  age=%d  height=%d",age,hi);
    return age+hi;
}

-(void)testPrint{
    log_point_func
}

-(void)dealloc{
    log_point_func
}









@end








@implementation RuntimeTestSubModel

+(void)load{
    log_point_func
}

+(void)initialize{
    log_point_func
}

-(void)dealloc{
    log_point_func
}

-(void)subModelPrint{
    log_point_func
}


@end











