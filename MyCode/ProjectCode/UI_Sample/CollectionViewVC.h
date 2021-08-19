//
//  CollectionViewVC.h
//  MyCode
//
//  Created by New_iMac on 2021/2/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "Base_ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewVC : Base_ViewController

@end


@interface ButtonCltCell : UICollectionViewCell
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UIImageView *headImgView;
@property(nonatomic,assign) BOOL isCenter;
@end



NS_ASSUME_NONNULL_END
