//
//  NSObjCRuntimeVC.h
//  MyCode
//
//  Created by New_iMac on 2021/2/24.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "Base_ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObjCRuntimeVC : Base_ViewController

@end



@interface RuntimeTestModel : NSObject

typedef void(^TestBlock)(NSString*name);

@property(nonatomic, strong) NSMutableArray *mutableArray;
@property(nonatomic,   copy) TestBlock testBlock;
@property(nonatomic,   copy) NSString *string;
@property(nonatomic,   copy) NSString *name;
@property(nonatomic, assign) int height;
@property(nonatomic, assign) int age;

-(int)testAge:(int)age height:(int)hi;
-(void)testPrint;

+(void)metalTestWay1:(NSString*)str;
+(void)metalTestWay2;


//-(void)subModelPrint; // 测试消息转发用的

 

@end




@interface RuntimeTestSubModel : RuntimeTestModel
-(void)subModelPrint;
@end






NS_ASSUME_NONNULL_END
