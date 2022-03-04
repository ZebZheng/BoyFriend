//
//  AppDelegate.m
//  Demon
//
//  Created by apple on 2019/1/16.
//  Copyright © 2019年 BoyFriend. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+TopSet.h"
#import "AppDelegate+Zeb.h"
#import "AppDelegate+Reachability.h"
#import "AppDelegate+Custom.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


//---------------程序 开始运行---------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 注意 这边要放在最顶层(里面可以初始化一些数据)
    [self topSetApplication:application didFinishLaunchingWithOptions:launchOptions];
    //网络监测(这个要放在最前面,检测网络)
    [self reachabilityApplication:application didFinishLaunchingWithOptions:launchOptions];
    //加载页面
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    [self customApplication:application didFinishLaunchingWithOptions:launchOptions];


    [self zebApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}


// iOS 9.0之后方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    BFDEBUG(@"URL scheme:%@", [url scheme]);
    return YES;
}

//---------------程序进入后台状态---------------
/*
 (程序在后台但是能执行代码)
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {

}

//---------------从后台状态将要进入前台---------------
- (void)applicationWillEnterForeground:(UIApplication *)application {

}

//---------------挂起状态---------------
/*
 (当有电话进来 或者 锁屏(拉下状态栏、双击Home键使App界面上移) 的时候，应用程会挂起,当程序被挂起后，程序将不会在后台运行并且也不能执行代码,有需要需要在这边保存数据)
 */
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

//---------------激活状态---------------
/*
 (你可以通过这边把之前挂起前保存的数据 用来恢复 你的应用程序)
 注意：应用程序在启动时，在调用了“applicationDidFinishLaunching”方法之后 同样也会 调用“applicationDidBecomeActive”方法!!!所以要确保你的代码能够分清 程序的复原与启动，避免出现逻辑上的bug
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {

}

//---------------即将终止时调用---------------
/*
 当用户 按下按钮 或者 关机，程序都会被终止
 但是如果点击主按钮 强制退出，则不会调用该方法。
 */
- (void)applicationWillTerminate:(UIApplication *)application {

}

//---------------获取设备的deviceToken传给SDK---------------
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    
}

//---------------发生内存警告的时候---------------
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    //清除内存中的图片
    //停止下载图片
    [[SDWebImageManager sharedManager] cancelAll];
    //移除下载到内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearWithCacheType:SDImageCacheTypeMemory completion:^{
        
    }];
}
@end
