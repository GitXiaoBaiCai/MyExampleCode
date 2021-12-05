//
//  ViewController.m
//  MyCode
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 mycode. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray *ui_Array;
@property(nonatomic, strong) NSArray *oc_Array;
@property(nonatomic, strong) NSArray *other_Array;

@property(nonatomic, strong) NSArray *test_Array;

@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"常用控件和OC类实例";
    
    _dataArray = [NSMutableArray array];
    _titleArray = [NSMutableArray array];
    
    _test_Array = @[@"Test",@"TestXib"];
    
    _ui_Array = @[@"UIView",
                  @"UILabel",
                  @"UIButton",
                  @"UITextField",
                  @"UIImageView",
                  @"UITextView",
                  @"UIScrollView",
                  @"UITableView",
                  @"UICollectionView",
                  @"UISlider",
                  @"UISwitch",
                  @"WkWebview",
                  @"UIAlert",
                  @"Animation",
                  @"CALayer",
                  @"Stack"];
    
    _oc_Array = @[@"NSString",
                  @"NSAttributedString",
                  @"NSArray",
                  @"NSDictionary",
                  @"NSBundle",
                  @"NSCoder",
                  @"NSData",
                  @"NSDate",
                  @"NSError",
                  @"NSException",
                  @"NSFormatter",
                  @"NSIndexPath",
                  @"NSIndexSet",
                  @"NSJSONSerialization",
                  @"NSLock",
                  @"NSMetadataAttributes",
                  @"NSNotification",
                  @"NSObjCRuntime",
                  @"NSOrderedSet",
                  @"NSPort",
                  @"NSProgress",
                  @"NSRange",
                  @"NSRegularExpression",
                  @"NSRunLoop",
                  @"NSScanner",
                  @"NSSet",
                  @"NSSortDescriptor",
                  @"NSStream",
                  @"NSTimer",
                  @"NSTimeZone",
                  @"NSURL",
                  @"NSUserDefaults",
                  @"NSUUID",
                  @"NSValue",
                  @"NSValueTransformer",
                  @"NSXMLParser",
                  @"NSFileManager",
                  @"NSThread",
                  @"NSOperation",
                  @"NSPredicate"];
    
    _other_Array = @[@"GCD_", @"Block_", @"SQL_",];
    
    [_dataArray addObject:_test_Array];
    [_titleArray addObject:@"test"];
        
    [_dataArray addObject:_ui_Array];
    [_titleArray addObject:@"UI控件"];
    
    [_dataArray addObject:_oc_Array];
    [_titleArray addObject:@"常用OC类"];
    
    [_dataArray addObject:_other_Array];
    [_titleArray addObject:@"其它常用"];
    
    [self tableView];
    
    
}


#pragma mark ==>> 创建TableView

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self; _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.offset(0);
        }];
    }
    return  _tableView;
}


#pragma mark ==>> UITableView代理，数据源

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray*)_dataArray[section]).count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"static_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    cell.textLabel.text = (_dataArray[indexPath.section])[indexPath.row];
    return cell;
}


#pragma mark => 区头区尾
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _titleArray[section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

// 选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * nextPage = _dataArray[indexPath.section][indexPath.row];
    if (![nextPage isEqual:@"WkWebview"]&[nextPage hasPrefix:@"UI"]) {
        nextPage = [nextPage substringFromIndex:2];
    }
    nextPage = [NSString stringWithFormat:@"%@VC",nextPage];
    Class vcClass = NSClassFromString(nextPage);
    if (vcClass) {
        UIViewController *next_vc = (Base_ViewController*)[vcClass new];
        next_vc.title = _dataArray[indexPath.section][indexPath.row];
        navc_push(next_vc, YES);
    }
}






@end
