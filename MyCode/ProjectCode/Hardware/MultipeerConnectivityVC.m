//
//  MultipeerConnectivityVC.m
//  MyCode
//
//  Created by 陈剑 on 2022/4/15.
//  Copyright © 2022 mycode. All rights reserved.
//

#import "MultipeerConnectivityVC.h"
#import "ShowEwmView.h"

#import "BarcodeScannerVC.h"

#define str_display_name  @"aa"
#define str_service_type  @"signin"

#define kDisplayNameKey   @"kDisplayNameKey"

@interface MultipeerConnectivityVC ()<MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) MCNearbyServiceBrowser *serviceBrowse;  // 浏览可用服务
@property(nonatomic, strong) MCNearbyServiceAdvertiser *serviceAdvertiser;  // 向外发送广播
@property(nonatomic, strong) MCSession *session; // 会话管理
@property(nonatomic, strong) MCPeerID *peerId;
@property(nonatomic, strong) NSArray *functionName;
@property(nonatomic, strong) UILabel *statesLabel;



@property(nonatomic, strong) UITextField *displyNameTextField;
@property(nonatomic, strong) UITextView *valueTextView;

@property(nonatomic, strong) TestBtnView *testBtn;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *listAry;

@property(nonatomic, strong) NSArray *qrMsgAry; // 扫描到的二维码信息，用英文分号拼接 (1:displayname 2:广播参数 3:连接秘钥)

@property(nonatomic, copy) NSString *contentKey; // 生成一个连接秘钥
@property(nonatomic, copy) NSString *ewmMsgStr; // 需要生成二维码的内容

@property(nonatomic, strong) ShowEwmView *showEwmView;

 
@end

@implementation MultipeerConnectivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _contentKey = random_str(20);
    
    _functionName = @[@"开始扫描", @"停止扫描",
                      @"发送广播", @"停止发送",];
    
    _listAry = [NSMutableArray array];
    
    [self creatInputText];
    [self testBtn];
    [self statesLabel];
    [self tableView];
    
    [self showEwmView];
}

-(void)creatInputText {
    
    UILabel *tipLab = [UILabel labText:@"请先编辑参数，一旦开始扫描或发送广播，将无法编辑" color:color_red font:font_s(13)];
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.offset(navc_bar_h+10);
    }];
    
    
    UILabel *titleLab1 = [UILabel labText:@"广播名称" color:color_blue font:font_s(14)];
    [self.view addSubview:titleLab1];
    
    _displyNameTextField = [UITextField textColor:color_code phtxt:@"请输入广播名称" font:font_s(15)];
    _displyNameTextField.backgroundColor = color_group;
    _displyNameTextField.text = random_str(10);
    [self.view addSubview:_displyNameTextField];
    
    
    UILabel *titleLab2 = [UILabel labText:@"广播参数 (json格式字符串)" color:color_blue font:font_s(14)];
    [self.view addSubview:titleLab2];
    
    _valueTextView = [[UITextView alloc]init];
    _valueTextView.font = font_s(15);
    _valueTextView.textColor = color_code;
    _valueTextView.text = FORMATSTR(@"{\"key1\":\"%@\"}", random_str(30));
    _valueTextView.backgroundColor = color_group;
    _valueTextView.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.view addSubview:_valueTextView];
    
    
    [_displyNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(40);
        make.top.offset(navc_bar_h+80);
    }];
    
    [titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.bottom.equalTo(_displyNameTextField.mas_top).offset(-10);
    }];
    
    
    [_valueTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(60);
        make.top.equalTo(_displyNameTextField.mas_bottom).offset(50);
    }];
    
    [titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.bottom.equalTo(_valueTextView.mas_top).offset(-10);
    }];
}


-(TestBtnView*)testBtn{
    if (!_testBtn) {
        _testBtn = [[TestBtnView alloc]init];
        _testBtn.btnTitleAry = _functionName;
        [self.view addSubview:_testBtn];
        [_testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_valueTextView.mas_bottom).offset(15);
            make.centerX.equalTo(self.view.mas_centerX); make.width.offset(330);
            make.height.offset(_functionName.count/2*70+(_functionName.count%2)*70);
        }];
        
        WeakSelf(weakSelf);
        _testBtn.clickBtnBlock = ^(NSInteger btnTag) { [weakSelf clickTag:btnTag]; };
    }
    return _testBtn;
}


#pragma mark --> 按钮事件
 
