//
//  MBProgressHUD+JDragon.h
//  JDragonHUD
//
//  Created by JDragon on 2017/1/17.
//  Copyright © 2017年 JDragon. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Extension)

//获取当前窗口
+ (UIView *)getTheProgressHUDViewWithIsWindow:(BOOL)isWindow;

//只显示message
+ (void)showTipMessageInWindow:(NSString*)message;
+ (void)showTipMessageInView:(NSString*)message;
+ (void)showTipMessageInWindow:(NSString*)message timer:(float)aTimer;
+ (void)showTipMessageInView:(NSString*)message timer:(float)aTimer;
+ (void)showTipMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(float)aTimer offset:(float)offset;
+ (void)showTipMessage:(NSString *)message completion:(void (^)(void))completion;
//显示有菊花加载的message
+ (void)showActivityMessageInWindow:(NSString*)message;
+ (void)showActivityMessageInView:(NSString*)message;
+ (void)showActivityMessageInWindow:(NSString*)message timer:(float)aTimer;
+ (void)showActivityMessageInView:(NSString*)message timer:(float)aTimer;

//显示图片message(默认是显示在window上的)
+ (void)showSuccessMessage:(NSString *)Message;
+ (void)showErrorMessage:(NSString *)Message;
+ (void)showInfoMessage:(NSString *)Message;
+ (void)showWarnMessage:(NSString *)Message;

//显示指定图片的message
+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message;


//进度条显示。默认圆圈
+ (void)showProgress:(float)fractionCompleted;
+ (void)showProgress:(float)fractionCompleted message:(NSString *)message;
+ (void)showProgress:(float)fractionCompleted message:(NSString *)message mode:(MBProgressHUDMode)mode;
+ (void)showProgress:(float)fractionCompleted toView:(UIView *)view;

// 提示后响应某个动作
+ (void)showMessage:(NSString *)message completion:(void (^)(void))completion;

//在指定视图上显示loading
+ (void)showMessage:(NSString *)message addToView:(UIView *)view;

+ (void)hideHUD;

@end
