//
//  BaseWebViewController.m
//  Demon
//
//  Created by BoyFriend on 16/2/10.
//  Copyright © 2016年 BoyFriend. All rights reserved.
//

#import "BaseWebViewController.h"
#import "TZImageManager.h"


@interface BaseWebViewController () 


@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, strong) UILabel *authLabel;

/**
 * 下拉刷新
 */
@property (nonatomic,strong) UIRefreshControl *refreshControl;

// 是否是下拉刷新操作
@property (nonatomic, assign) BOOL isDropDownRefresh;

@end

@implementation BaseWebViewController

- (id)init{
    if (self = [super init]) {
        self.useMPageTitleAsNavTitle = YES;
        self.showLoadingProgress = YES;
        self.nowURLStr=@"";
        self.isDismiss = NO;
        self.isDropDownRefresh = NO;
    }
    return self;
}

- (void)loadView{
    [super loadView];
    [self.view addSubview:self.authLabel];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [self initWebViewBridge];
    
    [self.view setBackgroundColor:BFRGB_BgColor];
    [self.webView.scrollView setBackgroundColor:[UIColor clearColor]];
    for (id vc in self.webView.scrollView.subviews) {
        NSString *className = NSStringFromClass([vc class]);
        if ([className isEqualToString:@"WKContentView"]) {
            [vc setBackgroundColor:[UIColor whiteColor]];
            break;
        }
    }
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView.scrollView addObserver:self forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:NULL];

}
/**
 * 刷新网页
 */
-(void)reloadThisWebView{
    if (self.webView.URL == nil) {
        [self setUrl:_url];
    } else {
        [self.webView reload];
    }
}
- (void)initWebViewBridge {
    [self.bridge setWebViewDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationItem.leftBarButtonItems.count <= 2) {
        [self.navigationItem setLeftBarButtonItems:@[self.backButtonItem]];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}


- (void)dealloc
{
    [_webView removeObserver:self forKeyPath:@"title"];
    [_webView removeObserver:self forKeyPath:@"URL"];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView.scrollView removeObserver:self forKeyPath:@"backgroundColor"];
    [_webView removeFromSuperview];
    _webView.scrollView.delegate = nil;
    _webView.navigationDelegate = nil;
    _webView.UIDelegate=nil;
    _webView = nil;
    [self.bridge setWebViewDelegate:nil];

    BFDEBUG(@"网页VC释放---:%@",[self class]);
}


#pragma mark - Public Methods -
- (void)setUrl:(NSString *)url{
    //去除空格
    url=[BFStringTools trimString:url];
    _url = url;
    [self.progressView setProgress:0.0f];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    request.timeoutInterval = BFApi_RequestTimeoutInterval;
    NSString *token = [BFUserDefaults objectForKey:@"token"];
    [request addValue:token forHTTPHeaderField:@"token"];
    [request addValue:BFApi_ClientType forHTTPHeaderField:@"client_type"];

    
    [self.webView loadRequest:request];
}

- (void)setShowLoadingProgress:(BOOL)showLoadingProgress{
    _showLoadingProgress = showLoadingProgress;
    [self.progressView setHidden:!showLoadingProgress];
}

#pragma mark - Private methods

- (void)updateLeftBarButton {
    if (self.webView.canGoBack) {
        [self.navigationItem setLeftBarButtonItems:@[self.backButtonItem, self.closeButtonItem]];
    } else {
        [self.navigationItem setLeftBarButtonItems:@[self.backButtonItem,[UIBarButtonItem fixItemSpace:View_Navbar_Items_Fixed_Space]]];
    }
}

