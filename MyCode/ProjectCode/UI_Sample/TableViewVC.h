//
//  TableViewVC.h
//  MyCode
//
//  Created by New_iMac on 2021/2/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "Base_ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewVC : Base_ViewController

@end



@interface CustomTabCell : UITableViewCell

@end


@interface TabCellModel : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, assign) BOOL isAnimation;
@end



NS_ASSUME_NONNULL_END
