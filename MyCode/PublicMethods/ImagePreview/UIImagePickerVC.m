//
//  UIImagePickerVC.m
//  Bnln_HuiShengHuo
//
//  Created by 哈哈 on 2018/3/17.
//

#import "UIImagePickerVC.h"

@interface UIImagePickerVC ()


@end

@implementation UIImagePickerVC


+(instancetype)shareInstance{
    static UIImagePickerVC * imgPickerVc;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!imgPickerVc) {
            imgPickerVc = [[UIImagePickerVC alloc]init];
        }
    });
    return imgPickerVc;
}

-(void)showPickerVC:(UIViewController *)vc allowsEditing:(BOOL)editing sourceType:(NSInteger)type selectImg:(SelectImageBlock)selectBlock{
    self.type = type;
    self.supViewController = vc;
    self.selectImgBlock = selectBlock ;
    self.imagePickerController = [[UIImagePickerController alloc]init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsEditing = editing;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [self paizhaoORphoto:UIAlertControllerStyleAlert];
    }else{
        [self paizhaoORphoto:UIAlertControllerStyleActionSheet];
    }
}

#pragma mark ===>>>  调用相册或相机
-(void)paizhaoORphoto:(UIAlertControllerStyle)stylet{
    
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
//                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]};
//    [item setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    switch (_type) {
        case 0:{ // 同时调用相机和相册
            
            UIAlertController * alertVC=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:stylet];
            UIAlertAction * actionCamera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
                
                BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
                if(!isCamera){ show_toast_msg(@"无法调用相机!"); return; }
                _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [_supViewController presentViewController:_imagePickerController animated:YES completion:nil];
            }];
            
            UIAlertAction*actionPhote=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [_supViewController presentViewController:_imagePickerController animated:YES completion:nil];
            }];
            
            UIAlertAction * actionCancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {  }];
            
            [alertVC addAction:actionCamera];
            [alertVC addAction:actionPhote];
            [alertVC addAction:actionCancle];
            [_supViewController presentViewController:alertVC animated:YES completion:nil];
            
        }break;
            
        case 1:{ // 调用相册
            
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [_supViewController presentViewController:_imagePickerController animated:YES completion:nil];
            
        }break;
            
        case 2:{ // 调用相机
            
            BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
            if(!isCamera){ show_toast_msg(@"无法调用相机!"); return; }
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [_supViewController presentViewController:_imagePickerController animated:YES completion:nil];
            
        }break;
            
        default: break;
    }

}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
        if ([type isEqualToString:@"public.image"]) {
            UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
            UIImageWriteToSavedPhotosAlbum(image, self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
        }
    }else{
        NSString * strKey = UIImagePickerControllerEditedImage; // 允许编辑
        if (_imagePickerController.allowsEditing==NO) { // 不允许裁剪(获取原始图片)
            strKey = UIImagePickerControllerOriginalImage;
        }
        [_imagePickerController dismissViewControllerAnimated:YES completion:^{
            UIImage * image = [info objectForKey:strKey];
//            [self changeUIBarButtonItem];
            _selectImgBlock(image);
        }];
    }
}

// 点击相册页面的取消按钮返回
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [_imagePickerController dismissViewControllerAnimated:YES completion:^{
//        [self changeUIBarButtonItem];
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
        [_imagePickerController dismissViewControllerAnimated:YES completion:^{
//            [self changeUIBarButtonItem];
            _selectImgBlock(image);
        }];
    }
}

//-(void)changeUIBarButtonItem{
//    UIBarButtonItem * item = [UIBarButtonItem appearance];
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:0.001],
//                                 NSForegroundColorAttributeName:[UIColor clearColor]};
//    [item setTitleTextAttributes:attributes forState:UIControlStateNormal];
//}




//-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if ([UIDevice currentDevice].systemVersion.floatValue < 11) {
//        return;
//    }
//    if ([viewController isKindOfClass:NSClassFromString(@"PUPhotoPickerHostViewController")]) {
//        [viewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (obj.frame.size.width < 42) {
//                [viewController.view sendSubviewToBack:obj];
//                *stop = YES;
//            }
//        }];
//    }
//}

@end
