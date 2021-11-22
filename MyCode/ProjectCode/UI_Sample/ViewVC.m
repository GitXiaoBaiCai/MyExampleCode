//
//  ViewVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "ViewVC.h"

@interface ViewVC ()

@property(nonatomic,strong) UIView *testView0;
@property(nonatomic,strong) UIView *testView1;


@end

@implementation ViewVC


- (void)viewDidLoad {
    [super viewDidLoad];

    [self testView0];

 
    
   // UIDynamicItemGroup *group;
    
    
    

}





-(UIView*)testView0{
    if (!_testView0) {
        _testView0 = [[UIView alloc]init];
//        _testView0.tag = 10;
//        _testView0.userInteractionEnabled = YES;
        _testView0.frame = CGRectMake(100, 100, 200, 200);
        _testView0.bounds = CGRectMake(0, 0, 200, 200);
        _testView0.center = CGPointMake(200, 200);
//        _testView0.transform = CGAffineTransformMakeScale(0.5, 0.5);
        _testView0.contentScaleFactor = 1.5;
//        _testView0.
//        _testView0.
//        _testView0.
        
        _testView0.backgroundColor = color_random;
        
        
        _testView0.layer.masksToBounds = YES;
        _testView0.layer.cornerRadius = 15;
        _testView0.layer.borderColor = color_random.CGColor;
        _testView0.layer.borderWidth = 20;
        _testView0.layer.shadowColor = color_random.CGColor;
        _testView0.layer.shadowRadius = 5;
        _testView0.layer.shadowOffset = CGSizeMake(10, 20);
        
        [self.view addSubview:_testView0];
        NSArray * ary = [_testView0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.offset(120);
            make.width.offset(200);
            make.height.offset(200);
        }];
        
        C_LOG(@"%@",ary)
        
    }
    return _testView0;
}


-(UIView*)testView1{
    if (!_testView1) {
        _testView1 = [[UIView alloc]init];
        _testView1.tag = 10;
        _testView1.userInteractionEnabled = YES;
        _testView1.backgroundColor = color_random;
        [self.view addSubview:_testView1];
        _testView1.frame = CGRectMake(100, 100, 200, 200);
    }
    return _testView1;
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
