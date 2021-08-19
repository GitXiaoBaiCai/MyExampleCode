//
//  AlertVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "AlertVC.h"

@interface AlertVC ()

@end

@implementation AlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url = [NSURL URLWithString:@""]; // 原视频资源
    NSURL *outputUrl = [NSURL URLWithString:@""]; // 导出视频路径
     
    AVAsset *asset = [AVAsset assetWithURL:url];
    
    AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:asset presetName:@""];
    
    CMTimeRange range = CMTimeRangeMake(CMTimeMakeWithSeconds(0.5f, asset.duration.timescale), kCMTimePositiveInfinity);

    exportSession.timeRange = range;
    exportSession.outputURL = outputUrl;
    exportSession.outputFileType = AVFileTypeMPEG4;
 
     [exportSession exportAsynchronouslyWithCompletionHandler:^{
             
             switch (exportSession.status) {
                     
                 case AVAssetExportSessionStatusCompleted:
                     
                 {
                     NSLog(@"------视频ok");
                     NSLog(@"%@", [NSThread currentThread]);
//                     DBLog(@"保存视频%@", url.absoluteString);
                     
                     if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
                         NSLog(@" ---- 删除原视频");
                         [[NSFileManager defaultManager] removeItemAtPath:[url path] error:nil];
                     }
                                 }
                     
                     break;
                     
                 default:
//                     [NSObject showHudTipStr:@"视频保存失败！" font:nil];
                     break;
                     
             }
             
     }];
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
