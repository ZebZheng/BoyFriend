//
//  MBProgressHUD+JDragon.m
//  JDragonHUD
//
//  Created by JDragon on 2017/1/17.
//  Copyright © 2017年 JDragon. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)

+ (UIView *)getTheProgressHUDViewWithIsWindow:(BOOL)isWindow{
    UIView *view;
    if (isWindow == YES) {
        view = (UIView *)[UIApplication sharedApplication].keyWindow;
    }else{
        view = [self getCurrentUIVC].view;
    }
    return view;
}

+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow{
    
    UIView *view=[self getTheProgressHUDViewWithIsWindow:isWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text=message?message:@"";
    hud.label.numberOfLines=0;
    hud.label.font=[UIFont systemFontOfSize:14];
    hud.removeFromSuperViewOnHide = YES;
//    hud.dimBackground = NO;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.contentColor = [UIColor whiteColor];
    [view bringSubviewToFront:hud];
    hud.userInteractionEnabled = NO;
    return hud;
}
#pragma mark-------------------- show Tip----------------------------

+ (void)showTipMessageInWindow:(NSString*)message
{
    [self hideHUD];
    [self showTipMessage:message isWindow:true timer:2];
}
+ (void)showTipMessageInView:(NSString*)message
{
    [self hideHUD];
    [self showTipMessage:message isWindow:false timer:2];
}
+ (void)showTipMessageInWindow:(NSString*)message timer:(float)aTimer
{
    [self hideHUD];
    [self showTipMessage:message isWindow:true timer:aTimer];
}
+ (void)showTipMessageInView:(NSString*)message timer:(float)aTimer
{
    [self hideHUD];
    [self showTipMessage:message isWindow:false timer:aTimer];
}
+ (void)showTipMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(float)aTimer
{
    if (message.length==0 || message==nil) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
        hud.mode = MBProgressHUDModeText;
        if (aTimer>0.0) {
            [hud hideAnimated:YES afterDelay:aTimer];
        }
    });
}
+ (void)showTipMessage:(NSString *)message completion:(void (^)(void))completion {
    [self hideHUD];
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindiw:NO];
        hud.mode = MBProgressHUDModeText;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(200 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.4f animations:^{
                hud.transform = CGAffineTransformMakeScale(0.8, 0.8);
            } completion:^(BOOL finished) {
                //400毫秒延迟
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(400 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
                    [hud removeFromSuperview];
                    if (completion) {
                        completion();
                    }
                });
            }];
        });
    });
}
+ (void)showTipMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(float)aTimer offset:(float)offset
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
        hud.mode = MBProgressHUDModeText;
        hud.offset = CGPointMake(0.f, offset);//正数往下偏移   负数往上偏移
        if (aTimer>0.0) {
            [hud hideAnimated:YES afterDelay:aTimer];
        }
    });
}
#pragma mark-------------------- show Activity----------------------------

+ (void)showActivityMessageInWindow:(NSString*)message
{
    [self showActivityMessage:message isWindow:true timer:0];
}
+ (void)showActivityMessageInView:(NSString*)message
{
    [self showActivityMessage:message isWindow:false timer:0];
}
+ (void)showActivityMessageInWindow:(NSString*)message timer:(float)aTimer
{
    [self showActivityMessage:message isWindow:true timer:aTimer];
}
+ (void)showActivityMessageInView:(NSString*)message timer:(float)aTimer
{
    [self showActivityMessage:message isWindow:false timer:aTimer];
}
+ (void)showActivityMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(float)aTimer
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.userInteractionEnabled = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    if (aTimer>0) {
        [hud hideAnimated:YES afterDelay:aTimer];
    }
}
#pragma mark-------------------- show Image----------------------------

+ (void)showSuccessMessage:(NSString *)Message
{
    [self hideHUD];
    [self showCustomIconInWindow:@"mbhud_success" message:Message];
}
+ (void)showErrorMessage:(NSString *)Message
{
    [self hideHUD];
    [self showCustomIconInWindow:@"mbhud_error" message:Message];
}
+ (void)showInfoMessage:(NSString *)Message
{
    [self hideHUD];
    [self showCustomIconInWindow:@"mbhud_info" message:Message];
}
+ (void)showWarnMessage:(NSString *)Message
{
    [self hideHUD];
    [self showCustomIconInWindow:@"mbhud_warn" message:Message];
    
}



