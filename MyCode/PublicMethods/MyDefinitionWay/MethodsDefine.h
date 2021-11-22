//
//  MethodsDefine.h
//  MySlhb
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 chgyl. All rights reserved.
//

#ifndef MethodsDefine_h
#define MethodsDefine_h


// 打印输出
#define C_LOG(format, ...)  printf("\n%s\n",[[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
//#define C_LOG(format, ...)  printf("\n%s\n\n%s\n\n",[date_time_current(@"yyyy-MM-dd HH:mm:ss:SSS") UTF8String],[[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#define log_point_func   NSLog(@"=> self=%p  _cmd=%p  %s\n",&self,&_cmd,__func__);


// 屏幕宽高
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

#define img_str(imgname)   [UIImage imageNamed:imgname]

// 获取控件宽高XY坐标
#define frame_x(view)  view.frame.origin.x
#define frame_y(view)  view.frame.origin.y
#define frame_h(view)  view.frame.size.height
#define frame_w(view)  view.frame.size.width
#define right_x(view)  view.frame.origin.x + view.frame.size.width
#define bottom_y(view) view.frame.origin.y + view.frame.size.height


// 判断iPhone X 系列
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH (MAX(ScreenW, ScreenH))
#define IS_IPHONE_X (IS_IPHONE && (SCREEN_MAX_LENGTH==812||SCREEN_MAX_LENGTH==896))

// 当前系统版本
#define system_version [[UIDevice currentDevice].systemVersion floatValue]

#define device_uuid   FORMATSTR(@"%@",[[UIDevice currentDevice].identifierForVendor UUIDString])
#define device_model  [MethodsClassObjc getDeviceType]
#define device_time   FORMATSTR(@"%.0f",[[NSDate date] timeIntervalSince1970]*1000)
#define app_version   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]




// 字符串拼接
#define FORMATSTR(...) [NSString stringWithFormat:__VA_ARGS__]

// 将一个值转化为字符串
#define STR(str) [NSString stringWithFormat:@"%@",str]

// 不知道第一相应者的情况下取消第一相应
#define ResignFirstResponder \
[[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)to:nil from:nil forEvent:nil];


/**
 计算富文本字符串的宽高
 
 @param string 原字符串
 @param Kuan 最大宽度
 @param attributed 属性字典
 @return rect
 */
#define AttributedStringRect(string,Kuan,attributed) \
[string boundingRectWithSize:CGSizeMake(Kuan, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributed context:nil]

/**
 *  计算字符串的高度(多行)
 *  @param string   输入要计算的字符串
 *  @param Kuan     输入文字需要的宽度
 *  @param FontSize 输入字体大小
 *  @return         返回结果CGRect类型
 */
#define StringRect(string,Kuan,FontSize) \
[string boundingRectWithSize:CGSizeMake(Kuan, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[[NSDictionary alloc] initWithObjectsAndKeys:FontSize,NSFontAttributeName,nil] context:nil]

/**
 *  计算字符串的长度或高度(单行)
 *  @param string   输入要计算的字符串
 *  @param FontSize 字体大小
 *  @return          返回结果CGSize类型
 */
#define StringSize(string,FontSize) \
[string sizeWithAttributes:@{NSFontAttributeName:FontSize}]





#pragma mark //************* 方法宏 *************//


// 提示框(类似安卓吐司提示)
#define show_toast_msg(msg)  [MethodsClassObjc showMessage:msg];

// MD5加密，字符串
#define md5_str(str)    [MethodsClassObjc md5encrypting:str]

// 去掉各种空值：<null> nil 等
#define null_str(_str)  [MethodsClassObjc replaceEmptyStr:_str]
#define null_dic(_dic)  [MethodsClassObjc dicNull:_dic]
#define null_ary(_ary)  [MethodsClassObjc aryNull:_ary]


// NSUserDefaults存值
#define ns_user_defaults_save(value,Key)  [MethodsClassObjc saveDataForUesrdefaults:value andKey:Key];
#define ns_user_defaults_delete(Key)      [MethodsClassObjc removeDataForUesrdefaults:Key];
#define ns_user_defaults_take(Key)        [MethodsClassObjc takeDataForUesrdefaults:Key]

// 四舍五入 参数n_num要处理数字  n_type：0四舍五入 1只舍不入 2只入不舍   n_point:小数点位数
#define rounded_num(n_num,n_type,n_point) [MethodsClassObjc notRounding:n_num type:n_type afterPt:n_point]

// 将字符串转为二维码: 参数0:字符串 1:大小 2:中心图片
#define Qr_code_img(data_str,img_wh,center_img) [MethodsClassObjc changeImageWithStr:data_str whi:img_wh centerImg:center_img]

// 将视图转为图片
#define img_by_view(now_view)  [MethodsClassObjc viewConversionImage:now_view]

// 图片高斯模糊(图片和模糊系数0~100,越大越模糊)
#define img_blur(blur_img,blur_num)  [MethodsClassObjc boxblurImage:blur_img withBlurNumber:blur_num];


#pragma mark ===>>> 正则判断
#define judge_two_point_num @"^([0-9][0-9]*)+(.[1-9]{0,2})?$"  // 输入两位有效数字
#define judge_phone_number  @"^1[0-9][0-9]\\d{8}$" // 判断手机号
#define judge_num_digital   @"^[0-9]*$"            // 只允许全数字
#define judge__strAZ_az_09  @"^[A-Za-z0-9]+$"      // 只允许数字和字母
// 正则判断 ： 参数1：公式  参数2：
#define regular_judge(formula,string) [MethodsClassObjc judgeSelectionExpression:formula content:string]


#pragma mark ===>>> 时间有关
/*
 年
 yy: 年的后面2位数字
 yyyy:显示完整的年
 
 月
 M：显示成1~12，1位数或2位数
 MM：显示成01~12，不足2位数会补0
 MMM：英文月份的缩写，例如：Jan
 MMMM：英文月份完整显示，例如：January
 
 日
 d：显示成1~31，1位数或2位数
 dd：显示成01~31，不足2位数会补0
 
 星期
 EEE：星期的英文缩写，如Sun
 EEEE：星期的英文完整显示，如，Sunday
 
 上/下午
 aa：显示AM或PM
 
 小时
 H：显示成0~23，1位数或2位数(24小时制
 HH：显示成00~23，不足2位数会补0(24小时制)
 K：显示成0~12，1位数或2位数(12小時制)
 KK：显示成0~12，不足2位数会补0(12小时制)

 分钟：
 m：显示0~59，1位数或2位数
 mm：显示00~59，不足2位数会补0

 秒：
 s：显示0~59，1位数或2位数
 ss：显示00~59，不足2位数会补0
 
 毫秒
 S： 毫秒的显示

 */

// 将时间戳转为时间字符串 str_stamp:时间戳 str_format:时间格式
#define date_time_stamp(str_stamp,str_format) [MethodsClassObjc timeStamp:str_stamp timeFormat:str_format]
// 获取当前时间 str_format:时间格式
#define date_time_current(str_format)         [MethodsClassObjc getNowTimeByFormat:str_format]
// 将NSDate转为字符串
#define date_str_by_date(date_t,str_format)   [MethodsClassObjc dateStamp:date_t timeFormat:str_format]




// block弱引用
#define weakify(var) \
autoreleasepool {} \
__weak __typeof__(var) var ## _weak = var;

#define strongify(var) \
autoreleasepool {} \
__strong __typeof__(var) var = var ## _weak;




#endif /* MethodsDefine_h */

































