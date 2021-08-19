//
//  Positioning.m
//  LocationFengZhuang
//
//  Created by mac on 2016/9/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Positioning.h"

@implementation Positioning

+(void)weiZhiInfo:(void(^)(AddressInfo*location))locationInfo userRefused:(void(^)(NSInteger state2))uesr systemRefused:(void(^)(NSInteger state6))system shiBai:(void(^)(NSInteger state1))error{
    Positioning*posTing=[[Positioning alloc]initWithFrame:[UIScreen mainScreen].bounds];
    posTing.backgroundColor=[UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:posTing];
    posTing.locationInfo=locationInfo;
    posTing.userRefused=uesr;
    posTing.systemRefused=system;
    posTing.shiBai=error;
    [posTing locationStart];
    
}
-(void)locationStart{
    
    _ltmg=[[CLLocationManager alloc]init];
    if([CLLocationManager locationServicesEnabled]){
        [_ltmg setDesiredAccuracy:kCLLocationAccuracyBest];
        _ltmg.delegate = self;
        [_ltmg requestAlwaysAuthorization];
        [_ltmg requestWhenInUseAuthorization];
        [_ltmg startUpdatingLocation];
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    }else{
        [self removeFromSuperview];
        self.systemRefused(6);
    
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status!=0) {
        [self removeFromSuperview];
    }
    [manager stopUpdatingLocation];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    /*status:
      0:用户还未选择定位状态
      1:不是用户禁止,由于其他原因无法获取
      2:用户禁止获取定位
      3:用户允许获取位置，和周围，后台时也可以(IOS8.0以上)
      4:用户允许获取位置，只有在打开应用时才能使用
      5:废弃的方法
      
     NSString *name; //地名
     NSString *thoroughfare; // 街道
     NSString *subThoroughfare; // 门牌号
     NSString *locality; // 城市
     NSString *subLocality; // 区或县或地级市
     NSString *administrativeArea; //行政区域(省)
     NSString *subAdministrativeArea; // 其他行政区
     NSString *postalCode; // 邮政编码
     NSString *ISOcountryCode; //  国家代码
     NSString *country; //  国家
     NSString *inlandWater; //  河流信息
     NSString *ocean; // 海洋信息
     NSArray<NSString *> *areasOfInterest; //附近信息
     */
    
//    NSLog(@"经度:%f维度:%f",manager.location.coordinate.longitude,manager.location.coordinate.latitude);
    if (status==1) { self.shiBai(1); }
    if (status==2) { self.userRefused(2); }
    if (status==4||status==3) {
        [manager stopUpdatingLocation];
        __block Positioning*poting=self;
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:manager.location completionHandler:^(NSArray *placemarks, NSError *error) {
            if (placemarks==nil) {
                poting.shiBai(1);
                return ;
            }if (placemarks.count>0) {
                CLPlacemark*placemark=placemarks[0];
                NSLog(@"%@",placemark.areasOfInterest);
                AddressInfo*adsinfo=[[AddressInfo alloc]initWith:placemark];
                adsinfo.aiLongitude=manager.location.coordinate.longitude;
                adsinfo.aiLatitude=manager.location.coordinate.latitude;
                adsinfo.aiAltitude=manager.location.altitude;
                poting.locationInfo(adsinfo);
            }
        }];
    }
}

@end

@implementation AddressInfo
-(instancetype)initWith:(CLPlacemark*)mark{
    self=[super init];
    if (self) {
        self.aiCountries=[AddressInfo rpNL:mark.country];
        self.aiProvince= [AddressInfo rpNL:mark.administrativeArea];
        self.aiCity=[AddressInfo rpNL:mark.locality];
        self.aiArea=[AddressInfo rpNL:mark.subLocality];
        self.aiStreet=[AddressInfo rpNL:mark.thoroughfare];
        self.aiAddress=[AddressInfo rpNL:mark.subThoroughfare];
    }
    return self;
}
+(NSString*)rpNL:(NSString*)str{
    if (str==nil) {
        return @"";
    }else{
        return str;
    }
}
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.aiCountries=@"";
        self.aiCountries=@"";
        self.aiProvince=@"";
        self.aiCity=@"";
        self.aiArea=@"";
        self.aiStreet=@"";
        self.aiAddress=@"";
        self.aiLongitude=0.00;
        self.aiLatitude=0.00;
        self.aiAltitude=0.00;
    }
    return self;
}
@end








