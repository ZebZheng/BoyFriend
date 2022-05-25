//
//  UIViewController+BFLateralSlide.m
//  ViewControllerTransition
//
//  Created by chavez on 2017/6/29.
//  Copyright © 2017年 chavez. All rights reserved.
//

#import "UIViewController+BFLateralSlide.h"
#import "BFInteractiveTransition.h"
#import "BFDrawerTransition.h"
#import <objc/runtime.h>

@implementation UIViewController (BFLateralSlide)

// 显示默认抽屉
- (void)bfl_showDefaultDrawerViewController:(UIViewController *)viewController {
    [self bfl_showDrawerViewController:viewController animationType:BFDrawerAnimationTypeDefault configuration:nil];
}

// 显示抽屉
- (void)bfl_showDrawerViewController:(UIViewController *)viewController animationType:(BFDrawerAnimationType)animationType configuration:(BFLateralSlideConfiguration *)configuration {
    
    if (viewController == nil) return;
    if (configuration == nil)
        configuration = [BFLateralSlideConfiguration defaultConfiguration];
    
    BFLateralSlideAnimator *animator = objc_getAssociatedObject(self, &BFLateralSlideAnimatorKey);
    
    if (animator == nil) {
        animator = [BFLateralSlideAnimator lateralSlideAnimatorWithConfiguration:configuration];
        objc_setAssociatedObject(viewController, &BFLateralSlideAnimatorKey, animator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    viewController.transitioningDelegate = animator;
    objc_setAssociatedObject(viewController, &BFLateralSlideDirectionKey, @(configuration.direction), OBJC_ASSOCIATION_ASSIGN);

    BFInteractiveTransition *interactiveHidden = [BFInteractiveTransition interactiveWithTransitiontype:BFDrawerTransitiontypeHidden];
    [interactiveHidden setValue:viewController forKey:@"weakVC"];
    [interactiveHidden setValue:@(configuration.direction) forKey:@"direction"];
    
    [animator setValue:interactiveHidden forKey:@"interactiveHidden"];
    animator.configuration = configuration;
    animator.animationType = animationType;
    if (@available(iOS 13.0, *)) {
        viewController.modalPresentationStyle =  UIModalPresentationFullScreen;
    }
    [self presentViewController:viewController animated:YES completion:nil];
    
}

// 注册抽屉手势
- (void)bfl_registerShowIntractiveWithEdgeGesture:(BOOL)openEdgeGesture transitionDirectionAutoBlock:(void(^)(BFDrawerTransitionDirection direction))transitionDirectionAutoBlock {
    
    BFLateralSlideAnimator *animator = [BFLateralSlideAnimator lateralSlideAnimatorWithConfiguration:nil];
    self.transitioningDelegate = animator;
    
    objc_setAssociatedObject(self, &BFLateralSlideAnimatorKey, animator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    BFInteractiveTransition *interactiveShow = [BFInteractiveTransition interactiveWithTransitiontype:BFDrawerTransitiontypeShow];
    [interactiveShow setValue:@(openEdgeGesture) forKey:@"openEdgeGesture"];
    [interactiveShow setValue:transitionDirectionAutoBlock forKey:@"transitionDirectionAutoBlock"];
    [interactiveShow addPanGestureForViewController:self];
    
    [animator setValue:interactiveShow forKey:@"interactiveShow"];
}

// 抽屉内push界面
- (void)bfl_pushViewController:(UIViewController *)viewController{
    [self bfl_pushViewController:viewController drewerHiddenDuration:0];
}

- (void)bfl_pushViewController:(UIViewController *)vc drewerHiddenDuration:(NSTimeInterval)duration {
    
    BFLateralSlideAnimator *animator = (BFLateralSlideAnimator *)self.transitioningDelegate;
    animator.configuration.HiddenAnimDuration = duration > 0 ? duration : animator.configuration.HiddenAnimDuration;
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav;
    NSString *TransitionType = kCATransitionPush;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbar = (UITabBarController *)rootVC;
        NSInteger index = tabbar.selectedIndex;
        nav = tabbar.childViewControllers[index];
    }else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        if (animator.animationType == BFDrawerAnimationTypeDefault) TransitionType = kCATransitionFade;
        nav = (UINavigationController *)rootVC;
    }else  {
        NSLog(@"This no UINavigationController...");
        return;
    }
    
    NSNumber *direction = objc_getAssociatedObject(self, &BFLateralSlideDirectionKey);
    NSString *subType = direction.integerValue ? kCATransitionFromLeft : kCATransitionFromRight;
    CATransition *transition = [CATransition animation];
    transition.duration = 0.20f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = TransitionType;
    transition.subtype = subType;
    [nav.view.layer addAnimation:transition forKey:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [nav pushViewController:vc animated:NO];
}


// 抽屉内present页面
- (void)bfl_presentViewController:(UIViewController *)viewController {
    [self bfl_presentViewController:viewController drewerHidden:NO];
}

- (void)bfl_presentViewController:(UIViewController *)vc drewerHidden:(BOOL)hidden {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    vc.view.frame = CGRectMake(0, kCWSCREENHEIGHT, kCWSCREENWIDTH, kCWSCREENHEIGHT);
    vc.view.tag = 5201314;
    [keyWindow addSubview:vc.view];
    [UIView animateWithDuration:0.25 animations:^{
        vc.view.frame = CGRectMake(0, 0, kCWSCREENWIDTH, kCWSCREENHEIGHT);
    } completion:^(BOOL finished) {
        // 强引用，不然会被释放
        [rootVC addChildViewController:vc];
        if (hidden) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)bfl_dismissViewController {
    if (self.view.tag != 5201314 && self.parentViewController.view.tag != 5201314) {
        NSLog(@"只有通过cw_presentViewController显示的控制器才能调用此方法...");
        return;
    }
    
    UIViewController *weakSelf = self;
    if (self.parentViewController.view.tag == 5201314) {
        weakSelf = self.parentViewController;
    }
    weakSelf.edgesForExtendedLayout = UIRectEdgeNone;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.view.frame = CGRectMake(0, kCWSCREENHEIGHT, kCWSCREENWIDTH, kCWSCREENHEIGHT);
    } completion:^(BOOL finished) {
        [weakSelf.view removeFromSuperview];
        [weakSelf removeFromParentViewController];
    }];
    
}


@end
