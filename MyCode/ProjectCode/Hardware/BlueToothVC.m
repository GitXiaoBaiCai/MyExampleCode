//
//  BlueToothVC.m
//  MyCode
//
//  Created by 陈剑 on 2022/4/13.
//  Copyright © 2022 mycode. All rights reserved.
//

#import "BlueToothVC.h"
#import "ShowEwmView.h"
#import "BarcodeScannerVC.h"

@interface BlueToothVC () <CBCentralManagerDelegate, CBPeripheralManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) CBCentralManager *centralManager;
@property(nonatomic, strong) CBPeripheralManager *peripheralManager;

@property(nonatomic, strong) NSMutableDictionary<NSString *, id> *deviceDictionary;
@property(nonatomic, strong) NSMutableArray *deviceListAry;

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) TestBtnView *btnView;
@property(nonatomic, strong) UITextView *statesText;
@property(nonatomic, strong) NSArray *functionName;

@property(nonatomic, strong) ShowEwmView *showEwmView;

@property(nonatomic, copy) NSString *qrDataStr;

@end

@implementation BlueToothVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _qrDataStr = @"";
    
    _deviceDictionary = [NSMutableDictionary dictionary];
    _deviceListAry = [NSMutableArray array];


    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    _functionName = @[@"扫描周边设备", @"停止扫描", @"发送广播", @"停止发送" ];

    [self btnView];
    [self statesText];
    [self tableView];
    
    
    [self showEwmView];
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

-(UITextView*)statesText {
    if (!_statesText) {
        
        _statesText = [[UITextView alloc]init];
        _statesText.editable = NO;
        _statesText.text = @"状态";
        _statesText.font = font_s(13);
        _statesText.textColor = color_blue;
        _statesText.backgroundColor = color_group;
        _statesText.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        [_statesText cornerRadius:10];
        [self.view addSubview:_statesText];
        [_statesText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_btnView.mas_bottom);
            make.left.offset(20);
            make.right.offset(-20);
            make.height.offset(80);
        }];
        
    }
    return _statesText;
}

-(TestBtnView*)btnView{
    if (!_btnView) {
        _btnView = [[TestBtnView alloc]init];
        _btnView.btnTitleAry = _functionName;
        [self.view addSubview:_btnView];
        [_btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(330);
            make.top.offset(navc_bar_h+10);
            make.centerX.equalTo(self.view.mas_centerX);
            make.height.offset(_functionName.count/2*70+(_functionName.count%2)*70);
        }];
        WeakSelf(weakSelf)
        _btnView.clickBtnBlock = ^(NSInteger btnTag) {
            [weakSelf clickBtn:btnTag];
        };
    }
    return _btnView;
}

-(UITableView*)tableView{
   if (!_tableView) {
       
       _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
       _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       _tableView.delegate = self; _tableView.dataSource = self;
       _tableView.showsVerticalScrollIndicator = NO;
       _tableView.backgroundColor = color_white;
       [self.view addSubview:_tableView];
       [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(_statesText.mas_bottom);
           make.left.right.bottom.offset(0);
       }];
       
       [_tableView registerClass:[BlueToothCell class] forCellReuseIdentifier:@"bt_cell"];
   }
   return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return _deviceListAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BlueToothCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bt_cell" forIndexPath:indexPath];
    
    BlueToothModel *model = _deviceListAry[indexPath.row];
    cell.nameLabel.text = FORMATSTR(@"%ld: %@   name: %@", indexPath.row,  model.addres, model.peripheral.name);
    cell.uuidLabel.text = model.peripheral.identifier.UUIDString;
  
   return cell;
}
 

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BlueToothModel *model = _deviceListAry[indexPath.row];
    C_LOG(@"peripheral --> %@\n%@\n", model.peripheral, model.advertisementDataAry);
}

//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0;
//}