#pragma mark - Event Response -
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"] && object == self.webView) {
        [self.progressView setHidden:!self.showLoadingProgress];
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if(self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else if ([keyPath isEqualToString:@"backgroundColor"] && object == self.webView.scrollView) {
        UIColor *color = [change objectForKey:@"new"];
        if (!CGColorEqualToColor(color.CGColor, [UIColor clearColor].CGColor)) {
            [object setBackgroundColor:[UIColor clearColor]];
        }
    }
    //网页title
    else if ([keyPath isEqualToString:@"title"]){
        if (object == self.webView){
            self.nowTitleStr=self.webView.title;
            if (self.useMPageTitleAsNavTitle) {
                [self.navigationItem setTitle:self.webView.title];
            }
        }
        else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    //网页地址
    else if ([keyPath isEqualToString:@"URL"]){
        if (object == self.webView){
            self.nowURLStr=[NSString stringWithFormat:@"%@",self.webView.URL];
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)navBackButotnDown{
    if (self.isDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        if (self.webView.canGoBack) {
            [self.webView goBack];
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)navCloseButtonDown{
    if (self.isDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 * 下拉刷新事件
 */
-(void)webViewReload{
    if (_webView.hidden) {
        _webView.hidden = NO;
    }
    self.isDropDownRefresh = YES;
    [self.webView reload];
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)sender{
    if (sender.state != UIGestureRecognizerStateBegan) {
        return;
    }
    CGPoint touchPoint = [sender locationInView:self.webView];
    // 获取长按位置对应的图片url的JS代码
    NSString *imgJS = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
    // 执行对应的JS代码 获取url
    [self.webView evaluateJavaScript:imgJS completionHandler:^(id _Nullable imgUrl, NSError * _Nullable error) {
        if (imgUrl) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            UIImage *image = [UIImage imageWithData:data];
            if (!image) {
                BFDEBUG(@"读取图片失败");
                [MBProgressHUD showErrorMessage:@"读取图片失败"];
                return;
            }
            [UIAlertController bf_presentActionControllerWithTitle:nil actionTitles:@[@"保存图片"] completeBlock:^(NSString *selectTitleString, NSUInteger index) {
                //判断是否有相册权限
                [BFSystemUtils isAllowPhotoLibraryCompleted:^(BOOL granted) {
                    if (granted) {
                        [BFSystemUtils saveImageToSystemAlbum:image];
                    }
                }];
            }];

        }
    }];
}
#pragma mark - Delegate -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
// 准备加载页面
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.nowURLStr=[NSString stringWithFormat:@"%@",webView.URL];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.isLoadingCompleted = NO;
    
    BFBlock_Safe_Calls(self.webViewStarLoadingBlock);
}

// 内容开始加载 (view的过渡动画可在此方法中加载)`
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    self.isLoadingCompleted = NO;
    
}

// 加载完成 (view的过渡动画的移除可在此方法中进行)
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    // 不执行前段界面弹出列表的JS代码
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.nowURLStr=[NSString stringWithFormat:@"%@",webView.URL];

    if (self.useMPageTitleAsNavTitle) {
        [self.authLabel setText:[NSString stringWithFormat:@"网页由 %@ 提供", webView.URL.host]];
        [self.authLabel setHeight:[self.authLabel sizeThatFits:CGSizeMake(self.authLabel.width, MAXFLOAT)].height];
    }
    [self.webView bf_removePlaceholderView];
    [self updateLeftBarButton];
    self.isLoadingCompleted = YES;
    
    if (self.isDropDownRefresh) {
        self.isDropDownRefresh = NO;
        BFBlock_Safe_Calls(self.webViewDropDownRefreshFinishBlock, YES);
    }
    BFBlock_Safe_Calls(self.webViewLoadFinishBlock, self.webView.canGoBack);
}

// 加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    /// -999 上一页面还没加载完，就加载当下一页面，就会报这个错。
    if (error.code != NSURLErrorCancelled) {// 处在这个错误的时候，不显示 错误页
        if (error.code == NSURLErrorNotConnectedToInternet) {//无网络
            @weakify(self);
            [self.webView bf_showPlaceholderViewWithType:BFPlaceholderViewTypeNoNet reloadBlock:^{
                @strongify(self);
                [self reloadThisWebView];
                BFBlock_Safe_Calls(self.webViewAgainReloadBlock);
            }];
        } else {

            [self.webView bf_showPlaceholderViewWithType:BFPlaceholderViewType404NoButton reloadBlock:^{
            }];
        }
    }
    
    [self updateLeftBarButton];
    self.isLoadingCompleted = YES;
    
    if (self.isDropDownRefresh) {
        self.isDropDownRefresh = NO;
        BFBlock_Safe_Calls(self.webViewDropDownRefreshFinishBlock, NO);
    }
    BFBlock_Safe_Calls(self.webViewLoadFailBlock, self.webView.canGoBack);
}




// 页面跳转处理
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{

}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"tel"]) {
        NSString *resourceSpecifier = [URL resourceSpecifier];
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];
        /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [BFTool openSafariWithUrl:callPhone];
        });
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
//当 WKWebView 总体内存占用过大，页面即将白屏的时候，系统会调用上面的回调函数，我们在该函数里执行[webView reload](这个时候 webView.URL 取值尚不为 nil）解决白屏问题。
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    [webView reload];
}
////MARK: WKUIDelegate
//// web界面中有弹出警告框
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(nonnull NSString *)message initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(void))completionHandler
//{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil  preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        completionHandler();
//    }]];
//    
//    [self presentViewController:alertController animated:YES completion:^{}];
//}
//
//// web界面中有确认框
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(nonnull NSString *)message initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(BOOL))completionHandler
//{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
//                                                                             message:nil
//                                                                      preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
//                                                        style:UIAlertActionStyleDefault
//                                                      handler:^(UIAlertAction *action) {
//                                                          completionHandler(YES);
//                                                      }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
//                                                        style:UIAlertActionStyleCancel
//                                                      handler:^(UIAlertAction *action){
//                                                          completionHandler(NO);
//                                                      }]];
//    
//    [self presentViewController:alertController animated:YES completion:^{}];
//}
//
//// web界面中有弹出输入框
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(nonnull NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(NSString * _Nullable))completionHandler {
//    completionHandler(@"Client Not handler");
//}

#pragma mark - Getter -
- (UIRefreshControl* )refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc]init];
        [_refreshControl addTarget:self action:@selector(webViewReload) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}
