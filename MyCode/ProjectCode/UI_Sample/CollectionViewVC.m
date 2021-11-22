//
//  CollectionViewVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "CollectionViewVC.h"

@interface CollectionViewVC () <UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>

@property(nonatomic,strong) UICollectionView *cltView;
@property(nonatomic,strong) NSArray *buttonTitleAry;
@property(nonatomic,assign) NSInteger nowSelectIndex;

@end


@implementation CollectionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _buttonTitleAry = @[@"美颜相机",@"相机",@"录像",@"全景摄影",@"延时录像",@"慢动作",@"滤镜",@"等等"];
    
//    self.view.backgroundColor = [UIColor blackColor];

//    for (int i = 0; i<_buttonTitleAry.count; i++) {
//        NSString *title = _buttonTitleAry[i];
//        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
//        widthMtAry[i] = size.width+5;
//    }
    
    _nowSelectIndex = 0;
    
    [self cltView];
    
    _nowSelectIndex = 1;
     
    
    
}

-(UICollectionView*)cltView{
    if (!_cltView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(0,ScreenW/3, 0, ScreenW/3);
        _cltView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _cltView.delegate = self; _cltView.dataSource = self;
        _cltView.backgroundColor = [UIColor clearColor];
        _cltView.showsHorizontalScrollIndicator = NO;
        _cltView.scrollEnabled = NO;
        [self.view addSubview:_cltView];
        [_cltView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.offset(120);
            make.height.mas_equalTo(200);
        }];
        [_cltView registerClass:[ButtonCltCell class] forCellWithReuseIdentifier:@"buttonCltCell"];
     
        UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
        UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
        leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
        [_cltView addGestureRecognizer:leftSwipeGesture];
        [_cltView addGestureRecognizer:rightSwipeGesture];
        
    }
    return _cltView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  _buttonTitleAry.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ButtonCltCell *cltCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"buttonCltCell" forIndexPath:indexPath];
    cltCell.titleLab.text = _buttonTitleAry[indexPath.item];
    if (_nowSelectIndex==indexPath.item) {
        cltCell.isCenter = YES;
        [_cltView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
    }else{
        cltCell.isCenter = NO;
    }
    return cltCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item==_nowSelectIndex) { return; }
    _nowSelectIndex = indexPath.item;
    [_cltView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ScreenW/3, 200);
}

-(void)swipeGesture:(UISwipeGestureRecognizer*)swipeGesture{

    NSLog(@"手势状态：%ld",(long)swipeGesture.state);
    
    if (swipeGesture.state == UIGestureRecognizerStateEnded) {
        NSLog(@"滑动方向：%lu",(unsigned long)swipeGesture.direction);
        
        switch (swipeGesture.direction) {
            case UISwipeGestureRecognizerDirectionLeft:{
                if (_nowSelectIndex<_buttonTitleAry.count-1) {
                    _nowSelectIndex++;
                }
            } break;
                
            case UISwipeGestureRecognizerDirectionRight:{
                if (_nowSelectIndex>0) {
                    _nowSelectIndex--;
                }
            } break;
                
            default:{ } break;
        }
        
        [self changeScrollToItem];
    }
}

-(void)changeScrollToItem{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_nowSelectIndex inSection:0];
    [_cltView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
    [_cltView reloadData];
}


@end






@implementation ButtonCltCell

-(void)setIsCenter:(BOOL)isCenter{
    _isCenter = isCenter;
    if (_isCenter) {
        _titleLab.hidden = NO;
        [UIView animateWithDuration:0.26 animations:^{
            _headImgView.transform = CGAffineTransformMakeScale(1.5, 1.5);
            _headImgView.layer.anchorPoint = CGPointMake(0.5, 0.65);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        _titleLab.hidden = YES;
        [UIView animateWithDuration:0.26 animations:^{
            _headImgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            _headImgView.layer.anchorPoint = CGPointMake(0.5, 0.5);
           
        } completion:^(BOOL finished) {

        }];
    }
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        _headImgView = [[UIImageView alloc]init];
        _headImgView.backgroundColor = color_random;
        [self.contentView addSubview:_headImgView];
        [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(30);
            make.right.offset(-30);
            make.height.equalTo(_headImgView.mas_width);
            make.bottom.offset(-35);
//            make.centerY.equalTo(self.contentView.mas_centerY).offset(-20);
        }];
    
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont boldSystemFontOfSize:15];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(-5); //make.height.offset(16);
            make.centerX.equalTo(self.contentView.mas_centerX);
        }];
        
    }
        
    return self;
}

@end
