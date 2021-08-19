//
//  UIImagePickerVC.h
//  Bnln_HuiShengHuo
//
//  Created by 哈哈 on 2018/3/17.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerVC : UIView <UIImagePickerControllerDelegate,UINavigationControllerDelegate>


+(instancetype)shareInstance;

typedef void (^SelectImageBlock) (id data);
@property(nonatomic,copy)SelectImageBlock selectImgBlock;


/**
 调用相册或相机

 @param vc 要显示之前的vc
 @param editing 是否允许编辑
 @param type 0相机和相册  1:相册  2:相机
 @param selectBlock 已选照片回调(单张)
 */
-(void)showPickerVC:(UIViewController *)vc allowsEditing:(BOOL)editing sourceType:(NSInteger)type selectImg:(SelectImageBlock)selectBlock;

@property(nonatomic,strong) UIImagePickerController * imagePickerController;
@property(nonatomic,strong) UIViewController * supViewController;
@property(nonatomic,assign) NSInteger type;


@end
