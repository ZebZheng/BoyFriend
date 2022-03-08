/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

/**
 * 交互式pop转换无缝工作
 */

@interface UINavigationController (BFFullscreenPopGesture)

/// 实际处理交互式pop的手势识别器.
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *bf_fullscreenPopGestureRecognizer;

///一个视图控制器是否能够自己控制导航栏的外观，
///检查“bf_prefersNavigationBarHidden”属性而不是全局方法。
///默认为YES，如果不需要禁用它。
/// A view controller is able to control navigation bar's appearance by itself,
/// rather than a global way, checking "bf_prefersNavigationBarHidden" property.
/// Default to YES, disable it if you don't want so.
@property (nonatomic, assign) BOOL bf_viewControllerBasedNavigationBarAppearanceEnabled;

@end

/// Allows any view controller to disable interactive pop gesture, which might
/// be necessary when the view controller itself handles pan gesture in some
/// cases.
@interface UIViewController (BFFullscreenPopGesture)

///是否禁用左滑手势(当前控制器)
@property (nonatomic, assign) BOOL bf_interactivePopDisabled;

///是否隐藏导航栏(当前控制器)
@property (nonatomic, assign) BOOL bf_prefersNavigationBarHidden;

///是否隐藏导航栏底下的线(当前控制器)
@property (nonatomic, assign) BOOL bf_navigationBarLineHidden;

/// Max allowed initial distance to left edge when you begin the interactive pop
/// gesture. 0 by default, which means it will ignore this limit.
@property (nonatomic, assign) CGFloat bf_interactivePopMaxAllowedInitialDistanceToLeftEdge;

@end
