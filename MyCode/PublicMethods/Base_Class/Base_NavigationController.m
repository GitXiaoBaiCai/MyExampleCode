//
//  Base_NavigationController.m
//  MyCode
//
//  Created by New_iMac on 2021/2/21.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "Base_NavigationController.h"

@interface Base_NavigationController () <UINavigationControllerDelegate>

@end

@implementation Base_NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.delegate = self;
    
    WeakSelf(weakself)
    
    // 在自定义左侧返回按钮和隐藏导航栏的时候会到时侧滑手势失效，原因为delegate阶段被阻断了，在此重新实现delegate
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = (id)weakself;
        self.delegate = (id)weakself;
    }
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // viewController不是导航控制器的第1个子控制器
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"new_back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
        backButton.bounds = CGRectMake(0, 0, 50, 44);
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
//        viewController.navigationItem.leftBarButtonItem
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
//        leftItem.width = 30;
//        UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:@selector(clickBack:)];
//        fixedButton.width = -60;
//        viewController.navigationItem.leftBarButtonItems = @[fixedButton,leftItem];
        
    }
    [super pushViewController:viewController animated:animated];

}

-(void)clickBack:(UIButton*)backBtn{
    [self popViewControllerAnimated:YES];
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
