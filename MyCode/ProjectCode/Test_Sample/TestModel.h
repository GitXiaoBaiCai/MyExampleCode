//
//  TestModel.h
//  MyCode
//
//  Created by New_iMac on 2021/3/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "Base_Object.h"

NS_ASSUME_NONNULL_BEGIN

@class ChainModel;

extern int a4;
@interface TestModel : Base_Object


typedef void (^testBlock)(int a,int c) ;



-(TestModel*)shouldChangeValues:(void(^)(TestModel*model))block;

-(TestModel*(^)(NSString *))title;
-(TestModel*(^)(NSString *))subTitle;

-(void)setTitle:(NSString*)title;
-(void)setSubTitle:(NSString*)subTitle;

@property(nonatomic,copy) NSString *age;
@property(nonatomic,copy) NSString *height;
@property(nonatomic,assign) NSInteger white;


@end




//@interface NSKVONotifying_TestModel : TestModel
//
//@end





@interface ChainModel : Base_Object

@end






NS_ASSUME_NONNULL_END
