//
//  UIView+Category.m
//  MySlhb
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import "UIView+Category.h"

//static char kAssociatedNewName;

@implementation UIView (Category)

 


//-(void)setRadius:(float)radius{
//    objc_setAssociatedObject(self, @selector(radius), radius, OBJC_ASSOCIATION_RETAIN);
//}
//
//-(float)redius{
//    return objc_getAssociatedObject(self, _cmd);
//}
// 分类添加的属性要生成get和set方法，不会产生私有变量。
// 需要调用runtime里面的方法，进行关联对象。
// 方法一：定义静态变量，采用静态变量的地址。
// 方法二：直接使用get函数的地址

// _cmd在Objective-C的方法中表示当前方法的selector，正如同self表示当前方法调用的对象实例一样。
// 相当于函数指针，设置objc_getAssociatedObject和objc_setAssociatedObject的key都为newName函数的指针。
-(NSString *)newName{
    return objc_getAssociatedObject(self, _cmd);
    //return objc_getAssociatedObject(self, &kAssociatedNewName);
}

-(void)setNewName:(NSString *)newName{
    objc_setAssociatedObject(self, @selector(newName), newName, OBJC_ASSOCIATION_RETAIN);
    //objc_setAssociatedObject(self, &kAssociatedNewName, newName, OBJC_ASSOCIATION_RETAIN);
}


-(void)setRadius:(float)radius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

-(float)radius{
    return self.layer.cornerRadius;
}


-(void)cornerRadius:(CGFloat)cornerRadius{
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

-(void)boardWidth:(CGFloat)width boardColor:(UIColor*)color cornerRadius:(CGFloat)radius{
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    self.layer.cornerRadius = radius;
}

-(void)logAllSubviews{
    
}

@end
