//
//  AppDelegate+Reachability.m
//  
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 BoyFriend. All rights reserved.
//

/*
 // 1.判断有无网络
 if ([AFNetworkReachabilityManager sharedManager].reachable) {
 [self loading];
 } else {
 }
 
 // 2.判断网络类型
 switch ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
 case AFNetworkReachabilityStatusNotReachable://无网络
 break;
 case AFNetworkReachabilityStatusReachableViaWiFi://通过 WiFi 连接
 break;
 case AFNetworkReachabilityStatusReachableViaWWAN:// 通过移动网络连接
 break;
 default:
 break;
 }
 
 */
#import "AppDelegate+Reachability.h"

@implementation AppDelegate (Reachability)

- (void)reachabilityApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // 开始监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 网络状态改变的回调
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                BFDEBUG(@"当前是蜂窝网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                BFDEBUG(@"当前是WIFI环境");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [MBProgressHUD showTipMessageInWindow:@"当前网络连接失败，请查看设置"];
                BFDEBUG(@"当前没有网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                BFDEBUG(@"未知网络");
                break;
            default:
                
                break;
        }
    }];
    //网络变化的监听(监听到变化,需要处理的再发相关通知出去处理)
    BFBIND_MSG(AFNetworkingReachabilityDidChangeNotification, @selector(netStatusChange:));
}

-(void)netStatusChange:(NSNotification *)notification{
    if (notification.userInfo!=nil) {
        NSDictionary *dic=notification.userInfo;
        AFNetworkReachabilityStatus status=[[dic objectForKey:@"AFNetworkingReachabilityNotificationStatusItem"]integerValue];
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                BFDEBUG(@"当前是蜂窝网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                BFDEBUG(@"当前是WIFI环境");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                BFDEBUG(@"当前没有网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                BFDEBUG(@"未知网络");
                break;
            default:

                break;
        }
    }

}
@end
