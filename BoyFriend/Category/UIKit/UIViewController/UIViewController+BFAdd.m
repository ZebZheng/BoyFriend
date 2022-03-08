/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "UIViewController+BFAdd.h"
#import "BFNavigationButton.h"
#import "UIImage+BFInit.h"
#import "UIButton+BFAdd.h"
#import <objc/runtime.h>

static const char itemKey;
static const char ritemKey;

static const char leftItemsKey;
static const char rightItemsKey;

typedef void(^NavBlock)(void);

typedef void(^RightNavBlock)(void);

typedef void(^LeftNavItemsBlock)(NSInteger);

typedef void(^TitleNavItemsBlock)(void);
typedef void(^RightNavItemsBlock)(NSInteger);

@interface UIViewController ()


@end

@implementation UIViewController (BFAdd)

#pragma make ------ 导航返回按钮 ------
- (void)bf_navBackItem:(UIImage *)image {
    [self bf_navBackItem:image closeItem:image];
}

- (void)bf_navTitle:(NSString *)title backItem:(BOOL)show {
    [self bf_navTitle:title];
    if (show) {
        [self bf_navBackItem:[UIImage imageNamed:@"nav_back"] closeItem:[UIImage imageNamed:@"nav_close"]];
    }
    else {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }
}

- (void)bf_navBackItem:(UIImage *)image closeItem:(UIImage *)closeImage {
    if (self.navigationController.viewControllers.count == 1 && self.presentingViewController) {
        self.navigationItem.leftBarButtonItem = [self bf_navItemWithImage:closeImage
                                                                 title:(closeImage ? nil : @"ㄨ")
                                                                action:@selector(bf_backViewController)];
    }
    else if ((self.navigationController.viewControllers.count > 1 || (!self.navigationController && !self.parentViewController))) {
        UIBarButtonItem *backItem = [self bf_navItemWithImage:image
                                                     title:(image ? nil : @"ㄑ")
                                                    action:@selector(bf_backViewController)];
        self.navigationItem.leftBarButtonItems = @[backItem];
    }
    else {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }
    ((UIButton *)self.navigationItem.leftBarButtonItem.customView).contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

#pragma make ------ 导航标题 ------
- (void)bf_navTitle:(NSString *)title {
    [self bf_navTitle:title color: UIColor.blackColor];
}

- (void)bf_navTitle:(NSString *)title color:(UIColor *)color {
    [self bf_navTitle:title color:color font:[UIFont systemFontOfSize:17]];
}
- (void)bf_navTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font {
    self.navigationItem.title = title;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : color}];
    [self color:color font:font backgroundColor:UIColor.whiteColor];
}
- (void)color:(UIColor *)color font:(UIFont *)font backgroundColor:(UIColor *_Nullable)backgroundColor {
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithTransparentBackground];
        self.navigationController.navigationBar.translucent = NO;
        if (backgroundColor == UIColor.clearColor) {
            self.navigationController.navigationBar.translucent = YES;
            appearance.backgroundImage = [UIImage bf_imageWithColor:UIColor.clearColor];
            appearance.backgroundColor = backgroundColor;
        } else {
            appearance.backgroundImage = [UIImage bf_imageWithColor:backgroundColor];
            appearance.backgroundColor = backgroundColor;
        }
        appearance.shadowImage = [UIImage bf_imageWithColor:UIColor.clearColor];
        appearance.shadowColor = UIColor.clearColor;
        appearance.titleTextAttributes = @{NSForegroundColorAttributeName: color,NSFontAttributeName:font};
        [self addNavigationBarAppearance:appearance];
    } else {
        self.navigationController.navigationBar.translucent = NO;
        if (backgroundColor == UIColor.clearColor) {
            self.navigationController.navigationBar.translucent = YES;
            [self.navigationController.navigationBar setBackgroundImage:UIImage.alloc.init forBarMetrics:(UIBarMetricsDefault)];
        } else {
            [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:(UIBarMetricsDefault)];
            self.navigationController.navigationBar.barTintColor = backgroundColor;
        }
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName: color}];
    }
}
- (void)addNavigationBarAppearance:(UINavigationBarAppearance *)appearance  API_AVAILABLE(ios(13.0)){
    ///带scroll滑动的页面
    self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    /// 常规页面
    self.navigationController.navigationBar.standardAppearance = appearance;
}


