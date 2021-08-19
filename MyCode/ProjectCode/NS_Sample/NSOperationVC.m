//
//  NSOperationVC.m
//  MyCode
//
//  Created by New_iMac on 2021/4/20.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "NSOperationVC.h"

@interface NSOperationVC ()

@end

@implementation NSOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSOperation
//    NSBlockOperation
//    NSInvocationOperation


    
//    NSOperationQueue
    
    
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(test1) object:nil];
    [queue addOperation:operation];

    
    NSXMLParser *xmlParser;
    
    

    
}

-(void)test1{
    
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
