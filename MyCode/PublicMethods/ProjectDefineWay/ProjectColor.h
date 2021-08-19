//
//  ProjectColor.h
//  MyCode
//
//  Created by New_iMac on 2021/2/1.
//  Copyright © 2021 mycode. All rights reserved.
//

#import <UIKit/UIKit.h>


// rgba颜色
#define color_rgba(r,g,b,a)  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define color_rgb(r,g,b)     [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]


#define black_0   color_rgba(0.f,0.f,0.f,1)        // 黑色
#define black_1   color_rgba(51.f,51.f,51.f,1)     // 字体最黑色
#define black_2   color_rgba(102.f,102.f,102.f,1)  // 字体中黑色
#define black_3   color_rgba(153.f,153.f,153.f,1)  // 字体浅黑色
#define black_4   color_rgba(204.f,204.f,204.f,1)  // 字体淡黑色
#define black_5   color_rgba(236.f,236.f,236.f,1)  // 接近表格灰

#define color_white [UIColor whiteColor]       // 白色
#define color_black [UIColor blackColor]       // 黑色
#define color_clear [UIColor clearColor]       // 透明
#define color_blue  [UIColor blueColor]        // 系统蓝色
#define color_green [UIColor greenColor]       // 系统绿色
#define color_red   [UIColor redColor]         // 系统红色


#define color_group  color_rgba(246.f,246.f,246.f,1)  // 表格背景灰

#define color_theme  color_rgb(88, 86, 213)          // 主题色
#define color_random color_rgba(arc4random()%255, arc4random()%255, arc4random()%255, 1) // 随机产生一个颜色

#define color_hex(hex_str)  [ProjectColor colorWithHexString:hex_str] // 16进制颜色

NS_ASSUME_NONNULL_BEGIN

@interface ProjectColor : UIColor
//+(UIColor *)colorWithHexString:(NSString *)hexColor alpha:(float)opacity;
+(UIColor *)colorWithHexString:(NSString *)hexColor;
@end

NS_ASSUME_NONNULL_END
