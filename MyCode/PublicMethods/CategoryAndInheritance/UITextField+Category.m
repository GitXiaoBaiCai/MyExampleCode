//
//  UITextField+Category.m
//  MySlhb
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import "UITextField+Category.h"
#import <objc/runtime.h>

#define r_screen_width    [UIScreen mainScreen].bounds.size.width
#define r_screen_height   [UIScreen mainScreen].bounds.size.height

#define r_main_window     [[UIApplication sharedApplication].delegate window]
#define r_is_text_event   [self isMemberOfClass:[UITextField class]]||[self isMemberOfClass:[UITextView class]]



@implementation UITextField (Category)

+(UITextField*)textColor:(UIColor*)color phtxt:(NSString*)phStr font:(UIFont*)font{
    
    UITextField * txF = [[UITextField alloc]init];
    txF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 30)];
    txF.leftViewMode = UITextFieldViewModeAlways;
    txF.placeholder = phStr; txF.font = font;
    txF.text = @"";
    
    
    UITapGestureRecognizer * tapEndLab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jishubianji)];
    UIView * keyBoardTopview = [[UIView alloc]init];
    keyBoardTopview.frame = CGRectMake(0,0,ScreenW,ss_x(30));
    UILabel * endLab = [UILabel labText:@"完成" color:color_rgb(0, 122, 255) font:font_b(13)];
    endLab.frame = CGRectMake(ScreenW-ss_x(55),0,ss_x(55),ss_x(30));
    endLab.textAlignment = NSTextAlignmentCenter;
    endLab.userInteractionEnabled = YES;
    endLab.backgroundColor = color_group;
    [keyBoardTopview addSubview:endLab];
    [endLab addGestureRecognizer:tapEndLab];
    txF.inputAccessoryView = keyBoardTopview;
    txF.inputAccessoryView.backgroundColor = color_group;
    
    [txF registerKeyboardManagement];
    
    return txF;
}

// 添加通知
-(void)registerKeyboardManagement{
//    if (r_is_text_event) {
        // 当第一响应为 UITextField 和 UITextView 时注册键盘通知（将要显示、已经显示、隐藏）
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotificationAction:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotificationAction:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotificationAction:) name:UIKeyboardDidShowNotification object:nil];
//    }
}

-(void)addTarget_KeyboardDown{
   [self addTarget:self action:@selector(keyboardDown) forControlEvents:(UIControlEventEditingDidEndOnExit)];
}
-(void)keyboardDown{ }

+(void)jishubianji{ ResignFirstResponder }
-(void)jishubianji{ ResignFirstResponder }


#pragma mark ==>> 键盘通知
- (void)keyboardNotificationAction:(NSNotification *)notification{
    
    if (!self.isFirstResponder){
        
    } else {
        
        if ([notification.name isEqualToString:UIKeyboardWillHideNotification]) {
            @try {
                for (UIView * showView in r_main_window.subviews) {
                    if ([showView isKindOfClass:[ShowMsgView class]]) {
                        showView.alpha = 0;
                        [showView removeFromSuperview];
                    }
                }
                
                NSArray * viewArry =  r_main_window.subviews;
                UIView * view = [viewArry objectAtIndex:0];
                if (viewArry.count>1) { view = [viewArry objectAtIndex:1]; }
                
                view.frame = CGRectMake(0, 0, r_screen_width, r_screen_height);
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
        } else if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
            
            @try {
                for (UIView * showView in r_main_window.subviews) {
                    if ([showView isKindOfClass:[ShowMsgView class]]) {
                        showView.alpha = 0;
                        [showView removeFromSuperview];
                    }
                }
                CGRect keyboardFrame = ((NSValue*)notification.userInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
                UIView * sfView = (UIView*)self;
                CGRect rect = [r_main_window convertRect:sfView.frame fromView:sfView.superview];
                CGFloat y = rect.origin.y+rect.size.height-keyboardFrame.origin.y;
                
                NSArray * viewArry = r_main_window.subviews;
                UIView * view = [viewArry objectAtIndex:0]; // 取到的是vc的view
                if (viewArry.count>1) { view = [viewArry objectAtIndex:1]; } // 模态弹窗
                
                if (y>0) {
                    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y-y, view.frame.size.width, view.frame.size.height);
                }
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
                     
        } else if ([notification.name isEqualToString:UIKeyboardDidShowNotification]){
            
        }
        
    }
}

// 移除通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
