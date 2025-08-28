//
//  AppDelegate+TopSet.m
//  Demon
//
//  Created by apple on 2019/1/23.
//  Copyright © 2019年 BoyFriend. All rights reserved.
//  

#import "AppDelegate+TopSet.h"
#import "BFKeyChain.h"
#import "SDImageCache.h"
#import <SDImageWebPCoder.h>
#import <SDImageCodersManager.h>

#if __has_include(<Bugly/Bugly.h>)
#import <Bugly/Bugly.h>
#endif

@implementation AppDelegate (TopSet)

- (void)topSetApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
//    //不自动锁屏
//    [UIApplication sharedApplication].idleTimerDisabled = YES;
    //崩溃检测
    [self crashLogAction];
    //设置默认数据
    [[DataLibrery shareInstance] setHttpHeadData];
    //统一处理多控件 点击事件同时被点击 同时执行引起的问题
    [[UIView appearance] setExclusiveTouch:YES];
    //IQKeyboardManager
    [self configureBoardManager];
    //SDWebImage
    [self configSDWebImage];
    //iOS11相关配置
    [self configIOS11];
    //本机钥匙保存
    [self setupDeviceOnlyKey];
    
    //初始化单例数据
    [self initInstanceData];
}

/**
 * 初始化单例数据
 */
-(void)initInstanceData{

    AppCacheSQliteModel * cacheModel =[AppCacheSQliteModel getAppCacheSQLInfoFromDB];

    
    if ([cacheModel.token isNotBlank] && [cacheModel.loginUserId isNotBlank]) { // 有 token 优先加载 Tabbar
        //先取缓存的  刷新成功后需要再次赋值设置
        [[DataLibrery shareInstance] setCacheToken:cacheModel.token UserId:cacheModel.loginUserId];
        BFDEBUG(@"当前已登录  有token");
    } else {
        BFDEBUG(@"当前未登录 没有token");
    }
//    //这个要先写在下面  因为 要根据 loginUserId 去取
//    AppCacheUserSQliteModel * cacheUserModel = [AppCacheUserSQliteModel getAppCacheUserSQliteModelFromDB];
//    if (cacheUserModel == nil) {
//
//
//    } else {
//
//
//    }
}


#pragma mark - 键盘收回管理
-(void)configureBoardManager{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;// 控制整个功能是否启用
    manager.shouldResignOnTouchOutside = YES;// 控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor = YES;// 控制键盘上的工具条文字颜色是否用户自定义
    manager.keyboardDistanceFromTextField=60;// 输入框距离键盘的距离
    manager.enableAutoToolbar = NO;// 控制是否显示键盘上的工具条
    manager.toolbarManageBehavior = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    manager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    manager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
}

#pragma mark - SDWebImage
- (void)configSDWebImage {
    //硬盘存储最大空间(硬盘存储  最大时间 默认值是7天 -1 没有过期)
    [SDImageCacheConfig defaultCacheConfig].maxDiskSize = 1024 * 1024 * 1000; // 1G  // 0 不限制大小
    [SDImageCacheConfig defaultCacheConfig].maxDiskAge =  60 * 60 * 24 * 30;//30天   // -1 没有过期
    
    //SD支持webp格式 要添加一个附属库 pod 'SDWebImageWebPCoder'
    SDImageWebPCoder *webPCoder = [SDImageWebPCoder sharedCoder];
    [[SDImageCodersManager sharedManager] addCoder:webPCoder];
}

#pragma mark - Config iOS 11.0
- (void)configIOS11 {
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
}


#pragma mark - Setup Save UUID

- (void)setupDeviceOnlyKey {
    // uuid 存于手机内，卸载重新安装也不会变。
    //(可以通过这个来判断有没有安装APP等一些操作)
    [BFTool fetchDeviceOnlyKey];
}

#pragma mark - 崩溃 卡顿监测
-(void)crashLogAction{
#if __has_include(<Bugly/Bugly.h>)
#if DEBUG
#else
    //初始化Bugly
    [Bugly startWithAppId:BFBuglyAppid];
#endif
#endif

}



@end

/*
 //===============SDWebImageOptions=========
 //失败后重试
 SDWebImageRetryFailed = 1 << 0,
 
 //UI交互期间开始下载，导致延迟下载比如UIScrollView减速。
 SDWebImageLowPriority = 1 << 1,
 
 //只进行内存缓存
 SDWebImageCacheMemoryOnly = 1 << 2,
 
 //这个标志可以渐进式下载,显示的图像是逐步在下载
 SDWebImageProgressiveDownload = 1 << 3,
 
 //刷新缓存
 SDWebImageRefreshCached = 1 << 4,
 
 //后台下载
 SDWebImageContinueInBackground = 1 << 5,
 
 //NSMutableURLRequest.HTTPShouldHandleCookies = YES;
 
 SDWebImageHandleCookies = 1 << 6,
 
 //允许使用无效的SSL证书
 //SDWebImageAllowInvalidSSLCertificates = 1 << 7,
 
 //优先下载
 SDWebImageHighPriority = 1 << 8,
 
 //延迟占位符
 SDWebImageDelayPlaceholder = 1 << 9,
 
 //改变动画形象
 SDWebImageTransformAnimatedImage = 1 << 10,
 
 
 
 */
