//
//  BaseNavigationController.m
//  Demon
//
//  Created by BoyFriend on 16/8/22.
//  Copyright © 2016年 BoyFriend. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController
- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    if (@available(iOS 13.0, *)) {
        // iOS15 系统下 push 后导航条变黑色 且 有卡顿
        UINavigationBarAppearance *barAppearance = [[UINavigationBarAppearance alloc] init];
        barAppearance.backgroundColor = [UIColor whiteColor];
        self.navigationBar.scrollEdgeAppearance = barAppearance;
        self.navigationBar.standardAppearance = barAppearance;
    } else {
        // Fallback on earlier versions
    }
    [self initNavigationProperty];
}


//初始化导航栏属性
-(void)initNavigationProperty{
    self.view.backgroundColor = BFRGB_FontColor;
    //设置导航栏和状态栏不透明
    [self.navigationBar setTranslucent:NO];
    //设置导航栏背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];

    //返回按钮字体颜色
    self.navigationBar.tintColor = BFRGB_FontColor;
    // 设置状态栏和状态栏样式，如果NavigationBar为深色调 就设置为 UIBarStyleBlack，则状态栏和导航栏title显示为白色
//    self.navigationBar.barStyle = UIBarStyleBlack;
    
    //设置导航条标题的字体和颜色
    NSDictionary* textAttributes = @{NSForegroundColorAttributeName:BFRGB_FontColor,NSFontAttributeName:BFPFRFontWithSizes(18)};
    [[UINavigationBar appearance]  setTitleTextAttributes:textAttributes];
//    //设置导航栏的背景图片
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_background"]forBarMetrics:UIBarMetricsDefault];

    //去掉导航栏底部的线(必须先设置BackgroundImage)
    // 当设置navigationBar的背景图片时移除黑线的方法,该方法会使translucent属性失效
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage imageWithColor:BFRGB_Line]];
}



-(UIViewController*)childViewControllerForStatusBarStyle{
    return self.topViewController;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        //第二级则隐藏底部Tab
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count == 1) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
