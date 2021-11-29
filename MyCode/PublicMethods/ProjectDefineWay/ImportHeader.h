

//*** 本页的宏主要是静态宏 ***//



#pragma mark ===>>> 高度
// 顶部和底部导航栏高度
#define status_bar_h  [UIApplication sharedApplication].statusBarFrame.size.height
#define navc_bar_h    (status_bar_h+44)
#define tabbar_h      (IS_IPHONE_X?83:49)
#define i_x_safe_b    (IS_IPHONE_X?34:0) // iPhoneX需要加的高度(底部安全距离)

/*
safeAreaInsets --> top:20.000000  bottom:0.000000  left:0.000000  right:0.000000

safeAreaInsets --> top:47.000000  bottom:34.000000  left:0.000000  right:0.000000

safeAreaInsets --> top:50.000000  bottom:34.000000  left:0.000000  right:0.000000

safeAreaInsets --> top:48.000000  bottom:34.000000  left:0.000000  right:0.000000
*/

#pragma mark ===>>> 头文件

// 其它第三方
#import <YYWebImage/YYWebImage.h>
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetManager.h"
#import <SRWebSocket.h>
#import "MJExtension.h"
#import "MJRefresh.h"
#import "Masonry.h"
#import "MMKV.h"


// 宏
#import "MethodsDefine.h"
#import "ProjectDefine.h"
#import "ObjcPublicWay.h"
#import "ProjectDefClass.h"
#import "MethodsClassObjc.h"
#import "DefineKeyString.h"
#import "ProjectFont.h"
#import "ProjectColor.h"

// 网络
#import "RequestUrl.h"
#import "NetRequest.h"

// 类别
#import "UIAlertController+Category.h"
#import "UICollectionView+Category.h"
#import "UITableView+Category.h"
#import "UIImageView+Category.h"
#import "UITextField+Category.h"
#import "UIButton+Category.h"
#import "UILabel+Category.h"
#import "UIView+Category.h"

// 继承
#import "Base_View.h"
#import "Base_Object.h"
#import "Base_ViewController.h"
#import "Base_NavigationController.h"



// 其它
#import "TestBtnView.h"