+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message
{
    message=[NSString stringWithFormat:@"  %@  ",message];
    [self showCustomIcon:iconName message:message isWindow:true];
}
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:false];
}
+ (void)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    hud.mode = MBProgressHUDModeCustomView;
    [hud hideAnimated:YES afterDelay:1];
}

//进度条显示。默认圆圈
+ (void)showProgress:(float)fractionCompleted
{
    [self showProgress:fractionCompleted message:nil];
}
+ (void)showProgress:(float)fractionCompleted message:(NSString *)message
{
    [self showProgress:fractionCompleted message:message mode:MBProgressHUDModeAnnularDeterminate];
}
+ (void)showProgress:(float)fractionCompleted message:(NSString *)message mode:(MBProgressHUDMode)mode
{
    [self showProgress:fractionCompleted message:message mode:mode toView:nil];
}

+ (void)showProgress:(float)fractionCompleted toView:(UIView *)view {
    [self showProgress:fractionCompleted message:nil mode:MBProgressHUDModeAnnularDeterminate toView:view];
}

+ (void)showProgress:(float)fractionCompleted message:(NSString *)message mode:(MBProgressHUDMode)mode toView:(UIView *)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *mbHud;
        if (view==nil) {
            mbHud = [self createMBProgressHUDviewWithMessage:message isWindiw:YES];
        } else {
            mbHud = [self createMBProgressHUDviewWithMessage:message isWindiw:NO];
        }
        mbHud.userInteractionEnabled = YES;
        mbHud.mode = mode;
        mbHud.label.text = message;

        if (fractionCompleted == 1.0f) {
            [mbHud hideAnimated:YES afterDelay:1];
        }else{
            mbHud.progress = fractionCompleted;
        }
//        [mbHud hideAnimated:YES];
    });
}

// 提示后响应某个动作
+ (void)showMessage:(NSString *)message completion:(void (^)(void))completion
{
    [self hideHUDForView:[self getTheProgressHUDViewWithIsWindow:YES] animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self getTheProgressHUDViewWithIsWindow:YES] animated:NO];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(200 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5f animations:^{
                hud.transform = CGAffineTransformMakeScale(0.8, 0.8);
            } completion:^(BOOL finished) {
                //400毫秒延迟
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(400 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
                    [hud removeFromSuperview];
                    if (completion) {
                        completion();
                    }
                });
            }];
        });
    });
    
}

+ (void)showMessage:(NSString *)message addToView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = YES;
    hud.label.text=message?message:@"";
    hud.label.numberOfLines=0;
    hud.label.font=[UIFont systemFontOfSize:14];
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeIndeterminate;
}

+ (void)hideHUD {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *winView =(UIView*)[self getCurrentWindow];
        
        [self hideHUDForView:winView animated:YES];
        [self hideHUDForView:[self getCurrentUIVC].view animated:YES];
        [self hideHUDForView:[self getCurrentWindow] animated:YES];
    });
}
+(UIWindow*)getCurrentWindow {
    if([[[UIApplication sharedApplication] delegate] window]) {
        return[[[UIApplication sharedApplication] delegate] window];
    }else{
        if(@available(iOS 13.0, *)) {
            NSArray *array =[[[UIApplication sharedApplication] connectedScenes] allObjects];
            UIWindowScene* windowScene = (UIWindowScene*)array[0];
            //如果是普通App开发，可以使用
//            SceneDelegate * delegate = (SceneDelegate *)windowScene.delegate;
//            UIWindow * mainWindow = delegate.window;
            //由于在sdk开发中，引入不了SceneDelegate的头文件，所以需要用kvc获取宿主app的window.
            UIWindow* mainWindow = [windowScene valueForKeyPath:@"delegate.window"];
            if(mainWindow) {
                return mainWindow;
            } else {
                return[UIApplication sharedApplication].windows.lastObject;
            }
        }else{
            return[UIApplication sharedApplication].keyWindow;
        }
    }
}


//获取当前屏幕显示的viewcontroller
+(UIViewController *)getCurrentUIVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}


@end
