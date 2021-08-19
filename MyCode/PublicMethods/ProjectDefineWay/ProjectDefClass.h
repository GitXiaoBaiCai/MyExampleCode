//
//  ProjectDefClass.h
//  MySlhb
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectDefClass : NSObject

+(float)screen_w_font_bili;
+(float)screen_w_size_bili;

+(UIViewController*)huoquCurrentTopVC;
+(UINavigationController*)huoquCurrentSltNavc;

// MMKV存值取值
+(id)mmkv_take_data:(NSString*)keyName class:(Class)classN;
+(void)mmkv_save_data:(id)data key:(NSString*)keyName;
+(void)mmkv_delete_data:(NSString*)keyName;
+(void)mmkv_delete_all_dada;


+(NSString*)parameterSignStr:(NSDictionary*)pdic;


+(NSString*)jsonStrByDictionary:(NSDictionary*)dic;
+(NSDictionary*)dictionaryByJsonStr:(id)json;


+(void)playSound:(NSString*)name ofType:(NSString*)type whetherAlert:(BOOL)alert;

@end

NS_ASSUME_NONNULL_END
