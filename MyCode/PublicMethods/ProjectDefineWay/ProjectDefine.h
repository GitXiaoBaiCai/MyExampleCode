//
//  ProjectDefine.h
//  MySlhb
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019 chgyl. All rights reserved.
//  本页面的宏主要是方法调用

#ifndef ProjectDefine_h
#define ProjectDefine_h


#define font_scale [ProjectDefClass screen_w_font_bili] // 字体放大倍数
// ss 代表 size scale 首字母  加个 “_x” 是为了 方便全局替换
#define ss_x(num) [ProjectDefClass screen_w_size_bili]*num // 不同屏幕对于320的比例

// 给按钮添加点击事件
#define AddTarget_for_button(btn,way_name) [btn addTarget:self action:@selector(way_name) forControlEvents:(UIControlEventTouchUpInside)];


#define WeakSelf(weakSelf) __weak typeof(self) weakSelf = self;

// 导航栏的push和pop
#define navc_push(vc_name,YESORNO)  [self.navigationController pushViewController:vc_name animated:YESORNO];
#define navc_pop(YESORNO)           [self.navigationController popViewControllerAnimated:YESORNO];

#define top_navc  [ProjectDefClass huoquCurrentSltNavc]
#define top_vc    [ProjectDefClass huoquCurrentTopVC]

// MBMBProgressHUD
#define  mb_show_progress(str)        [MBProgressHUD showMessage:str]; // 正在发送请求显示
#define  mb_hidden_progress           [MBProgressHUD hideHUD];  // 隐藏
#define  mb_error_progress(errorStr)  [MBProgressHUD showError:errorStr]; // 提示错误信息
#define  mb_success_progress(sucMsg)  [MBProgressHUD showSuccess:sucMsg]; // 显示成功信息


// 腾讯的MMKV：存值、取值、删值
#define mmkv_take(t_key,class_n)  [ProjectDefClass mmkv_take_data:t_key class:class_n]
#define mmkv_save(s_data,s_key)   [ProjectDefClass mmkv_save_data:s_data key:s_key];
#define mmkv_delete(d_key)        [ProjectDefClass mmkv_delete_data:d_key];
#define mmkv_delete_all           [ProjectDefClass mmkv_delete_all_dada];
#define mmkv_default              [MMKV defaultMMKV]

// 参数加密
#define sign_parameter(dic)       [ProjectDefClass parameterSignStr:dic];



// 播放音效
#define play_sound(_name,_type,is_alert)  [ProjectDefClass playSound:_name ofType:_type whetherAlert:is_alert];

#endif /* ProjectDefine_h */
