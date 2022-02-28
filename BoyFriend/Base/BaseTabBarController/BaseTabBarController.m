//
//  BaseTabBarController.m
//  Demon
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 BoyFriend. All rights reserved.
//

#import "BaseTabBarController.h"
#import "HomeViewController.h"
#import "ListViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"

#import "KBTabbar.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        [self setupTabBarController];
        [self initTabbarItemsAttributes];
//        // 设置自定义的tabbar
//        [self setCustomtabbar];

    }
    return self;
}


- (void)setCustomtabbar{
    
    KBTabbar *tabbar = [[KBTabbar alloc]init];
    [self setValue:tabbar forKeyPath:@"tabBar"];
    [tabbar.centerButton addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)centerBtnClick:(UIButton *)btn{
    BFDEBUG(@"中间按钮的点击事件");
    
}

- (void)setupTabBarController {
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self addChildVc:homeVC title:@"首页" image:@"xm1" selectedImage:@"xm2"];
    ListViewController *listVC = [[ListViewController alloc] init];
    [self addChildVc:listVC title:@"列表" image:@"gz1" selectedImage:@"gz2"];
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    [self addChildVc:messageVC title:@"消息" image:@"xx1" selectedImage:@"xx2"];
    MineViewController *profileVC = [[MineViewController alloc] init];
    [self addChildVc:profileVC title:@"我的" image:@"wd1" selectedImage:@"wd2"];
    [DataLibrery shareInstance].homeVCCode = 0;
    [DataLibrery shareInstance].listVCCode = 1;
    [DataLibrery shareInstance].messageVCCode = 2;
    [DataLibrery shareInstance].mineVCCode = 3;


}

-(void)initTabbarItemsAttributes{
    //设置tabBar字体颜色
    self.tabBar.tintColor = BFTheme_Color;
    //设置tabBar背景颜色
    [self setBarBackgroundColor:UIColor.whiteColor];

//    //  修改tabbar顶部分割线颜色
//    [self changeShadowLineColor];
}

//封装添加子控制器的方法

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    //设置标题
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //需要设置照片的模式，用照片原图，默认是蓝色的
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    //不要忘记添加到父控制器上
    [self addChildViewController:homeNav];
}

/**
 * 设置tabbar的背景颜色
 */
- (void)setBarBackgroundColor:(UIColor *)backgrondColor {
    if (@available(iOS 15, *)) {
#ifdef __IPHONE_15_0
        UITabBarAppearance * bar = [UITabBarAppearance.alloc init];
        bar.backgroundColor = backgrondColor;
        bar.shadowImage = [UIImage imageWithColor:backgrondColor];
        self.tabBar.scrollEdgeAppearance = bar;
        self.tabBar.standardAppearance = bar;
#endif

    } else {
        [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
        [self.tabBar setBackgroundImage:[UIImage imageWithColor:backgrondColor]];
    }

}

/**
 * 设置分割线的阴影
 */
-(void)changeShadow{
    UIView * tmpView = self.tabBar;
    tmpView.layer.shadowColor = [UIColor blackColor].CGColor;//设置阴影的颜色
    tmpView.layer.shadowOpacity = 0.08;//设置阴影的透明度
    tmpView.layer.shadowOffset = CGSizeMake(0, 0);//设置阴影的偏移量,阴影的大小，x往右和y往下是正
    tmpView.layer.shadowRadius = 5;//设置阴影的圆角,//阴影的扩散范围，相当于blur radius，也是shadow的渐变距离，从外围开始，往里渐变shadowRadius距离
}

//修改tabbar顶部分割线颜色
-(void)changeShadowLineColor{
    //改变tabbar 线条颜色
    CGRect rect = CGRectMake(0, 0, BFScreen_Width, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   BFRGB_BgColor.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
}


#pragma mark - UITabBarDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController{
    BOOL isDisVC = [viewController.topViewController isKindOfClass:[MessageViewController class]];
    if (isDisVC) {
        BFDEBUG(@"你点击了TabBar第三个");
        [self setBadgeValue:@""];
    }
}

#pragma mark - 设置底部消息数

-(void)setBadgeValue:(NSString*)value{
    
}

@end
