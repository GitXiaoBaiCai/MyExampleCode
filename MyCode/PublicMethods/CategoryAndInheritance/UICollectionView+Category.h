//
//  UICollectionView+Category.h
//  MySlhb
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 chgyl. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (Category)
/**
 结束刷新
 
 @param type 0全部结束  1:全部结束,上拉置为无数据状态
 */
-(void)endRefreshType:(NSInteger)type isReload:(BOOL)yn;


-(void)mj_RefreshHeader:(void(^)(id type))headerBlock refreshFooter:(void(^)(id type))footerBlock;


@end

NS_ASSUME_NONNULL_END
