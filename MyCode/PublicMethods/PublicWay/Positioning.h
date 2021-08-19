//
//  Positioning.h
//  LocationFengZhuang
//
//  Created by mac on 2016/9/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@class AddressInfo;
@interface Positioning : UIView<CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager*ltmg;

@property(nonatomic,strong)void(^locationInfo)(AddressInfo*location);
@property(nonatomic,strong)void(^userRefused)(NSInteger state2);
@property(nonatomic,strong)void(^systemRefused)(NSInteger state6);
@property(nonatomic,strong)void(^shiBai)(NSInteger state1);

+(void)weiZhiInfo:(void(^)(AddressInfo*location))locationInfo userRefused:(void(^)(NSInteger state2))uesr systemRefused:(void(^)(NSInteger state6))system shiBai:(void(^)(NSInteger state1))error;

-(void)locationStart;
@end


@interface AddressInfo: NSObject
@property(nonatomic,copy)NSString*aiCountries;//国家
@property(nonatomic,copy)NSString*aiProvince;//省
@property(nonatomic,copy)NSString*aiCity;//城市
@property(nonatomic,copy)NSString*aiArea;//区包含县级市
@property(nonatomic,copy)NSString*aiStreet;//街道
@property(nonatomic,copy)NSString*aiAddress;//门牌号等信息
@property(nonatomic,assign)float aiLongitude;//经度
@property(nonatomic,assign)float aiLatitude;//维度
@property(nonatomic,assign)float aiAltitude;//海拔
-(instancetype)initWith:(CLPlacemark*)mark;
-(instancetype)init;
@end




