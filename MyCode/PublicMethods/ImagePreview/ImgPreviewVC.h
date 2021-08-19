//
//  ImgPreviewVC.h
//  ImageBrowser
//
//  Created by msk on 16/9/1.
//  Copyright © 2016年 msk. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 跳转方式
 */
typedef NS_ENUM(NSUInteger,PhotoBroswerVCType) {
    
    // push
    PhotoBroswerVCTypePush=0,
    
    // model
    PhotoBroswerVCTypeModal,
    
    // zoom
    PhotoBroswerVCTypeZoom,
};

@interface ImgPreviewVC : UIViewController

/**
 图片预览

 @param handleVC 要显示预览的界面
 @param type 跳转类型
 @param index 要显示第几张图片
 @param imagesAry 要预览显示的图片
 */
+(void)show:(UIViewController *)handleVC type:(PhotoBroswerVCType)type index:(NSUInteger)index imagesAry:(NSArray*)imagesAry;
@end











