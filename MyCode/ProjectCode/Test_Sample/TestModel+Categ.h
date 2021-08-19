//
//  TestModel+Categ.h
//  MyCode
//
//  Created by New_iMac on 2021/3/15.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "TestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestModel (Categ)


// 给类别添加属性（不能直接添加，可以间接添加，通过runtime的api添加关联对象，实现）
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *age;

@end

NS_ASSUME_NONNULL_END