- (void)bf_navTitleView:(UIView *)titleView {
    self.navigationItem.titleView = titleView;
}

#pragma mark -----  导航按钮 -----
- (UIBarButtonItem *)bf_navItemWithImage:(UIImage *)image action:(SEL)action {
    return [self bf_navItemWithImage:image title:nil color:nil action:action];
}

- (UIBarButtonItem *)bf_navItemWithTitle:(NSString *)title action:(SEL)action {
    return [self bf_navItemWithImage:nil title:title color:nil action:action];
}

- (UIBarButtonItem *)bf_navItemWithTitle:(NSString *)title color:(UIColor *)color action:(SEL)action {
    return [self bf_navItemWithImage:nil title:title color:color action:action];
}

- (UIBarButtonItem *)bf_navItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action {
    return [self bf_navItemWithImage:image title:title color:nil action:action];
}

- (UIBarButtonItem *)bf_navItemWithImage:(nullable UIImage *)image title:(nullable NSString *)title color:(nullable UIColor *)color action:(SEL)action {
    return [self bf_navItemWithImage:image title:title color:color target:self action:action];
}
- (UIBarButtonItem *)bf_navItemWithImage:(nullable UIImage *)image title:(nullable NSString *)title color:(nullable UIColor *)color target:(id)target action:(SEL)action {
    BFBarButton *button = [BFBarButton buttonWithImage:image title:title color:color target:self action:action];
    button.frame = CGRectMake(10, 0, 44, 44);
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark -----  导航 左按钮 -----
- (void)bf_navLeftItemWithImage:(UIImage *)image action:(SEL)action {
    [self bf_navLeftItemWithImage:image title:nil color:UIColor.blackColor action:action];
}

- (void)bf_navLeftItemWithTitle:(NSString *)title action:(SEL)action {
    [self bf_navLeftItemWithImage:nil title:title color:UIColor.blackColor action:action];
}

- (void)bf_navLeftItemWithTitle:(NSString *)title color:(UIColor *)color action:(SEL)action {
    [self bf_navLeftItemWithImage:nil title:title color:color action:action];
}

- (void)bf_navLeftItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action {
    [self bf_navLeftItemWithImage:image title:title color:UIColor.blackColor action:action];
}

- (void)bf_navLeftItemWithImage:(UIImage *)image title:(NSString *)title color:(UIColor *)color action:(SEL)action {
    BFBarButton *button = [BFBarButton buttonWithImage:image title:title color:color target:self action:action];
    button.frame = CGRectMake(10, 0, 44, 44);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
#pragma mark -----  导航 左按钮 多个 -----

- (void)bf_navLeftItemsWithImages:(NSArray<UIImage *> *)images action:(SEL)action {
    [self bf_navLeftItemsWithImages:images titles:nil color:nil action:action];
}

- (void)bf_navLeftItemsWithTitles:(NSArray<NSString *> *)titles action:(SEL)action {
    [self bf_navLeftItemsWithImages:nil titles:titles color:nil action:action];
}

- (void)bf_navLeftItemsWithTitles:(NSArray <NSString *> *)titles colors:(NSArray<UIColor *> *)colors action:(SEL)action {
    [self bf_navLeftItemsWithImages:nil titles:titles color:colors action:action];
}

- (void)bf_navLeftItemsWithImages:(NSArray<UIImage *> *)images actionBlock:(void(^)(NSInteger tag))block {
    if (block) {
        objc_setAssociatedObject(self, &leftItemsKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navLeftItemsWithImages:images titles:nil color:nil action:@selector(leftItemsAction:)];
}

- (void)bf_navLeftItemsWithTitles:(NSArray<NSString *> *)titles actionBlock:(void(^)(NSInteger tag))block {
    if (block) {
        objc_setAssociatedObject(self, &leftItemsKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navLeftItemsWithImages:nil titles:titles color:nil action:@selector(leftItemsAction:)];
}

- (void)bf_navLeftItemsWithTitles:(NSArray <NSString *> *)titles colors:(NSArray<UIColor *> *)colors actionBlock:(void(^)(NSInteger tag))block {
    if (block) {
        objc_setAssociatedObject(self, &leftItemsKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navLeftItemsWithImages:nil titles:titles color:colors action:@selector(leftItemsAction:)];
}

- (void)bf_navLeftItemsWithImages:(NSArray <UIImage *> *)images titles:(NSArray *)titles color:(NSArray *)colors actionBlock:(void(^)(NSInteger tag))block {
    if (block) {
        objc_setAssociatedObject(self, &leftItemsKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navLeftItemsWithImages:images titles:titles color:colors action:@selector(leftItemsAction:)];
}

- (void)bf_navLeftItemsWithImages:(nullable NSArray <UIImage *> *)images titles:(nullable NSArray *)titles color:(NSArray *)colors action:(SEL)action {
    NSUInteger count = 0;
    if (images.count > titles.count) {
        count = images.count;
    } else {
        count = titles.count;
    }
    NSMutableArray * items = NSMutableArray.array;
    for (NSInteger i = 0; i < count; i++) {
        UIBarButtonItem *buttonItem;
        if (images != nil) {
            if (titles != nil) {
                buttonItem = [self bf_navItemWithImage:images[i] title:titles[i] color:colors[i] action:action];
            } else {
                buttonItem = [self bf_navItemWithImage:images[i] title:nil color:nil action:action];
            }
        } else {
            buttonItem = [self bf_navItemWithImage:nil title:titles[i] color:colors[i] action:action];
        }
        buttonItem.tag = i;
        [items addObject:buttonItem];
    }
    self.navigationItem.leftBarButtonItems = items;
}
- (void)leftItemsAction:(BFBarButton *)bar {
    [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * obj, NSUInteger idx, BOOL * stop) {
        if (obj.customView == bar) {
            LeftNavItemsBlock block = objc_getAssociatedObject(self, &leftItemsKey);
            block(idx);
        }
    }];
}


#pragma mark -----  导航 右按钮 -----
- (void)bf_navRightItemWithImage:(UIImage *)image action:(SEL)action {
    [self bf_navRightItemWithImage:image title:nil color:nil font:nil action:action];
}

- (void)bf_navRightItemWithTitle:(NSString *)title action:(SEL)action {
    [self bf_navRightItemWithImage:nil title:title color:nil font:nil action:action];
}

- (void)bf_navRightItemWithTitle:(NSString *)title color:(UIColor *)color action:(SEL)action {
    [self bf_navRightItemWithImage:nil title:title color:color  font:nil action:action];
}

- (void)bf_navRightItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action {
    [self bf_navRightItemWithImage:image title:title color:nil  font:nil action:action];
}
- (void)bf_navRightItemWithImage:(UIImage *)image title:(NSString *)title color:(nullable UIColor *)color action:(SEL)action {
    [self bf_navRightItemWithImage:image title:title color:color  font:nil action:action];
}
- (void)bf_navRightItemWithImage:(nullable UIImage *)image title:(nullable NSString *)title color:(nullable UIColor *)color font:(UIFont *)font action:(SEL)action {
    BFBarButton *button = [BFBarButton buttonWithImage:image title:title color:color target:self action:action];
    button.bf_font = font;
    button.frame = CGRectMake(10, 0, 44, 44);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

/** 导航 左按钮 文 */
- (void)bf_navLeftItemWithTitle:(NSString *)title actionBlock:(void(^)(void))block {
    if (block) {
        objc_setAssociatedObject(self, &itemKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navLeftItemWithTitle:title action:@selector(navBlockAction)];
}

- (void)bf_navLeftItemWithTitle:(NSString *)title color:(UIColor *)color actionBlock:(void(^)(void))block {
    if (block) {
        objc_setAssociatedObject(self, &itemKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navLeftItemWithTitle:title color:color action:@selector(navBlockAction)];
}

- (void)bf_navLeftItemWithImage:(UIImage *)image actionBlock:(void(^)(void))block; {
    if (block) {
        objc_setAssociatedObject(self, &itemKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navLeftItemWithImage:image action:@selector(navBlockAction)];
}

- (void)bf_navLeftItemWithImage:(UIImage *)image title:(NSString *)title actionBlock:(void (^)(void))block {
    if (block) {
        objc_setAssociatedObject(self, &itemKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navLeftItemWithImage:image title:title action:@selector(navBlockAction)];
}

- (void)bf_navLeftItemWithImage:(UIImage *)image title:(NSString *)title color:(UIColor *)color actionBlock:(void (^)(void))block {
    if (block) {
        objc_setAssociatedObject(self, &itemKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navLeftItemWithImage:image title:title color:color action:@selector(navBlockAction)];
}

/** 导航 右按钮 文 */
- (void)bf_navRightItemWithTitle:(NSString *)title actionBlock:(void(^)(void))block{
    if (block) {
        objc_setAssociatedObject(self, &ritemKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navRightItemWithTitle:title action:@selector(rightNavBlockAction)];
}

- (void)bf_navRightItemWithTitle:(NSString *)title color:(UIColor *)color actionBlock:(void(^)(void))block{
    if (block) {
        objc_setAssociatedObject(self, &ritemKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navRightItemWithTitle:title color:color action:@selector(rightNavBlockAction)];
}

- (void)bf_navRightItemWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font action:(SEL)action {
    [self bf_navRightItemWithImage:nil title:title color:color font:font action:action];
}
- (void)bf_navRightItemWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font actionBlock:(void(^)(void))block {
    if (block) {
        objc_setAssociatedObject(self, &ritemKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navRightItemWithTitle:title color:color  font:font action:@selector(rightNavBlockAction)];
}



/** 导航 右按钮 图 */
- (void)bf_navRightItemWithImage:(UIImage *)image actionBlock:(void(^)(void))block{
    if (block) {
        objc_setAssociatedObject(self, &ritemKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navRightItemWithImage:image action:@selector(rightNavBlockAction)];
}

- (void)bf_navRightItemWithImage:(UIImage *)image title:(NSString *)title actionBlock:(void (^)(void))block {
    if (block) {
        objc_setAssociatedObject(self, &itemKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navRightItemWithImage:image title:title action:@selector(rightNavBlockAction)];
}
- (void)bf_navRightItemWithImage:(UIImage *)image title:(NSString *)title color:(UIColor *)color actionBlock:(void (^)(void))block {
    if (block) {
        objc_setAssociatedObject(self, &itemKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navRightItemWithImage:image title:title color:color action:@selector(rightNavBlockAction)];
}


- (void)rightNavBlockAction {
    RightNavBlock block = objc_getAssociatedObject(self, &ritemKey);
    block();
}

- (void)navBlockAction {
    NavBlock block = objc_getAssociatedObject(self, &itemKey);
    block();
}

#pragma make ------ 多个右按钮 ------

- (void)bf_navRightItemsWithImages:(NSArray<UIImage *> *)images action:(SEL)action {
    [self bf_navRightItemsWithImages:images titles:nil color:nil action:action];
}

- (void)bf_navRightItemsWithTitles:(NSArray<NSString *> *)titles action:(SEL)action {
    [self bf_navRightItemsWithImages:nil titles:titles color:nil action:action];
}

- (void)bf_navRightItemsWithTitles:(NSArray <NSString *> *)titles colors:(NSArray<UIColor *> *)colors action:(SEL)action {
    [self bf_navRightItemsWithImages:nil titles:titles color:colors action:action];
}

- (void)bf_navRightItemsWithImages:(NSArray<UIImage *> *)images actionBlock:(void(^)(NSInteger tag))block {
    if (block) {
        objc_setAssociatedObject(self, &rightItemsKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navRightItemsWithImages:images titles:nil color:nil action:@selector(rightItemsAction:)];
}

- (void)bf_navRightItemsWithTitles:(NSArray<NSString *> *)titles actionBlock:(void(^)(NSInteger tag))block {
    if (block) {
        objc_setAssociatedObject(self, &rightItemsKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navRightItemsWithImages:nil titles:titles color:nil action:@selector(rightItemsAction:)];
}

- (void)bf_navRightItemsWithTitles:(NSArray<NSString *> *)titles colors:(NSArray<UIColor *> *)colors actionBlock:(void(^)(NSInteger tag))block {
    if (block) {
        objc_setAssociatedObject(self, &rightItemsKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navRightItemsWithImages:nil titles:titles color:colors action:@selector(rightItemsAction:)];
}
- (void)bf_navRightItemsWithImages:(NSArray <UIImage *> *)images titles:(NSArray *)titles color:(NSArray *)colors actionBlock:(void(^)(NSInteger tag))block {
    if (block) {
        objc_setAssociatedObject(self, &rightItemsKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self bf_navRightItemsWithImages:images titles:titles color:colors action:@selector(rightItemsAction:)];
}

- (void)bf_navRightItemsWithImages:(nullable NSArray <UIImage *> *)images titles:(nullable NSArray *)titles color:(nullable NSArray *)colors action:(SEL)action {
    NSUInteger count = 0;
    if (images.count > titles.count) {
        count = images.count;
    } else {
        count = titles.count;
    }
    NSMutableArray * items = NSMutableArray.array;
    for (NSInteger i = 0; i < count; i++) {
        UIBarButtonItem *buttonItem;
        if (images != nil) {
            if (titles != nil) {
                buttonItem = [self bf_navItemWithImage:images[i] title:titles[i] color:colors[i] action:action];
            } else {
                buttonItem = [self bf_navItemWithImage:images[i] title:nil color:nil action:action];
            }
        } else {
            buttonItem = [self bf_navItemWithImage:nil title:titles[i] color:colors[i] action:action];
        }
        buttonItem.tag = i;
        [items addObject:buttonItem];
    }
    self.navigationItem.rightBarButtonItems = items;
}
- (void)rightItemsAction:(BFBarButton *)bar {
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * obj, NSUInteger idx, BOOL * stop) {
        if (obj.customView == bar) {
            RightNavItemsBlock block = objc_getAssociatedObject(self, &rightItemsKey);
            block(idx);
        }
    }];
}

#pragma mark -----  返回 -----
- (void)bf_backViewController {
    [self bf_backViewController:YES];
}

- (void)bf_backViewController:(BOOL)animated {
    @try {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:animated];
        }
        else if (self.presentingViewController) {
            [self dismissViewControllerAnimated:animated completion:nil];
            [self.view endEditing:YES];
        }
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}

#pragma mark -----  跳转 -----
- (void)bf_dismissOrPopToRootControlelr {
    [self bf_dismissOrPopToRootControlelr:YES];
}
- (void)bf_dismissOrPopToRootControlelr:(BOOL)animated {
    @try {
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:animated completion:nil];
            [self.view endEditing:YES];
        }
        else if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popToRootViewControllerAnimated:animated];
        }
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}

- (instancetype)bf_rootTopPresentedViewController {
    return [self bf_rootTopPresentedViewControllerWihtKeys:@[@"centerViewController"]];
}

- (instancetype)bf_rootTopPresentedViewControllerWihtKeys:(NSArray<NSString *> *)keys {
    UIViewController *rootVC = self;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)rootVC;
        UIViewController *vc = tab.selectedViewController ?: tab.childViewControllers.firstObject;
        if (vc) {
            return [vc bf_rootTopPresentedViewController];
        }
    }
    for (NSString *key in keys) {
        if ([rootVC respondsToSelector:NSSelectorFromString(key)]) {
            UIViewController *vc;
            @try {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                vc = [rootVC performSelector:NSSelectorFromString(key)];
#pragma clang diagnostic pop
            } @catch (NSException *exception) {
            }
            if ([vc isKindOfClass:[UIViewController class]]) {
                return [vc bf_rootTopPresentedViewController];
            }
        }
    }
    while (rootVC.presentedViewController) {
        rootVC = rootVC.presentedViewController;
    }
    return rootVC;
}

+ (instancetype)bf_rootTopPresentedViewController {
    return [[[UIApplication sharedApplication] delegate] window].rootViewController.bf_rootTopPresentedViewController;
}

- (NSArray<UIViewController *> *)bf_optimizeViewControllers:(NSArray<UIViewController *> *)vcs {
    return [self bf_optimizeViewControllers:vcs maxCount:1];
}

- (NSArray<UIViewController *> *)bf_optimizeViewControllers:(NSArray<UIViewController *> *)vcs maxCount:(NSUInteger)count {
    NSMutableArray *vcArray = [NSMutableArray arrayWithArray:vcs];
    [vcArray addObject:self];
    for (UIViewController *vc in vcArray.reverseObjectEnumerator) {
        if ([vc isKindOfClass:[self class]]) {
            if (count) {
                count--;
            }
            else {
                [vcArray removeObject:vc];
            }
        }
    }
    return vcArray.copy;
}

-(void)bf_pushViewController:(UIViewController *)viewController {
    [self bf_pushViewController:viewController animated:YES];
}
-(void)bf_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.navigationController.viewControllers.count > 0 ) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:viewController animated:animated];
}

@end
