/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (BFAdd)

#pragma make ------ 设置导航栏标题 ------
- (void)bf_navTitle:(NSString *)title;
- (void)bf_navTitle:(NSString *)title color:(UIColor *)color;
- (void)bf_navTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font;
- (void)bf_navTitleView:(UIView *)titleView;
/**
 *  导航栏 按钮，
 color为空时，表示默认颜色
 */
#pragma make ------ 导航 返回 ------
// 返回  图片为空时,为文字"<"
- (void)bf_navBackItem:(UIImage *)image;
- (void)bf_navBackItem:(UIImage *)image closeItem:(UIImage *)closeImage;
- (void)bf_navTitle:(NSString *)title backItem:(BOOL)show;

#pragma make ------ 导航 按钮 ------
/** 导航按钮 图片 */
- (UIBarButtonItem *)bf_navItemWithImage:(UIImage *)image action:(SEL)action;

/** 导航按钮 文字 */
- (UIBarButtonItem *)bf_navItemWithTitle:(NSString *)title action:(SEL)action;
- (UIBarButtonItem *)bf_navItemWithTitle:(NSString *)title color:(UIColor *)color action:(SEL)action;

/** 导航按钮 图文 */
- (UIBarButtonItem *)bf_navItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action;
- (UIBarButtonItem *)bf_navItemWithImage:(nullable UIImage *)image title:(nullable NSString *)title color:(nullable UIColor *)color action:(SEL)action;
- (UIBarButtonItem *)bf_navItemWithImage:(nullable UIImage *)image title:(nullable NSString *)title color:(nullable UIColor *)color target:(id)target action:(SEL)action;

#pragma make ------ 导航 左按钮 ------
/** 导航 左按钮 图片 */
- (void)bf_navLeftItemWithImage:(UIImage *)image action:(SEL)action;
- (void)bf_navLeftItemWithImage:(UIImage *)image actionBlock:(void(^)(void))block;

/** 导航 左按钮 文字 */
- (void)bf_navLeftItemWithTitle:(NSString *)title action:(SEL)action;
- (void)bf_navLeftItemWithTitle:(NSString *)title color:(UIColor *)color action:(SEL)action;
- (void)bf_navLeftItemWithTitle:(NSString *)title actionBlock:(void(^)(void))block;
- (void)bf_navLeftItemWithTitle:(NSString *)title color:(UIColor *)color actionBlock:(void(^)(void))block;

/** 导航 左按钮 图文 */
- (void)bf_navLeftItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action;
- (void)bf_navLeftItemWithImage:(nullable UIImage *)image title:(nullable NSString *)title color:(nullable UIColor *)color action:(SEL)action;
- (void)bf_navLeftItemWithImage:(UIImage *)image title:(NSString *)title actionBlock:(void(^)(void))block;
- (void)bf_navLeftItemWithImage:(nullable UIImage *)image title:(nullable NSString *)title color:(nullable UIColor *)color actionBlock:(void(^)(void))block;

#pragma make ------ 导航 右按钮 ------
/** 导航 右按钮 图片 */
- (void)bf_navRightItemWithImage:(UIImage *)image action:(SEL)action;
- (void)bf_navRightItemWithImage:(UIImage *)image actionBlock:(void(^)(void))block;

/** 导航 右按钮 文字 */
- (void)bf_navRightItemWithTitle:(NSString *)title action:(SEL)action;
- (void)bf_navRightItemWithTitle:(NSString *)title actionBlock:(void(^)(void))block;

- (void)bf_navRightItemWithTitle:(NSString *)title color:(UIColor *)color action:(SEL)action;
- (void)bf_navRightItemWithTitle:(NSString *)title color:(UIColor *)color actionBlock:(void(^)(void))block;

- (void)bf_navRightItemWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font action:(SEL)action;
- (void)bf_navRightItemWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font actionBlock:(void(^)(void))block;

/** 导航 右按钮 图文 */
- (void)bf_navRightItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action;
- (void)bf_navRightItemWithImage:(nullable UIImage *)image title:(nullable NSString *)title color:(nullable UIColor *)color action:(SEL)action;
- (void)bf_navRightItemWithImage:(UIImage *)image title:(NSString *)title actionBlock:(void(^)(void))block;
- (void)bf_navRightItemWithImage:(nullable UIImage *)image title:(nullable NSString *)title color:(nullable UIColor *)color actionBlock:(void(^)(void))block;

#pragma make ------ 导航 多按钮 ------
/** 文本*/
- (void)bf_navLeftItemsWithTitles:(NSArray<NSString *> *)titles action:(SEL)action;
- (void)bf_navLeftItemsWithTitles:(NSArray<NSString *> *)titles actionBlock:(void(^)(NSInteger tag))block;
- (void)bf_navLeftItemsWithTitles:(NSArray <NSString *> *)titles colors:(NSArray<UIColor *> *)colors actionBlock:(void(^)(NSInteger tag))block;
///图片
- (void)bf_navLeftItemsWithImages:(NSArray<UIImage *> *)images action:(SEL)action;
///图片
- (void)bf_navLeftItemsWithImages:(NSArray<UIImage *> *)images actionBlock:(void(^)(NSInteger tag))block;

///通用
- (void)bf_navLeftItemsWithImages:(nullable NSArray <UIImage *> *)images titles:(nullable NSArray *)titles color:(nullable NSArray *)colors action:(SEL)action;
- (void)bf_navLeftItemsWithImages:(nullable NSArray <UIImage *> *)images titles:(nullable NSArray *)titles color:(nullable NSArray *)colors actionBlock:(void(^)(NSInteger tag))block;

/** 文本*/
- (void)bf_navRightItemsWithTitles:(NSArray<NSString *> *)titles action:(SEL)action;
- (void)bf_navRightItemsWithTitles:(NSArray<NSString *> *)titles actionBlock:(void(^)(NSInteger tag))block;
- (void)bf_navRightItemsWithTitles:(nullable NSArray <NSString *> *)titles colors:(nullable NSArray<UIColor *> *)colors actionBlock:(void(^)(NSInteger tag))block;

///图片
- (void)bf_navRightItemsWithImages:(NSArray<UIImage *> *)images action:(SEL)action;
///图片
- (void)bf_navRightItemsWithImages:(NSArray<UIImage *> *)images actionBlock:(void(^)(NSInteger tag))block;

///通用
- (void)bf_navRightItemsWithImages:(nullable NSArray <UIImage *> *)images titles:(nullable NSArray *)titles color:(nullable NSArray *)colors action:(SEL)action;
- (void)bf_navRightItemsWithImages:(nullable NSArray <UIImage *> *)images titles:(nullable NSArray *)titles color:(nullable NSArray *)colors actionBlock:(void(^)(NSInteger tag))block;

/**
 *  返回上一个界面
 */
- (void)bf_backViewController;
- (void)bf_backViewController:(BOOL)animated;
/**
 *  返回主界面
 */
- (void)bf_dismissOrPopToRootControlelr;
- (void)bf_dismissOrPopToRootControlelr:(BOOL)animated;

/**
 *  获取根目录
 */
- (instancetype)bf_rootTopPresentedViewController;
- (instancetype)bf_rootTopPresentedViewControllerWihtKeys:(NSArray<NSString *> *)keys;

/**
 *  控制器数组中 仅存在一个实例
 */
- (NSArray<UIViewController *> *)bf_optimizeViewControllers:(NSArray<UIViewController *> *)vcs;
- (NSArray<UIViewController *> *)bf_optimizeViewControllers:(NSArray<UIViewController *> *)vcs maxCount:(NSUInteger)count;

/** push */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
