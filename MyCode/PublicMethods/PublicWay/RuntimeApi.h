//
//  RuntimeApi.h
//  MyCode
//
//  Created by New_iMac on 2021/11/29.
//  Copyright © 2021 mycode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeApi : NSObject

+(NSMutableArray*)classIvars:(Class)cls;
+(NSMutableArray*)classPropertys:(Class)cls;
+(NSMutableArray*)classMethods:(Class)cls;

@end

NS_ASSUME_NONNULL_END
