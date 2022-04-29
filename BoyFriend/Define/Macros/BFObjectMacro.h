/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#ifndef BFObjectMacro_h
#define BFObjectMacro_h


#ifndef BFApplication
#define BFApplication            [UIApplication sharedApplication]
#endif
#ifndef BFKeyWindow
#define BFKeyWindow              [UIApplication sharedApplication].keyWindow
#endif
#ifndef BFAppDelegate
#define BFAppDelegate            [UIApplication sharedApplication].delegate
#endif
#ifndef BFUserDefaults
#define BFUserDefaults           [NSUserDefaults standardUserDefaults]
#endif
#ifndef BFNotificationCenter
#define BFNotificationCenter     [NSNotificationCenter defaultCenter]
#endif

//APP版本
#ifndef BFAppVersion
#define BFAppVersion             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#endif

//APP名称
#ifndef BFAppName
#define BFAppName        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#endif

//APPIcon名字
#ifndef BFAppIconName
#define BFAppIconName     [[[[NSBundle mainBundle] infoDictionary] valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject]
#endif

//APP BundleId
#ifndef BFAppBundleId
#define BFAppBundleId    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#endif

//获取当前语言
#ifndef BFCurrentLanguage
#define BFCurrentLanguage  ([[NSLocale preferredLanguages] objectAtIndex:0])
#endif

//手机别名： 用户定义的名称
#ifndef BFUserPhoneName
#define BFUserPhoneName  [[UIDevice currentDevice] name]
#endif

//获取当前手机所属国家代码
#ifndef BFLocaleCountryCode
#define BFLocaleCountryCode  ([[NSLocale currentLocale] objectForKey:NSLocaleCountryCode])
#endif

#endif /* BFObjectMacro_h */
