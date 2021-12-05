//
//  RuntimeApi.m
//  MyCode
//
//  Created by New_iMac on 2021/11/29.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "RuntimeApi.h"

@implementation RuntimeApi


/// 遍历所有实例变量
/// @param cls  class类名
+(NSMutableArray*)classIvars:(Class)cls {
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([cls class], &count);
    NSMutableArray *listAry = [NSMutableArray array];
    for (int a=0; a<count; a++) {
        Ivar ivar = ivarList[a];
        [listAry addObject:FORMATSTR(@"ivar-name: %s", ivar_getName(ivar))];
//        [listAry addObject:FORMATSTR(@"ivar-name: %s   type-encoding: %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar))];
    }
    free(ivarList);
    return listAry;
}


/// 遍历一个类的所有属性
/// @param cls  class类名
+(NSMutableArray*)classPropertys:(Class)cls {
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList(cls, &count);
    NSMutableArray *listAry = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        [listAry addObject:FORMATSTR(@"property-name: %s", property_getName(property))];
    }
    free(propertyList);
    return listAry;
}


/// 获取一个类的所有方法
/// @param cls   class类名
+(NSMutableArray*)classMethods:(Class)cls {
    unsigned int count;
    Method *methodList = class_copyMethodList(cls, &count);
    NSMutableArray *listAry = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString *methodName = NSStringFromSelector(method_getName(method));
        [listAry addObject:methodName];
    }
    free(methodList);
    return listAry;
}

@end
