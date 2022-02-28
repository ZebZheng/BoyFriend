/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */
#ifndef BFFrameMacro_h
#define BFFrameMacro_h


#pragma mark - Screen Frame Macro
// 屏幕尺寸
#ifndef BFScreen_Width
#define BFScreen_Width               [UIScreen mainScreen].bounds.size.width
#endif

#ifndef BFScreen_Height
#define BFScreen_Height              [UIScreen mainScreen].bounds.size.height
#endif

#ifndef BFView_Width
#define BFView_Width                 self.view.frame.size.width
#endif

#ifndef BFView_Height
#define BFView_Height                self.view.frame.size.height
#endif

// 获取屏幕CGRect
//满屏CGRect
#define BFCGRectScreen             [UIScreen mainScreen].bounds
#define BFCGRectViewControl        CGRectMake(0,0, BFScreen_Width, BFScreen_Height-BFStatusAndNavHeight)
#define BFCGRectNOTabbarVC         CGRectMake(0,0, BFScreen_Width, BFScreen_Height-BFStatusAndNavHeight-BFBottomAndTabBarHeight)


//状态条占的高度
#ifndef BFStatusHeight
#define BFStatusHeight \
^(){\
if (@available(iOS 13.0, *)) {\
UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;\
return statusBarManager.statusBarFrame.size.height;\
} else {\
return [UIApplication sharedApplication].statusBarFrame.size.height;\
}\
}()
#endif

//导航栏高度
#ifndef BFNavBarHeight
#define BFNavBarHeight       (44.0)
#endif

//tabbar栏高度
#ifndef BFTabBarHeight
#define BFTabBarHeight       (49.0)
#endif
//底部安全区域
#ifndef BFBottomHeight
#define BFBottomHeight       ([[UIApplication sharedApplication] statusBarFrame].size.height>20.1?34.0:0.0)
#endif


/** 导航栏高度 + 状态栏高度 */
#ifndef BFStatusAndNavHeight
#define BFStatusAndNavHeight (BFNavBarHeight + BFStatusHeight)
#endif

/** tabbar高度 + iphoneX多出来的高度 */
#ifndef BFBottomAndTabBarHeight
#define BFBottomAndTabBarHeight (BFTabBarHeight + BFBottomHeight)
#endif

//------ 屏幕适配 -------
//UI那边定的尺寸
#define BFYourUIScreen 375.0  //适配字体及屏幕宽高基于的宽度(6/6s)
//比例计算,与 375 为比例
#ifndef BFProportion
#define BFProportion                BFScreen_Width / BFYourUIScreen
#endif
//长度换算 与375比例计算得到的
#ifndef BFRatio
#define BFRatio(k)                  ([BFTool smartSizeCalculate:k])//适配屏幕
#endif



//屏幕高度区别手机
#ifndef BFIPhone4
#define BFIPhone4    CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size, CGSizeMake(640, 960))
#endif
#ifndef BFIPhone5
#define BFIPhone5    CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size, CGSizeMake(640, 1136))
#endif
#ifndef BFIPhone6
#define BFIPhone6    CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size, CGSizeMake(750, 1334))
#endif
#ifndef BFIPhone6P
#define BFIPhone6P   CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size, CGSizeMake(1242, 2208)
#endif
#ifndef BFIPhoneX
#define BFIPhoneX                    (BFScreen_Height == 812)
#endif
//判断iphone6 放大模式(iphone7、iphone8) 放大模式下 [UIScreen mainScreen].nativeScale == 2.343750
#ifndef ISiPhone6_Magnify
#define ISiPhone6_Magnify           (BFIPhone5 && [UIScreen mainScreen].nativeScale > 2.3)
#endif
//判断iphone6+ 放大模式(iphone7+、iphone8+) 放大模式下 [UIScreen mainScreen].nativeScale == 2.880000
#ifndef ISiPhone6P_Magnify
#define ISiPhone6P_Magnify          ([UIScreen mainScreen].nativeScale > 2.8)
#endif




#endif /* BFFrameMacro_h */