-(void)clickTag:(NSInteger)tag {
    
    _displyNameTextField.enabled = NO;
    _valueTextView.userInteractionEnabled = NO;
    
    _displyNameTextField.textColor = [UIColor grayColor];
    _valueTextView.textColor = [UIColor grayColor];

    _statesLabel.text = FORMATSTR(@"当前状态：%@", _functionName[tag-1]);
    
    switch (tag) {
            
        case 1: {
            
            WeakSelf(weakSelf)
            BarcodeScannerVC *scannerVC = [[BarcodeScannerVC alloc]init];
            navc_push(scannerVC, NO)
            scannerVC.qrResultBlock = ^(NSString * _Nonnull qrString) {
                weakSelf.qrMsgAry = [qrString componentsSeparatedByString:@";"];
                if (weakSelf.qrMsgAry.count==3) {
                    [weakSelf.serviceBrowse startBrowsingForPeers];
                }else{
                    _statesLabel.text = @"扫描到的二维码不正确！！！";
                }
            };
            
        
        } break;
            
        case 2: [self.serviceBrowse stopBrowsingForPeers];  break;
            
        case 3: {
            
            _ewmMsgStr = FORMATSTR(@"%@;%@;%@", _displyNameTextField.text, _valueTextView.text, _contentKey);
    
            self.showEwmView.content = _ewmMsgStr;
            self.showEwmView.show = YES;
            
            [self.serviceAdvertiser startAdvertisingPeer];
            
            
        } break;
            
        case 4: [self.serviceAdvertiser stopAdvertisingPeer]; break;
                        
        default: break;
    }
    
}


-(UILabel*)statesLabel{
    if (!_statesLabel) {
        _statesLabel = [UILabel labText:@"当前状态：无" color:color_red font:font_s(14)];
        _statesLabel.numberOfLines = 0;
        [self.view addSubview:_statesLabel];
        [_statesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_testBtn.mas_bottom);
            make.left.offset(20);
        }];
    }
    return _statesLabel;
}

-(ShowEwmView*)showEwmView{
    if (!_showEwmView) {
        _showEwmView = [[ShowEwmView alloc]init];
        [self.view addSubview:_showEwmView];
        [_showEwmView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    [self.view bringSubviewToFront:_showEwmView];
    return _showEwmView;
}


-(MCPeerID*)peerId {
    if (!_peerId) {
        _peerId = [[MCPeerID alloc]initWithDisplayName:_displyNameTextField.text.length>0 ? _displyNameTextField.text : str_display_name];
    }
    return _peerId;
}

-(MCSession*)session {
    if (!_session) {
        _session = [[MCSession alloc]initWithPeer:self.peerId securityIdentity:nil encryptionPreference:MCEncryptionRequired];
        _session.delegate = self;
    }
    return _session;
}

#pragma mark --> 浏览服务

-(MCNearbyServiceBrowser*)serviceBrowse{
    if (!_serviceBrowse) {
        _serviceBrowse = [[MCNearbyServiceBrowser alloc] initWithPeer:self.peerId serviceType: str_service_type];
        _serviceBrowse.delegate = self;
    }
    return _serviceBrowse;
}

 
- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(nullable NSDictionary<NSString *, NSString *> *)info {
    C_LOG(@"♻️foundPeer --> %@\n♻️info --> %@", peerID, info)

    MCListModel *model = [[MCListModel alloc] initWithPeerID:peerID advertiser:info];
    [self.listAry addObject:model];
    [_tableView reloadData];
    
    NSDictionary *dic = [MethodsClassObjc dictionaryByJsonStr:_qrMsgAry[1]];
    
    if ([peerID.displayName isEqualToString:_qrMsgAry[0]]&&[info isEqual:dic]) {
        [self.serviceBrowse stopBrowsingForPeers];
        [self.serviceBrowse invitePeer:peerID toSession:self.session withContext:[_qrMsgAry[2] dataUsingEncoding:NSUTF8StringEncoding] timeout:10];
    }
    
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID {
    C_LOG(@"♻️lostPeer --> %@", peerID)
    
    for (MCListModel *model in self.listAry) {
        if ([model.displyPeerID isEqual:peerID]) {
            [self.listAry removeObject:model];
            break;
        }
    }
    
    
    
}

- (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error {
    C_LOG(@"❌didNotStartBrowsingForPeers --> %@", error)
}



#pragma mark --> 发送广播

-(MCNearbyServiceAdvertiser*)serviceAdvertiser {
    if (!_serviceAdvertiser) {
        NSDictionary *dic = [MethodsClassObjc dictionaryByJsonStr:_valueTextView.text];
        _serviceAdvertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:self.peerId discoveryInfo:dic serviceType: str_service_type];
        _serviceAdvertiser.delegate = self;
    }
    return _serviceAdvertiser;
}

- (void)            advertiser:(MCNearbyServiceAdvertiser *)advertiser
  didReceiveInvitationFromPeer:(MCPeerID *)peerID
                   withContext:(nullable NSData *)context
             invitationHandler:(void (^)(BOOL accept, MCSession * __nullable session))invitationHandler {
    C_LOG(@"接收到会话邀请。。。。")
    
    NSString *str = [[NSString alloc]initWithData:context encoding:NSUTF8StringEncoding];

    if ([str isEqualToString:_contentKey]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _statesLabel.text = @"收到连接邀请，已连接";
        });
        

        show_toast_msg(@"连接成功")
        invitationHandler(true, self.session);
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            _statesLabel.text = @"收到连接邀请，但key不一致";
        });
    
        show_toast_msg(@"连接失败，key不一致")
        invitationHandler(false, nil);
    }

}
 
- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didNotStartAdvertisingPeer:(NSError *)error {
    C_LOG(@"❌didNotStartAdvertisingPeer --> %@", error)
}


