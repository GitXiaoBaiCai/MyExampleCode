//
//  MultipeerConnectivityVC.h
//  MyCode
//
//  Created by 陈剑 on 2022/4/15.
//  Copyright © 2022 mycode. All rights reserved.
//

#import "Base_ViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface MultipeerConnectivityVC : Base_ViewController

@end



@class MCListModel;
@interface MCListCell : UITableViewCell

@property(nonatomic, strong) UILabel *displyNameLab;
@property(nonatomic, strong) UILabel *advertiserLab;
@property(nonatomic, strong) UIButton *contentBtn;
@property(nonatomic, strong) UIButton *cancleBtn;
@property(nonatomic, strong) MCListModel *mdoel;

@end



@interface MCListModel : NSObject

@property(nonatomic, strong) MCPeerID *displyPeerID;
@property(nonatomic, strong) NSDictionary *advertiserDic;
@property(nonatomic, strong) MCSession *session;

-(instancetype)initWithPeerID:(MCPeerID*)peerID advertiser:(NSDictionary*)advertiser; //session:(MCSession*)session;

@end



NS_ASSUME_NONNULL_END