- (WKWebView *)webView{
    if (_webView == nil) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.allowsAirPlayForMediaPlayback = YES;
        config.mediaTypesRequiringUserActionForPlayback = NO;
        config.allowsInlineMediaPlayback = YES;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,0, BFScreen_Width, BFScreen_Height) configuration:config];
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets=NO;
        }
        [_webView setAllowsBackForwardNavigationGestures:YES];
        [_webView setUIDelegate:self];
        _webView.opaque = NO;
        _webView.scrollView.backgroundColor = [UIColor whiteColor];
        _webView.backgroundColor = [UIColor whiteColor];
        [_webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        if (@available(iOS 10.0, *)) {
            _webView.scrollView.refreshControl=self.refreshControl;
        } else {
            // Fallback on earlier versions
        }
        _webView.navigationDelegate = self;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        longPress.minimumPressDuration = 1;
        longPress.delegate = self;
        [_webView addGestureRecognizer:longPress];
    }
    return _webView;
}

- (UIProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0,0, BFScreen_Width, 10.0f)];
        [_progressView setTransform: CGAffineTransformMakeScale(1.0f, 2.0f)];
        [_progressView setProgressTintColor:BFTheme_Color];
        [_progressView setTrackTintColor:[UIColor clearColor]];
    }
    return _progressView;
}

- (UIBarButtonItem *)backButtonItem{
    if (_backButtonItem == nil) {
        CommonsView *view = [CommonsView new];
        [view.backButton addTarget:self action:@selector(navBackButotnDown) forControlEvents:UIControlEventTouchUpInside];
        view.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view.backButton];
    }
    return _backButtonItem;
}

- (UIBarButtonItem *)closeButtonItem{
    if (_closeButtonItem == nil) {
        _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(navCloseButtonDown)];
        [_closeButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BFPFRFontWithSizes(16),NSFontAttributeName, nil] forState:UIControlStateNormal];
    }
    return _closeButtonItem;
}

- (UILabel *)authLabel{
    if (_authLabel == nil) {
        _authLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,13, BFScreen_Width - 40, 0)];
        [_authLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_authLabel setTextAlignment:NSTextAlignmentCenter];
        [_authLabel setTextColor:BFRGB_FontColor];
        [_authLabel setNumberOfLines:0];
    }
    return _authLabel;
}

-(WKWebViewJavascriptBridge *)bridge{
    if (!_bridge) {
        _bridge=[WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    }
    return _bridge;
}
@end





