//
//  NSTimerVC.h
//  MyCode
//
//  Created by New_iMac on 2021/2/24.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "Base_ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSTimerVC : Base_ViewController

@end



// 解决timer中，target为self时，循环引用问题
@interface TimerTarget : NSProxy

@property(nonatomic,weak) id target;
+(instancetype)initNewTarget:(id)target;

@end


NS_ASSUME_NONNULL_END