#pragma mark --> 连接设备

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    C_LOG(@"♻️didChangeState --> %ld", state);
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    C_LOG(@"♻️didReceiveData --> %@",  str);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _statesLabel.text = FORMATSTR(@"收到消息:\n%@", str);
    });
    
    show_toast_msg(str)
}

- (void)    session:(MCSession *)session
   didReceiveStream:(NSInputStream *)stream
           withName:(NSString *)streamName
           fromPeer:(MCPeerID *)peerID{
    
}

// Start receiving a resource from remote peer.
- (void)                    session:(MCSession *)session
  didStartReceivingResourceWithName:(NSString *)resourceName
                           fromPeer:(MCPeerID *)peerID
                       withProgress:(NSProgress *)progress{
    
}

// Finished receiving a resource from remote peer and saved the content
// in a temporary location - the app is responsible for moving the file
// to a permanent location within its sandbox.
- (void)                    session:(MCSession *)session
 didFinishReceivingResourceWithName:(NSString *)resourceName
                           fromPeer:(MCPeerID *)peerID
                              atURL:(nullable NSURL *)localURL
                          withError:(nullable NSError *)error{
    
}
 





#pragma mark --> 扫描到的设备列表

-(UITableView*)tableView{
   if (!_tableView) {
       _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
       _tableView.delegate = self; _tableView.dataSource = self;
       _tableView.showsVerticalScrollIndicator = NO;
       _tableView.backgroundColor = color_white;
       [self.view addSubview:_tableView];
       [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(_statesLabel.mas_bottom).offset(0);
           make.left.right.bottom.offset(0);
       }];
    
       [_tableView registerClass:[MCListCell class] forCellReuseIdentifier:@"mc_cell"];
   }
   return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MCListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mc_cell" forIndexPath:indexPath];
    cell.mdoel = self.listAry[indexPath.row];
    
    cell.contentBtn.tag = indexPath.row;
    cell.cancleBtn.tag = indexPath.row;
    [cell.contentBtn addTarget:self action:@selector(contentPhone:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.cancleBtn addTarget:self action:@selector(sendMsg:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}
 
-(void)contentPhone:(UIButton*)btn {
    MCListModel *model = self.listAry[btn.tag];
    [self.serviceBrowse invitePeer:model.displyPeerID toSession:self.session withContext:[_contentKey dataUsingEncoding:NSUTF8StringEncoding] timeout:10];
}

-(void)sendMsg:(UIButton*)btn {
    MCListModel *model = self.listAry[btn.tag];
    NSError *error;
    
    NSString *msg = random_str(20);
    
    _statesLabel.text = FORMATSTR(@"发送消息: %@",msg);
    
    [self.session sendData:[msg dataUsingEncoding:NSUTF8StringEncoding] toPeers:@[model.displyPeerID] withMode:(MCSessionSendDataReliable) error:&error];
    
    C_LOG(@"%@", error);
}


@end





@implementation MCListCell


-(void)setMdoel:(MCListModel *)mdoel {
    _mdoel = mdoel;
    _displyNameLab.text = FORMATSTR(@"name： %@", mdoel.displyPeerID.displayName);
    _advertiserLab.text = FORMATSTR(@"%@", mdoel.advertiserDic);
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _displyNameLab = [UILabel labText:@"名称" color:color_blue font:font_s(15)];
        [self.contentView addSubview:_displyNameLab];
        
        _advertiserLab = [UILabel labText:@"参数" color:color_black font:font_s(13)];
        _advertiserLab.numberOfLines = 0;
        [self.contentView addSubview:_advertiserLab];
        
        
        _contentBtn = [UIButton title:@"连接" titColorN:color_white font:font_s(14) bgColor:color_blue];
        [self.contentView addSubview:_contentBtn];
        
        _cancleBtn = [UIButton title:@"发送" titColorN:color_group font:font_s(14) bgColor:color_blue];
        [self.contentView addSubview:_cancleBtn];
        
        
        [_displyNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(10);
            make.right.offset(-90);
        }];
        
        [_advertiserLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.offset(35);
            make.right.offset(-90);
        }];
        
        [_contentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.width.offset(70);
            make.height.offset(36);
            make.bottom.equalTo(self.contentView.mas_centerY).offset(-6);
        }];
        
        [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.width.offset(70);
            make.height.offset(36);
            make.top.equalTo(self.contentView.mas_centerY).offset(6);
        }];
        
        
//        [_contentBtn addTarget:self action:@selector(contentPhone) forControlEvents:(UIControlEventTouchUpInside)];
//
//        [_cancleBtn addTarget:self action:@selector(canclePhone) forControlEvents:(UIControlEventTouchUpInside)];

    }
    return self;
}



@end





@implementation MCListModel

-(instancetype)initWithPeerID:(MCPeerID*)peerID advertiser:(NSDictionary*)advertiser {
    self = [super init];
    if(self){
        self.displyPeerID = peerID;
        self.advertiserDic = advertiser;
//        self.session = session;
    }
    return self;
}

@end
