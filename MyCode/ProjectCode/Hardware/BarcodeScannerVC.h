//
//  BarcodeScannerVC.h
//  MyCode
//
//  Created by 陈剑 on 2022/4/19.
//  Copyright © 2022 mycode. All rights reserved.
//

#import "Base_ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BarcodeScannerVC : Base_ViewController


typedef void(^QrResultBlock)(NSString *qrString);

@property(nonatomic, copy) QrResultBlock qrResultBlock;


@end

NS_ASSUME_NONNULL_END
