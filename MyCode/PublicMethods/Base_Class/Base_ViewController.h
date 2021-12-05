//
//  Base_ViewController.h
//  MySlhb
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Base_ViewController : UIViewController

@property(nonatomic,strong) UIImageView * barView;
@property(nonatomic,strong) UILabel * barTitLab;
@property(nonatomic,strong) UIButton * goBackBtn;
@property(nonatomic,strong) UIImageView * barLinesImgV;
//+(void)pushSelfViewController:(id __nullable)parameter;


@property(nonatomic,strong) id publicParameter;


@end

NS_ASSUME_NONNULL_END