-(void)clickBtn:(NSInteger)tag {
    
    _statesText.text = FORMATSTR(@"状态： %@", _functionName[tag-1]);
    
    switch (tag) {
            
        case 1: {
            

            if (_centralManager.isScanning) {
                return;
            }
            
            [_deviceListAry removeAllObjects];
            [_tableView reloadData];
            
            
            WeakSelf(weakSelf)
            BarcodeScannerVC *scannerVC = [[BarcodeScannerVC alloc]init];
            navc_push(scannerVC, NO)
            scannerVC.qrResultBlock = ^(NSString * _Nonnull qrString) {

                weakSelf.qrDataStr = qrString;
                [weakSelf.centralManager scanForPeripheralsWithServices:nil options:nil];
                
            };
            

        } break;
            
            
        case 2: {
            [_centralManager stopScan];
        } break;
            
            
        case 3: {
            
            
            if (_peripheralManager.isAdvertising) {
                self.showEwmView.show = YES;
                return;
            }
            
            
            NSString *name = random_str(20);
            CBUUID *myCustomServiceUUID =  [CBUUID UUIDWithNSUUID:[NSUUID UUID]];
//
            CBMutableCharacteristic *myCharacteristic = [[CBMutableCharacteristic alloc] initWithType: myCustomServiceUUID
                                                                                           properties: CBCharacteristicPropertyRead
                                                                                                value: nil
                                                                                          permissions: CBAttributePermissionsReadable];


            CBMutableService *myService = [[CBMutableService alloc] initWithType:myCustomServiceUUID primary:YES];
            myService.characteristics = @[myCharacteristic];

            [_peripheralManager addService:myService];
//
            NSDictionary *dic = @{
                CBAdvertisementDataServiceUUIDsKey: @[myCustomServiceUUID],
                CBAdvertisementDataLocalNameKey: name,
                CBAdvertisementDataIsConnectable: @YES,
                CBAdvertisementDataSolicitedServiceUUIDsKey:@[myCustomServiceUUID],
                
            };
            [_peripheralManager startAdvertising:dic];
            
            C_LOG(@"Advertising dic --> %@", dic);
            
            _statesText.text = FORMATSTR(@"正在发送广播: \n%@", dic);
            

            self.showEwmView.content = FORMATSTR(@"%@;%@", name, myCustomServiceUUID.UUIDString);
            
            self.showEwmView.show = YES;
            
            
        } break;
            
        
        case 4: {
            [_peripheralManager stopAdvertising];
        } break;
            
            
            
        case 5: {
            NSUUID *newUUID = [NSUUID UUID];
            NSLog(@"%@", newUUID);
        }
            
        
        default:
            break;
    }
    
}
 

#pragma mark --> CBCentral 代理

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSLog(@"central state --> %ld", central.state);
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict{
    
}


-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
//    C_LOG(@"peripheral: %@ \n\nadvertisementData: %@\n\nRSSI: %@", peripheral, advertisementData, RSSI);
    
    
    NSString *name = null_str(advertisementData[@"kCBAdvDataLocalName"]);
    NSArray *uuidAry = null_ary(advertisementData[@"kCBAdvDataServiceUUIDs"]);
    
    NSString *jionNewStr = FORMATSTR(@"%@;%@", name, [uuidAry componentsJoinedByString:@""]);
    
    NSLog(@"✅✅✅--> %@", jionNewStr);
    
    if ([jionNewStr isEqualToString:self.qrDataStr]) {
        show_toast_msg(@"成功发现对方设备")
        _statesText.text = @"已找到对方设备!!!";
        [_centralManager stopScan];
    }
    
    
    NSString *newP = FORMATSTR(@"%p", peripheral);

    BOOL isContain = false;
    for (BlueToothModel *oldBtModel in self.deviceListAry) {
        
        @autoreleasepool {
            CBPeripheral *p = oldBtModel.peripheral;
            NSString *oldP = FORMATSTR(@"%p", p);
            if ([oldP isEqual:newP]) {
                isContain = YES;
                [oldBtModel addNewAdvertisement:@{@"identifier":peripheral.identifier, @"advertisementData":advertisementData}];
                break;
            }
            
        }
        
    }
    
    if (isContain==false) {
        BlueToothModel *btModel = [[BlueToothModel alloc]initWithPer:peripheral advertisementDic:@{@"identifier":peripheral.identifier, @"advertisementData":advertisementData}];
        if (peripheral.name.length>0) {
            [self.deviceListAry insertObject:btModel atIndex:0];
        }else{
            [self.deviceListAry addObject:btModel];
        }
    }
    
    [_tableView reloadData];
    
    

}



#pragma mark --> peripheral 代理
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    NSLog(@"peripheral state --> %ld", peripheral.state);
}

-(void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
    
    
    if (error) {
        NSLog(@"error: %@", error);
    }else{
        NSLog(@"添加了服务 %@", service);
    }
}


- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    if (error) {
        NSLog(@"Advertising error: %@", error);
    } else{
        NSLog(@"正在对外广播。。。");
    }
    
}





@end





@implementation BlueToothCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLabel = [UILabel labText:@"" color:color_red font:font_s(14)];
        [self.contentView addSubview:_nameLabel];
        
        _uuidLabel = [UILabel labText:@"" color:color_black font:font_s(13)];
        [self.contentView addSubview:_uuidLabel];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.bottom.equalTo(self.contentView.mas_centerY).offset(-3);
        }];
        
        [_uuidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.equalTo(self.contentView.mas_centerY).offset(3);
        }];
        
    }
    return self;
}



@end





@implementation BlueToothModel

-(instancetype)initWithPer:(CBPeripheral*)peripheral advertisementDic:(NSDictionary*)dic {
    self = [super init];
    if (self) {
        self.peripheral = peripheral;
        self.addres = FORMATSTR(@"%p", peripheral);
        self.advertisementDataAry = [NSMutableArray array];
        [self.advertisementDataAry addObject:dic];
    }
    return self;
}

-(void)addNewAdvertisement:(NSDictionary*)newAdvDic {
    [self.advertisementDataAry addObject:newAdvDic];
}


@end
