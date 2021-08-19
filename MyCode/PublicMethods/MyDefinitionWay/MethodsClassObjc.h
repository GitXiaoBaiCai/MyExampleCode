//
//  MethodsClassObjc.h
//  PeanutLK
//
//  Created by mac on 2017/3/2.
//  Copyright © 2017年 cj.All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MethodsClassObjc : NSObject

// 正则表达式判断
+(BOOL)judgeSelectionExpression:(NSString*)way content:(NSString*)content;


// 存值、删值、取值
+(void)saveDataForUesrdefaults:(id)value andKey:(NSString*)valueKey;
+(void)removeDataForUesrdefaults:(NSString*)key;
+(id)takeDataForUesrdefaults:(NSString*)key;


// 类似安卓小提示框
+(void)showMessage:(NSString *)message;


// 替换空，判空
+(NSArray*)aryNull:(id)ary;
+(NSDictionary*)dicNull:(id)dict;
+(NSString*)replaceEmptyStr:(id)str;


// MD5加密
+(NSString*)md5encrypting:(NSString*)mdStr;


// 获取设备名
+(NSString *)getDeviceType;


// 四舍五入: num:要处理的值 type: 0四舍五入 1只舍不入 2只入不舍   position:小数点位数
+(NSString*)notRounding:(id)num type:(NSInteger)type afterPt:(int)position;

// 获取时间、
+(NSString*)getNowTimeByFormat:(NSString*)format;

// 将date(日期)转为字符串
+(NSString*)dateStamp:(NSDate*)date timeFormat:(NSString*)format;

// 将时间戳转化为时间(时间长度字符串为毫秒)
+(NSString*)timeStamp:(NSString*)strTime timeFormat:(NSString*)format;


// 将字符串转化为二维码：1：字符串 2：二维码的宽高 3：二维码的中心图片
+(UIImage*)changeImageWithStr:(NSString*)str whi:(float)whi centerImg:(UIImage*)centerImg;

// 字典转json
+(NSString*)jsonStrByDictionary:(NSDictionary*)dic;

// json转字典
+(NSDictionary*)dictionaryByJsonStr:(id)json;


+(void)logAllSubviews:(UIView*)view;

// 将视图转为图片
+(UIImage*)viewConversionImage:(UIView*)view;

// 图片高斯模糊
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end




// 吐司弹窗提示类
@interface ShowMsgView : UIView
-(instancetype)initWithFrameCenter:(CGPoint)center bounds:(CGRect)rect;
@property(nonatomic,strong) UILabel * showLab;
@end














