//
//  DefineKeyString.h
//  MySlhb
//
//  Created by mac on 2019/3/28.
//  Copyright © 2019 chgyl. All rights reserved.
//

#ifndef DefineKeyString_h
#define DefineKeyString_h


#pragma mark //*************  宏定义，appid或key，或其它固定字符串  *************//

#define app_secret       @""

#define wx_appid         @""
#define wx_secret        @""

#define test_bundleId    @""





#pragma mark //*************  存值关键字  *************//


#pragma mark  //=== *** 字符串 *** ===//
// 字符串
#define key_str_user_token             @"key_str_user_token"               // 用户token
#define key_str_user_phone             @"key_str_user_phone"               // 用户账号
#define key_str_user_password          @"key_str_user_password"            // 用户密码
#define key_str_user_remember_pwd      @"key_str_user_remember_pwd"        // 是否记住密码

#define key_str_                    @""




#pragma mark  //=== *** 字典 *** ===//
// 字典
#define key_dic_user_info            @"key_dic_user_info"                 // 用户信息
#define key_dic_                     @""
#define key_dic_                     @""






#pragma mark  //=== *** 数组 *** ===//
// 数组
#define key_ary_                     @""
#define key_ary_                     @""





#pragma mark //*************  可直接取值使用  *************//
#pragma mark

#pragma mark /**/**/**/**/**/ 字符串
#define user_token               null_str(ns_user_defaults_take(key_str_user_token))        // token
#define user_phone               null_str(ns_user_defaults_take(key_str_user_phone))        // 账号
#define user_password            null_str(ns_user_defaults_take(key_str_user_password))     // 密码
#define user_remember_pwd        null_str(ns_user_defaults_take(key_str_user_remember_pwd)) // 记住密码的状态


#pragma mark /**/**/**/**/**/ 字典
#define  dic_user_info           mmkv_take(key_dic_user_info, [NSDictionary class])  // 用户信息
#define  dic_                mmkv_take(key_dic_, [NSDictionary class])  //
#define  dic_                mmkv_take(key_dic_, [NSDictionary class])  //









#pragma mark //*************  发送通知  *************//

#define notice_net_work_change       @"notice_net_work_change"        // 网络发生变化
#define notice_login_success         @"notice_login_success"          // 登录成功
#define notice_logout                @"notice_logout"                 // 退出登录
#define notice_room_djs_end          @"notice_room_djs_end"           // 房间倒计时结束
#define notice_task_enter_game       @"notice_task_enter_game"        // 从任务列表进入游戏列表
#define notice_bd_wechat_success     @"notice_bd_wechat_success"      // 绑定微信成功
#define notice_receive_socket_msg    @"notice_receive_socket_msg"     // 收到socket消息



#endif
