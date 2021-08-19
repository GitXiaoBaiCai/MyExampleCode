//
//  UITableView+Category.m
//  MySlhb
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import "UITableView+Category.h"

@implementation UITableView (Category)

/**
 结束刷新
 
 @param type 0:全部结束,上拉置为无数据状态  1:结束刷新
 */
-(void)endRefreshType:(NSInteger)type isReload:(BOOL)yn{
    [self.mj_header endRefreshing];
    if (type>0) { [self.mj_footer endRefreshing]; }
    else{ [self.mj_footer endRefreshingWithNoMoreData]; }
    if (yn) { [self reloadData]; }
}


-(void)mj_RefreshHeader:(void(^)(id type))headerBlock refreshFooter:(void(^)(id type))footerBlock{
    WeakSelf(weakSelf)
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.mj_footer resetNoMoreData];
        headerBlock(@"");
    }];
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        footerBlock(@"");
    }];
}


@end
