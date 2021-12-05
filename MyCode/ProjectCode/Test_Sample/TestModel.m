//
//  TestModel.m
//  MyCode
//
//  Created by New_iMac on 2021/3/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

-(TestModel*)shouldChangeValues:(void (^)(TestModel * _Nonnull))block{
    TestModel * model = [[TestModel alloc]init];
    block(model);
    return model;
}

-(TestModel*(^)(NSString*))title{
    return ^id(NSString *title){
        self.title = title;
        return self;
    };
}

-(TestModel*(^)(NSString*))subTitle{
    return ^id(NSString*subTitle){
        self.subTitle = subTitle;
        return self;
    };
}


-(void)setTitle:(NSString*)title{
//    C_LOG(@"标题：%@",title)
}

-(void)setSubTitle:(NSString *)subTitle{
//    C_LOG(@"副标题：%@",subTitle)
    
//    @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
                                 userInfo:nil];
    
    
}


-(void)setAge:(NSString *)age{
    _age = age;
//    C_LOG(@"执行了setAge：%@",age)
}
 
+(void)load{

}
 

@end


//@implementation NSKVONotifying_TestModel
//
//-(instancetype)init{
//    self = [super init];
//    if (self) {
//
//    }
//    return self;
//}
//
//@end


@implementation ChainModel

-(void)dealloc{
    NSLog(@"%s",__func__);
}

@end


