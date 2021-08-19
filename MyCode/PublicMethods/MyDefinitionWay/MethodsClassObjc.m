//
//  MethodsClassObjc.m
//  PeanutLK
//
//  Created by mac on 2017/3/2.
//  Copyright © 2017年 cj.All rights reserved.
//

#import "MethodsClassObjc.h"


@implementation MethodsClassObjc

#pragma mark === >>> MD5加密
+(NSString*)md5encrypting:(NSString *)mdStr{
    // 转换成utf-8
    const char * original_str = [mdStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_LONG cclong = (CC_LONG)strlen(original_str);
    CC_MD5(original_str, cclong, result);
    NSMutableString * hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
       [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

#pragma mark ===>>>  获取当前时间，日期
+(NSString*)getNowTimeByFormat:(NSString*)format{
    NSDate * currentDate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString * dateString = [dateFormatter stringFromDate:currentDate];
//    NSLog(@"当前手机本地时间：%@",dateString);
    if (dateString.length>0) { return dateString; }
    return @"";
}

#pragma mark ===>>> 将date转为字符串时间
+(NSString*)dateStamp:(NSDate*)date timeFormat:(NSString*)format{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString * dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

#pragma mark ===>>>将时间戳转化为时间(时间长度字符串为毫秒)
+(NSString*)timeStamp:(NSString*)strTime timeFormat:(NSString*)format{
    if (null_str(strTime).length==0||null_str(format).length==0) { return @""; }
    NSTimeInterval _interval = [strTime doubleValue];
    if (strTime.length>11) { _interval = _interval / 1000.0; } // 毫秒时间戳
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter * objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:format]; // 设置时间转化格式
    NSString * timeStr = [objDateformat stringFromDate:date];
    if (timeStr.length==0) { return @"" ; }
    return timeStr ;
}

#pragma mark ===>>> 四舍五入
+(NSString*)notRounding:(id)num type:(NSInteger)type afterPt:(int)position{
    
    
    /*
        NSRoundPlain   // 0 默认四舍五入
        NSRoundDown    // 1 只舍不入
        NSRoundUp      // 2 只入不舍
     
        NSRoundBankers // 比较特殊，
        保留位数后一位的数字为5时，
        根据前一位的奇偶性决定。
        为偶时向下取正，为奇数时向上取正。
        如：1.25保留一位小数。5之前是2偶数向下取正1.2；
           1.35保留一位小数时。5之前为3奇数，向上取正1.4。
    */
    
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:type scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber * ouncesDecimal;
    NSDecimalNumber * roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:[num floatValue]];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

+(float)quInteger:(float)number {
    NSString * str = FORMATSTR(@"%.0f",number);
    return [str floatValue];
}

#pragma mark ===>>> 替换空
+(NSString*)replaceEmptyStr:(id)str{
    @try {
        NSString * string = [NSString stringWithFormat:@"%@",str];
        if ([string isEqualToString:@"<null>"]||string==nil||[string isEqualToString:@"(null)"]) {
            return @"" ;
        } else { return string; }
    } @catch (NSException *exception) {
        return @"";
    } @finally { }
}

#pragma mark ===>>> 替换空字典
+(NSDictionary*)dicNull:(id)dict{
    
    NSString * str = null_str(STR(dict));
    if ([str isEqualToString:@"<null>"]||str.length==0) { return @{}; } else {
        NSDictionary * dic = (NSDictionary*)dict;
        if ([dic isKindOfClass:[NSDictionary class]]) { return dic; }
        else { return @{}; }
    }
    
}

#pragma mark ===>>> 替换空数组
+(NSArray*)aryNull:(id)ary{
    NSString * str = null_str(STR(ary)) ;
    if ([str isEqualToString:@"<null>"]||str.length==0) { return @[]; } else {
        NSArray * nsary = (NSArray*)ary;
        if ([nsary isKindOfClass:[NSArray class]]) { return nsary; }
        else { return @[]; }
    }
}


#pragma mark ===>>> 正则表达式 1:正则公式  2:需判断的内容
+(BOOL)judgeSelectionExpression:(NSString*)way content:(NSString*)content{
    NSString * regex = null_str(way);
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:content];
    return isValid;
}

#pragma mark ===>>> 存值
+(void)saveDataForUesrdefaults:(id)value andKey:(NSString*)valueKey{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:valueKey];
    [userDefaults synchronize];
}

#pragma mark ===>>> 取值
+(id)takeDataForUesrdefaults:(NSString*)key{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    id dataTake = [userDefaults objectForKey:key];
    return dataTake;
}

#pragma mark ===>>> 删值
+(void)removeDataForUesrdefaults:(NSString*)key{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
}

#pragma mark ===>>> 字典转json
+(NSString*)jsonStrByDictionary:(NSDictionary *)dic{
    NSError * parseError = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    LOG(@"字典转json：\n%@",jsonString)
    return null_str(jsonString);
}

#pragma mark ===>>> json转字典
+(NSDictionary*)dictionaryByJsonStr:(id)json{
    if ([json isKindOfClass:[NSData class]]) {
        NSDictionary * dicData = [NSJSONSerialization JSONObjectWithData:(NSData*)json options:NSJSONReadingMutableContainers error:nil];
//        LOG(@"json转字典：\n%@",dicData)
        return  null_dic(dicData);
    }
    NSData * jsonData = [null_str(json) dataUsingEncoding:(NSUTF8StringEncoding)];
    NSDictionary * dicData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//    LOG(@"json转字典：\n%@",dicData)
    return  null_dic(dicData);
}



+(void)logAllSubviews:(UIView*)view{
    

}



// 将视图转为图片
+(UIImage*)viewConversionImage:(UIView *)view{
    CGSize s = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//图片高斯模糊
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
    
    
    /*
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    // 从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    // 设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;*/
    
    CIContext *context =[CIContext contextWithOptions:nil];

    CIImage *inputImage = [[CIImage alloc] initWithImage:image];

    // create gaussian blur filter

    CIFilter * filter =[CIFilter filterWithName:@"CIGaussianBlur"];

    [filter setValue:inputImage forKey:kCIInputImageKey];

    [filter setValue:[NSNumber numberWithFloat:blur] forKey:@"inputRadius"];

    // blur image

    CIImage * result = [filter valueForKey:kCIOutputImageKey];

    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];

    UIImage *tmpImage = [UIImage imageWithCGImage:cgImage];

    CGImageRelease(cgImage);

    return tmpImage;
    
    
}
















