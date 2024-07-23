//
//  BlueToothVC.h
//  MyCode
//
//  Created by 陈剑 on 2022/4/13.
//  Copyright © 2022 mycode. All rights reserved.
//

#import "Base_ViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface BlueToothVC : Base_ViewController

@end


@interface BlueToothCell : UITableViewCell

@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *uuidLabel;

@end


@interface BlueToothModel : NSObject

@property(nonatomic, strong) CBPeripheral *peripheral;
@property(nonatomic, strong) NSMutableArray *advertisementDataAry;
@property(nonatomic, copy) NSString *addres;

-(instancetype)initWithPer:(CBPeripheral*)peripheral advertisementDic:(NSDictionary*)dic;
-(void)addNewAdvertisement:(NSDictionary*)newAdvDic;

@end




NS_ASSUME_NONNULL_END
