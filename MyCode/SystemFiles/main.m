//
//  main.m
//  MyCode
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 mycode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/runtime.h>

int a = 10;
int b;

NSObject *objc3;
NSObject *objc4;



extern void _objc_autoreleasePoolPrint(void);
 

int main(int argc, char * argv[]) {

//    char *env = getenv("DYLD_INSERT_LIBRARIES");
    
    
    @autoreleasepool {
        NSLog(@"程序开始运行");
        // oc代码中的self也是局部变量
        // 局部变量默认前面带有auto,离开作用域后会自动销毁
//        auto int age = 10;
//        static int height = 10;
        // Global：只要没有访问auto变量
        
        // 加了static的局部变量，跟全局变量放在一个区域
        
        /*
        objc4 = [[NSObject alloc]init];
        
        int c = 10;
        int d = 20;
        
        NSNumber *num1 = @(100);
        NSNumber *num2 = [NSNumber numberWithUnsignedLongLong:99999999999];

        NSString *str1 = @"1000";
        NSString *str2 = @"都是中文都是中文";
        
        NSObject *objc1 = [[NSObject alloc]init];
        NSObject *objc2 = [[NSObject alloc]init];
         
        printf("\na = %p\nb = %p\nc = %p\nd = %p\nnum1 = %p\nnum2 = %p\nstr1 = %p\nstr2 = %p\nobjc1 = %p\nobjc2 = %p\nobjc3 = %p\nobjc4 = %p\n",&a,&b,&c,&d,num1,num2,str1,str2,objc1,objc2,objc3,objc4);
        */
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));

    }
}
























/**
 
 0000 1010 . 0110 0100 . 0000 0001 . 0000 1110
&1111 1111 . 1111 1111 . 0000 0000 . 0000 0000
 0000 1010 . 0110 0100 . 0000 0000 . 0000 0000
  
 */


// 研究ios中内存布局









 

// 生成C++代码(生成的代码并非最终编译时生成的)  // 加 -fobjc-arc -fobjc-runtime-ios-9.0  是为了防止代码里含有__weak时编译报错
// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fobjc-runtime=ios-9.0 main.m




/*
 
 // 对象分为实例对象和类对象元类对象
 
 // 实例对象（对象里面保存的是isa地址和属性值，通过isa指向类对象）
 NSObject *object1 = [[NSObject alloc]init];
 NSObject *object2 = [[NSObject alloc]init];

 // 类对象（实例对象的isa指向类对象的isa，减号方法，各种属性名等，都保存的类对象中）
 Class objectClass1 = [object1 class];
 Class objectClass2 = object_getClass(object1);
 
 // 元类对象(通过类对象的isa找到的 加号方法)
 Class objectMetaClass1 = object_getClass(objectClass1);
 Class objectMetaClass2 = object_getClass(objectClass2);

 // objc_getClass // 输入一个字符类型，返回一个存在的类名
 
 NSLog(@"实例对象：%p  %p",object1,object2)
 NSLog(@"类类对象：%p  %p",objectClass1,objectClass2)
 NSLog(@"元类对象：%p  %p",objectMetaClass1,objectMetaClass2)
 
 */



// KVO有关


/*
 
 KVO原理，利用runtime动态生成了一个子类: NSKVONotifying_MyCode(Mycode原始父类名)，
 并在类中实现了以下方法 (使用伪代码，演示执行过程，并非真实系统实现方式)
 
 假设 Mycode中有个属性 codeName(NSString类型)
 
 Mycode *code = [[MyCode alloc]init];
 code.codeName = @"我是OC代码";
 // 添加观察者，观察codeName属性值的变化
 NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld;
 [code addObserver:self forKeyPath:@"codeName" options:options context:nil];
 
 // 不需要监听时，要移除掉，不然会发生异常
 // [code removeObserver:self forKeyPath:@"codeName"];

 
 // 添加观察者后，程序就运行时就动态生成了 NSKVONotifying_MyCode 类
 重写了 setCodeName 方法
 -(void)setCodeName:(NSString*)codeName{
     // _NSSet(XXXX)ValueAndNotify（XXXX可以是其它数据类型）
     _NSSetStringValueAndNotify(); // C语言方法
 }
 void _NSSetStringValueAndNotify(){
     [self willChangeValueForKey:@"codeName"];
     [super setCodeName:codeName]; // 调用父类MyCode修改值
     [self didChangeValueForKey:@"codeName"];
 }
 
 // 在此处产生通知，告诉观察着，值已经改变
 - (void)didChangeValueForKey:(NSString *)key{
     // 通知监听器，某某属性值发生了改变
     [oberser observeValueForKeyPath:key ofObject:self change:nil context:nil];
 }
 
 // 利用 runtime 的 object_getClass() 获取到类和元类，才是真的类，
 
 NSKVONotifying_MyCode类里面除了重写了set方法外，还重写了以下方法
 
 // 返回原始父类，而不是动态生成的类，苹果重写此方法的目的是为了不暴露动态生成的类
 -(Class)class{
    return [MyCode class];
 }
 
 -(void)dealloc{
    // 此处做了一些收尾释放工作
 }
 
 -(BOOL)_isKVOA{
    return YES; // 默认YES，返回是否被添加观察者
 }
 
 
 // 直接修改属性值(不用调用set方法，使用 -> 指针访问)，不会触发KVO
 
 */



// KVC







// load、initialize方法的区别
/*
 1：调用方式
    load是根据函数地址直接调用
    initialize是通过objc_msgSend调用的
 2：调用时刻
    load是runtime加载类、分类的时候调用（只会调用一次）
    initialize是类第一次接收到消息的时候调用，每一个类只会initialize一次（父类的initialize方法可能会被调用多次）
 
 3.调用顺序
   load：
     先调用类的load，
     先编译的类，会优先调用
     调用子类的load之前，会先调用父类的load
     在调用分类的load
     先编译的分类优先调用load
   initialize
     先初始化父类
     在初始化子类（可能最终调用的是父类的initialize方法）
 */

/*
 程序内存分配（四层）
 1：程序区域 .text区    (存放编写的代码文本)
 2：数据区域 .data区    存放类里面的全局变量
 3：堆(动态分配内存)     由程序员申请释放，管理 （例如alloc出来的对象）
 4：栈（局部变量）       系统自动释放
 */


/*
-h, --help                    show this help message and exit                   显示此帮助信息并退出
 --version                    show the xcrun version                            显示xcrun版本
 -v, --verbose                show verbose logging output                       显示详细的日志输出
 --sdk <sdk name>             find the tool for the given SDK name              查找给定SDK名称的工具
 --toolchain <name>           find the tool for the given toolchain             为给定的工具链找到工具
 -l, --log                    show commands to be executed (with --run)         显示要执行的命令(使用——run)
 -f, --find                   only find and print the tool path                 只查找并打印工具路径
 -r, --run                    find and execute the tool (the default behavior)  查找并执行工具(默认行为)
 -n, --no-cache               do not use the lookup cache                       不使用查找缓存
 -k, --kill-cache             invalidate all existing cache entries             使所有现有的缓存项无效
 --show-sdk-path              show selected SDK install path                    显示选定的SDK安装路径
 --show-sdk-version           show selected SDK version                         显示选定的SDK版本
 --show-sdk-build-version     show selected SDK build version                   显示选定的SDK构建版本
 --show-sdk-platform-path     show selected SDK platform path                   显示选中的SDK平台路径
 --show-sdk-platform-version  show selected SDK platform version                显示选定的SDK平台版本
*/












