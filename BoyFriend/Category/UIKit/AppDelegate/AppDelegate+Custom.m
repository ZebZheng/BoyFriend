//
//  AppDelegate+Custom.m
//  Demon
//
//  Created by Apple on 2021/11/5.
//  Copyright © 2021 BoyFriend. All rights reserved.
//

#import "AppDelegate+Custom.h"
#import "AdvertiseHelper.h"

@implementation AppDelegate (Custom)



- (void)customApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    BFBIND_MSG(BFNotification_LoginChange, @selector(loginStateChange:));

    [self startLoadRootVC];

    
}

// 开始加载适合的 RootVC
- (void)startLoadRootVC {
//    if ([[DataLibrery shareInstance].loginToken isNotBlank]) { // 有 token 优先加载 Tabbar
        [self createTabBarVCAndSetup];
//    } else {
//        [self createLoginMianVCAndSetup];
//    }
}

// 创建 登录主界面，并设置
- (void)createLoginMianVCAndSetup {
    
//    if (!_loginPageVC) {
        self.loginPageVC = nil;
        self.loginPageVC = [BFLoginViewController new];
        BaseNavigationController *navigationVC = [[BaseNavigationController alloc]initWithRootViewController:self.loginPageVC];
        [self changeRootViewController:navigationVC];
        self.tabBarVC = nil;
//    }
}

// 创建 TabBar 主界面，并设置
- (void)createTabBarVCAndSetup {
    
    if (!self.tabBarVC) {
        self.tabBarVC = [[BaseTabBarController alloc]init];
        [self changeRootViewController:self.tabBarVC];
        
        self.loginPageVC = nil;
    }
}

// 切换根控制器
- (void)changeRootViewController:(UIViewController *)newRootViewController {
    if (!self.window.rootViewController) {
        self.window.rootViewController = newRootViewController;
        return;
    }
    UIView *snapshot = [self.window snapshotViewAfterScreenUpdates:NO];
    
    self.window.rootViewController = newRootViewController;
    [newRootViewController.view addSubview:snapshot];
    [UIView animateWithDuration:0.1 animations:^{
        snapshot.alpha = 0.0;
    } completion:^(BOOL finished) {
        [snapshot removeFromSuperview];
    }];
}



#pragma mark - Notification

// 根据登录状态切换主控制器窗口
- (void)loginStateChange:(NSNotification *)notification {
    BOOL loginSuccess = [notification.object boolValue];
    
    if (loginSuccess) {
        [self createTabBarVCAndSetup];
    } else {
        [self createLoginMianVCAndSetup];
    }
}



#pragma mark - action

//启动广告（记得放最后，才可以盖在页面上面）
-(void)setupAdveriseView{
    // TODO 请求广告接口 获取广告图片
    NSArray *imageArray = @[@"http://image.dev.jjnh.com/store/img/201812/e3a027139dca4ae48f8757ffc954c356-orig.png"];
    [AdvertiseHelper showAdvertiserView:imageArray];
}


@end
