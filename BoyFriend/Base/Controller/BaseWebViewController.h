//
//  BaseWebViewController.h
//  Demon
//
//  Created by BoyFriend on 16/2/10.
//  Copyright © 2016年 BoyFriend. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>
#import <WKWebViewJavascriptBridge.h>
#import "UIBarButtonItem+Action.h"



@interface BaseWebViewController : BaseViewController <WKNavigationDelegate, WKUIDelegate,UIGestureRecognizerDelegate>

/// 是否使用网页标题作为nav标题，默认YES
@property (nonatomic, assign) BOOL useMPageTitleAsNavTitle;

/// 是否显示加载进度，默认YES
@property (nonatomic, assign) BOOL showLoadingProgress;

@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) WKWebViewJavascriptBridge * bridge;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIBarButtonItem *backButtonItem;
@property (nonatomic, strong) UIBarButtonItem *closeButtonItem;

/**** 当前网页的地址 ****/
@property (nonatomic,copy) NSString * nowURLStr;
/**** 当前网页的标题 ****/
@property (nonatomic,copy) NSString * nowTitleStr;

// 点击返回的时候，返回方式是否是 dismiss, 默认 NO, 还是 pop
@property (nonatomic, assign) BOOL isDismiss;



// 是否已经加载完成(包括加载成功、加载失败)
@property (nonatomic, assign) BOOL isLoadingCompleted;

// 开始加载
@property (nonatomic, copy) void (^webViewStarLoadingBlock)(void);

// 完成加载(加载成功)
@property (nonatomic, copy) void (^webViewLoadFinishBlock)(BOOL isCanBackViewController);

// 加载失败
@property (nonatomic, copy) void (^webViewLoadFailBlock)(BOOL isCanBackViewController);

// 下拉刷新完成之后回调, success YES 表示走加载完成 ， NO 表示走加载失败
@property (nonatomic, copy) void (^webViewDropDownRefreshFinishBlock)(BOOL success);

// 无网络点击重新加载
@property (nonatomic, copy) void (^webViewAgainReloadBlock)(void);


/**
 * 刷新网页
 直接 self.webView reload 有时候webview的URL是nil的  需要调这个方法
 */
-(void)reloadThisWebView;


@end
