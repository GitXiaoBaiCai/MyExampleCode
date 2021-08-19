//
//  Block_VC.h
//  MyCode
//
//  Created by New_iMac on 2021/7/27.
//  Copyright © 2021 mycode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Block_VC : UIViewController

@end


@interface Block_Model : NSObject

typedef void(^SuccessBlock)(NSInteger code, id data);
typedef void(^ErrorBlock)(NSInteger code, NSString *errorMsg);
typedef void(^SelectTagBlock)(NSInteger selectTag, NSString *title);
//@property(nonatomic, copy) SuccessBlock successBlock;
//@property(nonatomic, copy) void(^ErrorBlock)(NSInteger code, NSString *errorMsg);
@property(nonatomic, copy) SelectTagBlock selectTagBlock;
@property(nonatomic, copy) NSString *modelName;

+(void)requestAndSuccess:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock;
+(void)requestStr:(NSString*)name andSuccess:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock;
-(void)clickSelect:(SelectTagBlock)tagBlock;

@end


NS_ASSUME_NONNULL_END