#pragma mark ===>>> 类似安卓小提示框
+(void)showMessage:(NSString *)message{
    
     dispatch_async(dispatch_get_main_queue(), ^{
         
         ResignFirstResponder
         UIWindow * window = [UIApplication sharedApplication].keyWindow;
         if (window) {
             @try {
                 for (UIView * showView in window.subviews) {
                     if ([showView isKindOfClass:[ShowMsgView class]]) {
                         showView.alpha = 0;
                         [showView removeFromSuperview];
                     }
                 }
                 NSString * msg = null_str(message);
                 
                 // 遇到不需要显示或者要全局修改的提示，在此修改
                 if (msg.length==0) { return ; }

                 float   font ; //提示字体大小
                 if      (ScreenW==320) { font = 14.0; }
                 else if (ScreenW==375) { font = 15.0; }
                 else if (ScreenW==414) { font = 16.0; }
                 else    { font = 18.0 ; }
                 
                 // 计算文字宽高
                 CGRect rect = StringRect(msg, 280,[UIFont systemFontOfSize:font]);
                 CGPoint piont = CGPointMake(ScreenW/2 , ScreenH-ScreenH/4);
                 ShowMsgView * showView = [[ShowMsgView alloc]initWithFrameCenter:piont bounds:rect];
                 showView.transform = CGAffineTransformMakeScale(0,0);
                 showView.tag = 999;
                 [window addSubview:showView];
                 
                 showView.showLab.font = [UIFont systemFontOfSize:font];
                 showView.showLab.text = msg;
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:3.f options:UIViewAnimationOptionCurveEaseOut animations:^{
                         if (showView) {
                             showView.alpha = 1;
                             showView.transform = CGAffineTransformMakeScale(1,1);
                         }
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1 delay:2.5 options:(UIViewAnimationOptionCurveLinear) animations:^{
                             if (showView) {
                                 showView.transform = CGAffineTransformMakeScale(1.1,1.1);
                             }
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.26 animations:^{
                                 if (showView) {
                                     showView.alpha = 0 ;
                                     showView.transform = CGAffineTransformMakeScale(0.1,0.1);
                                 }
                             } completion:^(BOOL finished) {
                                 if (showView) { [showView removeFromSuperview]; }
                             }];
                         }];
                     }];
                 });
             } @catch (NSException *exception) { NSLog(@"自定义弹窗闪退~"); } @finally { }
         }
     });
    
}


/**
 生成二维码
 
 @param str 字符串
 @param whi 宽高(一样)
 @param centerImg 中心图片
 @return 二维码图片
 */
+(UIImage*)changeImageWithStr:(NSString*)str whi:(float)whi centerImg:(UIImage*)centerImg{
    
    @try {
        // 1.创建过滤器
        CIFilter * filter =[CIFilter filterWithName:@"CIQRCodeGenerator"];
        [filter setDefaults];
        // 3.给过滤器添加数据
        NSString * dataString = str;
        NSData * data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        [filter setValue:data forKeyPath:@"inputMessage"];
        
        // 4.获取输出的二维码
        CIImage * outputImage = [filter outputImage];
        CGRect extent = CGRectIntegral(outputImage.extent);
        CGFloat scale = MIN(whi/CGRectGetWidth(extent), whi/CGRectGetHeight(extent));
        
        // 1.创建bitmap;
        size_t width = CGRectGetWidth(extent) * scale;
        size_t height = CGRectGetHeight(extent) * scale;
        CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
        CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
        CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        
        // 2.保存bitmap到图片
        CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
        CGContextRelease(bitmapRef);
        CGImageRelease(bitmapImage);
        
        // 输出二维码图片
        UIImage *ewmImg = [UIImage imageWithCGImage:scaledImage];
        
        if (centerImg) {
            // 二维码最大分辨率
            CGRect maxRect = CGRectMake(0, 0, whi, whi);
            
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(whi, whi),NO,[UIScreen mainScreen].scale);
            [ewmImg drawInRect:maxRect];
            
            float bili = 4;
//            // 中心头像的白色背景位置
            CGRect rect = CGRectMake(whi/2-whi/bili/2, whi/2-whi/bili/2, whi/bili, whi/bili);
//            UIImage * imageback = [UIImage imageNamed:@"ewm_white_bg"];
//            [imageback drawInRect:rect];
            
            bili = 12;
            [centerImg drawInRect:CGRectMake(rect.origin.x+rect.size.width/bili, rect.origin.y+rect.size.height/bili, rect.size.width-rect.size.width/bili*2, rect.size.height-rect.size.height/bili*2)];
            
            // 获取绘制图片
            UIImage * resultingImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return  resultingImage;
        }
        
        return ewmImg;
        
    } @catch (NSException *exception) {
        return nil;
    } @finally { }
    
}




