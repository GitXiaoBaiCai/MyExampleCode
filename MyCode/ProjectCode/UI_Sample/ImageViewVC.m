//
//  ImageViewVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "ImageViewVC.h"
#import "TestModel.h"
@interface ImageViewVC ()
@property(nonatomic, strong) UIImageView *imageview;

@end

@implementation ImageViewVC

- (void)viewDidLoad {
    [super viewDidLoad];

//    ChainModel *objc1 = [ChainModel new];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i=0; i<1000; i++) {
//            NSLog(@"--->> %d",i);
        }
    });
    
    NSLog(@"viewDidLoad结束。。。");
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
