//
//  ObjcPublicWay.h
//  MySlhb
//
//  Created by mac on 2019/3/20.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObjcPublicWay : NSObject


/**
 判断相册权限是否开启

 @param topvc 未开启时会弹窗提醒用户，弹窗要展示的vc
 @param photoPermissionsType 类型回调 type:1 可以保存
 */
+(void)photoPermissionsNoOpenShowVC:(UIViewController*)topvc photoPermissionsType:(void(^)(NSInteger type))photoPermissionsType;


+(void)playSound:(NSString*)name ofType:(NSString*)type whetherAlert:(BOOL)alert playEnd:(void(^)(BOOL is_end))playEnd;


@end

NS_ASSUME_NONNULL_END
