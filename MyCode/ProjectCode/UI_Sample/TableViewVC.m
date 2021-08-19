//
//  TableViewVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "TableViewVC.h"

@interface TableViewVC () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation TableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    for (int i=0; i<200; i++) {
        TabCellModel *model = [[TabCellModel alloc]init];
        model.title = FORMATSTR(@" 第==%d==行",i);
        model.isAnimation = NO;
        [_dataArray addObject:model];
    }
    
    [self tableView];
}

 
-(UITableView*)tableView{
    if (!_tableView) {
        
//        WeakSelf(weakSelf)
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self; _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = color_white;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.right.bottom.offset(0);
        }];
        [_tableView registerClass:[CustomTabCell class] forCellReuseIdentifier:@"cell_id"];
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    C_LOG(@"===>>> 创建表格和赋值")
    CustomTabCell *tabCell = [tableView dequeueReusableCellWithIdentifier:@"cell_id" forIndexPath:indexPath];
    TabCellModel *model = _dataArray[indexPath.row];
    if (model.isAnimation==NO) {
        tabCell.contentView.alpha = 0.0;
    }else{
        tabCell.contentView.alpha = 1;
    }
    
    tabCell.textLabel.text = model.title;
    return tabCell;
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    C_LOG(@"===>>> 表格已经显示")
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    C_LOG(@"===>>> 将要显示")
    TabCellModel *model = _dataArray[indexPath.row];
    [UIView animateWithDuration:0.26 animations:^{
        cell.contentView.alpha = 1;
    } completion:^(BOOL finished) {
        model.isAnimation = YES;
    }];
}


@end




@implementation CustomTabCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.alpha = 0.0;
        self.contentView.backgroundColor = color_random;

    }
    return self;
}

@end




@implementation TabCellModel



@end



