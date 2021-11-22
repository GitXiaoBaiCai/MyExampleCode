//
//  WkWebviewVC.m
//  MyCode
//
//  Created by New_iMac on 2021/2/3.
//  Copyright © 2021 mycode. All rights reserved.
//

#import "WkWebviewVC.h"

@interface WkWebviewVC ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,WKScriptMessageHandler>

@property(nonatomic, strong) UIProgressView *progressView; // 进度条展示
@property(nonatomic, strong) WKWebView *wkWebView;  // wkWebView
@property(nonatomic, strong) UIButton *colosWebBtn; // 关闭页面的按钮

@end

@implementation WkWebviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftButtonItem];
    [self wkWebView];
    [self loadContent];
}

-(void)loadContent{
   
//    NSString *pathURL = @"http://localhost:8080/JavaWeb_Test1/html/CallOC.html";
//    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:pathURL]]];
//    NSString *htmlHeader = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";


    // 加载本地html字符串时，设置宽自适应手机屏幕
//    NSString *htmlStr = @"<p>爱客宝伙伴们：</p> <p> </p> <p>     关于65%VIP用户分红上报规则，参与上报分红的65%vip需要当月有效结算订单≥1单，才属于有效上报分红点。此规则即日起开始执行。如有任何疑问，点击本通知添加爱客宝官方指导老师微信咨询。</p> <p> </p> <p> </p> <p> </p> <p> </p> <p>                                                                                                                 爱客宝市场部</p> <p>                                                                                                                2021年2月1日</p>";
//    [_wkWebView loadHTMLString:[htmlStr stringByAppendingString:htmlHeader] baseURL:nil];
    
    
    // 加载本地html文件
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"wmsj" ofType:@"txt"];
//    NSURL *pathURL = [NSURL fileURLWithPath:filePath];
    NSString *url = @"https://new.m.aikbao.com/zeroBuy?uid=b6fd6ab168b2a67e91f818d591a7b6c8&mobile=18711460521&time=1637224471&ifNewUrlV3=1&token=Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9tZW1iZXIuYWlrYmFvLmNvbVwvYXBwXC92MVwvcHdkX2xvZ2luIiwiaWF0IjoxNjM3MjIyNzgzLCJleHAiOjE2OTcyMjI3MjMsIm5iZiI6MTYzNzIyMjc4MywianRpIjoiYTZZQmZoOFBQTnNjNFlwYyIsInN1YiI6ODA5NTQzNSwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.cGg_vuMDN9WL3iQ73KKjBXqzQOJY7sQAWEwXq7XTVFA";
    NSURL *pathURL = [NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    pathURL = [NSURL URLWithDataRepresentation:[url dataUsingEncoding:NSUTF8StringEncoding] relativeToURL:nil];
//    [_wkWebView loadFileURL:pathURL allowingReadAccessToURL:pathURL];
//    [_wkWebView loadHTMLString:htmlHeader baseURL:pathURL];
    
//    _wkWebView.customUserAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36";
    [_wkWebView loadRequest:[NSURLRequest requestWithURL:pathURL]];

//    [_wkWebView loadHTMLString:@"" baseURL:pathURL];
//    [_wkWebView loadRequest:[NSURLRequest requestWithURL:pathURL]];
    
    
    
        
}

-(WKWebView*)wkWebView{
    if (!_wkWebView) {
        // 设置
        WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
        WKPreferences * preference = [[WKPreferences alloc]init];
        preference.minimumFontSize = 16;
        if (@available(iOS 10.0, *)) {
            config.mediaTypesRequiringUserActionForPlayback = YES;
        }
        if (@available(iOS 9.0, *)) {
            config.allowsAirPlayForMediaPlayback = YES;
        }
        config.allowsInlineMediaPlayback = YES ;
        config.preferences = preference;
        
        // 初始化
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config] ;
        _wkWebView.UIDelegate = self; _wkWebView.navigationDelegate = self;
        [self.view addSubview:_wkWebView];
        [_wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(navc_bar_h);
            make.left.right.bottom.offset(0);
        }];
        
        // 进度条初始化
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0,ScreenW,1.5)];
        _progressView.progressTintColor = color_theme;
        _progressView.trackTintColor = [UIColor clearColor] ;
        _progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        _progressView.progress = 0 ;
        _progressView.hidden = YES ;
        [self.view addSubview:_progressView];
        
        // 加载进度监控
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
//         WKUserContentController * control = [[WKUserContentController alloc]init];
//        [control addScriptMessageHandler:self name:@"xxxxxxxxxx"];
        [_wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"backUpPage"];
        
    }
    return _wkWebView;
}


