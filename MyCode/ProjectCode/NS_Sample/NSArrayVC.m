//
//  NSArrayVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/24.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "NSArrayVC.h"

@interface NSArrayVC ()
@property(nonatomic,strong) NSMutableArray *mutAry;
@end

@implementation NSArrayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mutAry = [[NSMutableArray alloc]init];

//    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(creatMuntAry) object:nil];
//    [thread start];
        
}

-(void)creatMuntAry{
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"开始写入数据。。。。。");
    for (int i=0; i<100000000; i++) {
        [_mutAry addObject:@"aaa"];
    }
    CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"所用时间: %lf 秒",endTime-startTime);
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
