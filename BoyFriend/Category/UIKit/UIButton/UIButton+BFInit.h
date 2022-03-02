/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/
#import <UIKit/UIKit.h>

@interface UIButton (BFInit)
/// 构建->文本-文本颜色
/// @param title 文本
/// @param titleColor 文本颜色
+ (UIButton *)bf_createWithFrame:(CGRect)frame
                        title:(NSString *)title
                      titleColor:(UIColor *)titleColor;
/// 构建->文本-文本颜色-字体
/// @param title 文本
/// @param titleColor 文本颜色
/// @param font 文本字体
+ (UIButton *)bf_createWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                            font:(UIFont *)font;
/// 构建->文本-文本颜色-字体
/// @param title 文本
/// @param titleColor 文本颜色
/// @param font 文本字体
/// @param target 目标
/// @param action 函数
+ (UIButton *)bf_createWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                         font:(UIFont *)font
                       target:(id)target
                          action:(SEL)action;
/// 构建->文本-文本颜色-字体-样式-背景颜色
/// @param title 文本
/// @param titleColor 文本颜色
/// @param font 文本字体
/// @param buttonType 样式
/// @param bgColor 背景颜色
/// @param target 目标
/// @param action 函数
+ (UIButton *)bf_createWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                         font:(UIFont *)font
                   buttonType:(UIButtonType)buttonType
                      bgColor:(UIColor *)bgColor
                       target:(id)target
                          action:(SEL)action;
/// 构建->文本-文本颜色-字体-样式-圆角-背景颜色
/// @param title 文本
/// @param titleColor 文本颜色
/// @param font 文本字体
/// @param buttonType 样式
/// @param bgColor 背景颜色
/// @param cornerRadius 圆角
/// @param target 目标
/// @param action 函数
+ (UIButton *)bf_createWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                         font:(UIFont *)font
                   buttonType:(UIButtonType)buttonType
                      bgColor:(UIColor *)bgColor
                       corner:(float)cornerRadius
                       target:(id)target
                          action:(SEL)action;
/// 构建->图片-选中图片
/// @param image 图片
/// @param selectedImage 选中图片
+ (UIButton *)bf_createWithImage:(UIImage *)image
                   selectedImage:(UIImage *)selectedImage;
/// 构建->图片-选中图片-样式-圆角
/// @param image 图片
/// @param selectedImage 选中图片
/// @param target 目标
/// @param action 函数
+ (UIButton *)bf_createWithImage:(UIImage *)image
                selectedImage:(UIImage *)selectedImage
                       target:(id)target
                          action:(SEL)action;
/// 构建->图片-选中图片-样式-圆角
/// @param image 图片
/// @param selectedImage 选中图片
/// @param buttonType 样式
/// @param cornerRadius 圆角
/// @param target 目标
/// @param action 函数
+ (UIButton *)bf_createWithImage:(UIImage *)image
                selectedImage:(UIImage *)selectedImage
                   buttonType:(UIButtonType)buttonType
                       corner:(float)cornerRadius
                       target:(id)target
                          action:(SEL)action;
/// 构建->文本-文本颜色-选中文本-选中文本颜色-图片-选中图片-字体
/// @param title 文本
/// @param titleColor 文本颜色
/// @param selectedTitle 选中文本
/// @param selectedColor 选中文本颜色
/// @param image 图片
/// @param selectedImage 选中图片
/// @param font 字体
+ (UIButton *)bf_createWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                selectedTitle:(NSString *)selectedTitle
                selectedColor:(UIColor *)selectedColor
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage
                            font:(UIFont *)font;
/// 构建->文本-文本颜色-选中文本-选中文本颜色-图片-选中图片-字体-样式-圆角
/// @param title 文本
/// @param titleColor 文本颜色
/// @param selectedTitle 选中文本
/// @param selectedColor 选中文本颜色
/// @param image 图片
/// @param selectedImage 选中图片
/// @param font 字体
/// @param buttonType 样式
/// @param cornerRadius 圆角
/// @param target 目标
/// @param action 函数
+ (UIButton *)bf_createWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                selectedTitle:(NSString *)selectedTitle
                selectedColor:(UIColor *)selectedColor
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage
                         font:(UIFont *)font
                   buttonType:(UIButtonType)buttonType
                       corner:(float)cornerRadius
                       target:(id)target
                          action:(SEL)action;

@end

