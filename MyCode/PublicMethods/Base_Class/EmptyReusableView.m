//
//  EmptyReusableView.m
//  MySlhb
//
//  Created by mac on 2019/3/13.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import "EmptyReusableView.h"

// UICollectionView 空的区头区尾
@implementation EmptyReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) { }
    return self;
}

@end

// UICollectionView 空的cell
@implementation EmptyCltViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) { }
    return self;
}

@end


// UITableView空的cell
@implementation EmptyTabViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) { self.selectionStyle = UITableViewCellSelectionStyleNone; }
    return self;
}

@end


// UITableView空的区头区尾
@implementation EmptyTabHFView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) { }
    return self;
}

@end


