/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (BFInit)
/// 构建->字体-颜色-占位字
/// @param font 字体
/// @param textColor 颜色
/// @param placeholder 占位字
+ (UITextField *)bf_createWithFont:(UIFont *)font
                       textColor:(UIColor *)textColor
                     placeholder:(NSString *)placeholder;
/// 构建->字体-颜色-背景色-占位字-占位字颜色
/// @param font 字体
/// @param textColor 颜色
/// @param backgroundColor 背景色
/// @param placeholder 占位字
/// @param placeholderColor 占位字颜色
+ (UITextField *)bf_createWithFont:(UIFont *)font
                       textColor:(UIColor *)textColor
                 backgroundColor:(UIColor *)backgroundColor
                     placeholder:(NSString *)placeholder
                placeholderColor:(nullable UIColor *)placeholderColor;
/// 构建->字体-颜色-背景色-边框样式-占位字-确认键样式-代理
/// @param font 字体
/// @param textColor 颜色
/// @param backgroundColor 背景色
/// @param borderStyle 边框样式
/// @param placeholder 占位字
/// @param placeholderColor 占位字颜色
/// @param keyboardType 键盘样式
/// @param returnKeyType 确认样式
/// @param delegate 代理
+ (UITextField *)bf_createWithFont:(nullable UIFont *)font
                       textColor:(nullable UIColor *)textColor
                 backgroundColor:(nullable UIColor *)backgroundColor
                     borderStyle:(UITextBorderStyle)borderStyle
                     placeholder:(nullable NSString *)placeholder
                     placeholderColor:(nullable UIColor *)placeholderColor
                    keyboardType:(UIKeyboardType)keyboardType
                   returnKeyType:(UIReturnKeyType)returnKeyType
                        delegate:(nullable id<UITextFieldDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
