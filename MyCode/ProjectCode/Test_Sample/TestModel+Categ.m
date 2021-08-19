//
//  TestModel+Categ.m
//  MyCode
//
//  Created by New_iMac on 2021/3/15.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "TestModel+Categ.h"

@implementation TestModel (Categ)

// 可以有多种写法（）只要是void*类型(指针类型，)
 static const void *mykey = &mykey; // 加个static，防止外部修改
// #define mykey @"mykey"
// setName的key可以用 @selector(name) ，返回时也可以用_cmd==@selector(name)==(@selector(当前方法))  //name是属性名，

/*                                       对应修饰符
 OBJC_ASSOCIATION_ASSIGN                 assign
 OBJC_ASSOCIATION_RETAIN_NONATOMIC       strong, nonatomic
 OBJC_ASSOCIATION_COPY_NONATOMIC         copy, nonatomic
 OBJC_ASSOCIATION_RETAIN                 strong, atomic
 OBJC_ASSOCIATION_COPY                   copy, atomic
 */


-(void)setName:(NSString *)name{
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString*)name{
    return objc_getAssociatedObject(self, _cmd);
}







//+(void)load{
//    C_LOG(@"TestModel(Categ)执行了load方法")
//}






@end
