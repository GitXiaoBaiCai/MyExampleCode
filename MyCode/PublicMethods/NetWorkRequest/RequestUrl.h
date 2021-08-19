//
//  RequestUrl.h
//  MySlhb
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 chgyl. All rights reserved.
//

#ifndef RequestUrl_h
#define RequestUrl_h


// 默认域名
#define default_dns_mian     @"http://hb.cooyum.com"              // 测试服主域名
#define default_dns_socket   @"ws://47.106.75.191:8282"           // socket域名


// 动态域名(用默认域名获取)
#define dynamic_dns_mian       [NetRequest get_local_dns_by_type:0]  // 主域名
#define dynamic_dns_socket     [NetRequest get_local_dns_by_type:1]  // socket域名

// 拼接域名，方便使用
#define fm_m(url)     FORMATSTR(@"%@/%@",dynamic_dns_mian,url)
#define fm_s(url)     FORMATSTR(@"%@/%@",dynamic_dns_socket,url)



//**********  *********  **********  *********   分割线   *********  *********  *********  *********//


// url_p 代表用post请求  url_g 代表用get请求
#pragma mark //***************   接口地址拼接   ***************//



#endif /* RequestUrl_h */