+ (NSString *)getDeviceType{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    // iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    
    // 模拟器
    if ([deviceString isEqualToString:@"i386"])         return @"iPhone Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"iPhone Simulator";
    
    // iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return@"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return@"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return@"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return@"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return@"iPod Touch (5 Gen)";
    
    // iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return@"iPad 1G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return@"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,2"])      return@"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return@"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return@"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return@"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,6"])      return@"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return@"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return@"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,2"])      return@"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return@"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return@"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,5"])      return@"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return@"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return@"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return@"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,3"])      return@"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,4"])      return@"iPad Mini 2 ";
    if ([deviceString isEqualToString:@"iPad4,5"])      return@"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return@"iPad Mini 2G";
    if ([deviceString isEqualToString:@"iPad4,7"])      return@"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return@"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return@"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return@"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return@"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return@"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return@"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return@"iPad Pro 9.7英寸";
    if ([deviceString isEqualToString:@"iPad6,4"])      return@"iPad Pro 9.7英寸";
    if ([deviceString isEqualToString:@"iPad6,7"])      return@"iPad Pro 12.9英寸 1代";
    if ([deviceString isEqualToString:@"iPad6,8"])      return@"iPad Pro 12.9英寸 1代 (LTE)";
    if ([deviceString isEqualToString:@"iPad6,11"])     return@"iPad 5";
    if ([deviceString isEqualToString:@"iPad6,12"])     return@"iPad 5 (LTE)";
    if ([deviceString isEqualToString:@"iPad7,1"])      return@"iPad Pro 12.9英寸 2代";
    if ([deviceString isEqualToString:@"iPad7,2"])      return@"iPad Pro 12.9英寸 2代 (LTE)";
    if ([deviceString isEqualToString:@"iPad7,3"])      return@"iPad Pro 10.5英寸";
    if ([deviceString isEqualToString:@"iPad7,4"])      return@"iPad Pro 10.5英寸 (LTE)";
    if ([deviceString isEqualToString:@"iPad7,5"])      return@"iPad 6";
    if ([deviceString isEqualToString:@"iPad7,6"])      return@"iPad 6 (LTE)";
    if ([deviceString isEqualToString:@"iPad8,1"])      return@"iPad Pro 11英寸";
    if ([deviceString isEqualToString:@"iPad8,2"])      return@"iPad Pro 11英寸";
    if ([deviceString isEqualToString:@"iPad8,3"])      return@"iPad Pro 11英寸";
    if ([deviceString isEqualToString:@"iPad8,4"])      return@"iPad Pro 11英寸";
    if ([deviceString isEqualToString:@"iPad8,5"])      return@"iPad Pro 12.9英寸 3代";
    if ([deviceString isEqualToString:@"iPad8,6"])      return@"iPad Pro 12.9英寸 3代";
    if ([deviceString isEqualToString:@"iPad8,7"])      return@"iPad Pro 12.9英寸 3代";
    if ([deviceString isEqualToString:@"iPad8,8"])      return@"iPad Pro 12.9英寸 3代";
    
    return deviceString;
}





@end








#pragma mark ===>>> 显示提示语
@implementation ShowMsgView

-(instancetype)initWithFrameCenter:(CGPoint)center bounds:(CGRect)rect{
    self = [super init];
    if (self) {
        
        self.alpha = 0;
        self.center = center;
        self.bounds = CGRectMake(0, 0, rect.size.width+18, rect.size.height+15);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
        
        self.layer.masksToBounds = YES ;
        self.layer.cornerRadius = 6 ;
        self.clipsToBounds = YES;
        
        _showLab = [[UILabel alloc]init];
        _showLab.numberOfLines = 0 ;
        _showLab.textColor = [UIColor whiteColor];
        _showLab.textAlignment = NSTextAlignmentCenter;
        _showLab.center = CGPointMake(frame_w(self)/2, frame_h(self)/2) ;
        _showLab.bounds = CGRectMake(0, 0, rect.size.width+8, rect.size.height+5);
        [self addSubview:_showLab];
        
    }
    return self;
}

@end



