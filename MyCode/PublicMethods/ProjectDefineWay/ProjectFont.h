//
//  ProjectFont.h
//  MyCode
//
//  Created by New_iMac on 2021/2/1.
//  Copyright © 2021 mycode. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
        UltraLight  - 超细字体
        Thin        - 纤细字体
        Light       - 亮字体
        Regular     - 常规字体
        Medium      - 介于Regular和Semibold之间
        Semibold    - 半粗字体
        Bold        - 加粗字体
        Heavy       - 介于Bold和Black之间
        Black       - 最粗字体
*/

#define fontW_uLight(num)      [UIFont systemFontOfSize:num*font_scale weight:UIFontWeightUltraLight]
#define fontW_thin(num)        [UIFont systemFontOfSize:num*font_scale weight:UIFontWeightThin]
#define fontW_light(num)       [UIFont systemFontOfSize:num*font_scale weight:UIFontWeightLight]
#define fontW_regular(num)     [UIFont systemFontOfSize:num*font_scale weight:UIFontWeightRegular]
#define fontW_medium(num)      [UIFont systemFontOfSize:num*font_scale weight:UIFontWeightMedium]
#define fontW_semibold(num)    [UIFont systemFontOfSize:num*font_scale weight:UIFontWeightSemibold]
#define fontW_bold(num)        [UIFont systemFontOfSize:num*font_scale weight:UIFontWeightBold]
#define fontW_heavy(num)       [UIFont systemFontOfSize:num*font_scale weight:UIFontWeightHeavy]
#define fontW_black(num)       [UIFont systemFontOfSize:num*font_scale weight:UIFontWeightBlack]


#define font_s(num)     [UIFont systemFontOfSize:num*font_scale]
#define font_b(num)     [UIFont boldSystemFontOfSize:num*font_scale]
#define font_ns(fn,fs)  [UIFont fontWithName:fn size:fs*font_scale]  // 字体名和字体大小


NS_ASSUME_NONNULL_BEGIN


@interface ProjectFont : UIFont

@end

NS_ASSUME_NONNULL_END