// 监控web加载进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [_progressView setProgress:self.wkWebView.estimatedProgress animated:YES];
        if (_progressView.progress == 1) {
            _progressView.hidden = YES ;
            _progressView.progress = 0 ;
        }
    }
    
}


#pragma mark ===>>> WKWebView代理

//#pragma mark - wkwebview信任https接口
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
//    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
//        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
//        completionHandler(NSURLSessionAuthChallengeUseCredential, card);
//    }
//}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
//    NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
//    NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//        [cookieDic setObject:cookie.value forKey:cookie.name];
//    }
//    for (NSString *key in cookieDic) {
//        NSString *appendString = [NSString stringWithFormat:@"%@=%@;", key, [cookieDic valueForKey:key]];
//        [cookieValue appendString:appendString];
//    }
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:webView.URL];
//    [request addValue:cookieValue forHTTPHeaderField:@"Cookie"];
    
    
    NSString * urlString = navigationAction.request.URL.absoluteString;
    C_LOG(@"将要开始加载的链接或参数: %@",urlString)
        
    decisionHandler(WKNavigationActionPolicyAllow);
    
//    if ([urlString hasPrefix:@"http"]) {  // 允许跳转
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }else if ([[UIApplication sharedApplication]canOpenURL:navigationAction.request.URL]){
//        [[UIApplication sharedApplication]openURL:navigationAction.request.URL];
//        decisionHandler(WKNavigationActionPolicyCancel);
//    }else{ decisionHandler(WKNavigationActionPolicyAllow); }

}

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) { [webView loadRequest:navigationAction.request]; }
    return nil;
}

// 开始加载webUrl
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    C_LOG(@"网页开始加载。。。。");
    _progressView.hidden = NO;
    _progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view bringSubviewToFront:_progressView];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// 加载失败！
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    C_LOG(@"加载失败：\n%@",error)
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// 加载完成
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    if (webView.title.length>0) {
        self.title = webView.title;
        self.barTitLab.text = webView.title;
    }
    
    if (!webView.isLoading) {
        _progressView.hidden = YES;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }

    // .innerHTML(获取html文本)
    // document.documentElement.innerHTML
    // document.body.innerHTML
    // document.title
    // document.cookie
    
    NSString *jsCodeString = @"document.cookie";
    [webView evaluateJavaScript:jsCodeString completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error) {
        if (htmlStr) {
            NSLog(@"js执行后获取到的内容：\n%@",htmlStr);
        } else if (error) {
            NSLog(@"js执行错误：\n%@",error);
        } else {
            NSLog(@"其它。。。");
        }
    }];
    
}
// 接收到需要重定向请求
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    C_LOG(@"接收到需要重定向的要求。。。")
}
//加载失败时执行
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    C_LOG(@"ProvisionalNavigation失败:\n\n%@\n\n%@",navigation,error)
}


-(void)addLeftButtonItem{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"new_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickGoBackBtnObjc) forControlEvents:UIControlEventTouchUpInside];
    backButton.bounds = CGRectMake(0, 0, 50, 44);
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -34, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    // 右侧按钮
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton setTitleColor:color_blue forState:(UIControlStateNormal)];
    [rightButton setTitleColor:[UIColor grayColor] forState:(UIControlStateHighlighted)];
    [rightButton setTitle:@"测试" forState:(UIControlStateNormal)];
    rightButton.titleLabel.font = font_s(15);
    [rightButton addTarget:self action:@selector(clickTest) forControlEvents:UIControlEventTouchUpInside];
    rightButton.bounds = CGRectMake(0, 0, 50, 44);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}

-(void)clickTest{
    NSString *callJS = @"testMyFunction(\"哇哇哇哇哈哈哈哈哈哈哈，测试测试\")";
    [_wkWebView evaluateJavaScript:callJS completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"response -> %@  error -> %@",response,error);
    }];

}


-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"%@",message.name);
    [self clickClose];
}





// 关闭页面
-(void)clickClose{
    if (self.navigationController==nil) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// 返回上一级
-(void)clickGoBackBtnObjc{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO ;
    if (_wkWebView.canGoBack==YES) {
        [_wkWebView goBack];
    }else{
        if (self.navigationController==nil) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"backUpPage"];
}


@end
