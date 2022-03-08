/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/


#import "UIButton+BFInit.h"
#import "UIFont+BFAdd.h"


@implementation UIButton (BFInit)

/// 构建->文本-文本颜色
/// @param title 文本
/// @param titleColor 文本颜色
+ (UIButton *)bf_createWithFrame:(CGRect)frame
                        title:(NSString *)title
                   titleColor:(UIColor *)titleColor {
    return [self bf_createWithTitle:title titleColor:titleColor font:nil buttonType:UIButtonTypeCustom bgColor:nil corner:0 target:nil action:nil];
}
/// 构建->文本-文本颜色-字体
/// @param title 文本
/// @param titleColor 文本颜色
/// @param font 文本字体
+ (UIButton *)bf_createWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                         font:(UIFont *)font {
    return [self bf_createWithTitle:title titleColor:titleColor font:font buttonType:UIButtonTypeCustom bgColor:nil corner:0 target:nil action:nil];
}
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
                       action:(SEL)action {
    return [self bf_createWithTitle:title titleColor:titleColor font:font buttonType:UIButtonTypeCustom bgColor:nil corner:0 target:target action:action];
}
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
                       action:(SEL)action {
    return [self bf_createWithTitle:title titleColor:titleColor font:font buttonType:buttonType bgColor:bgColor corner:0 target:target action:action];
}
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
                       action:(SEL)action {
    UIButton * button = [self bf_createWithTitle:title titleColor:titleColor selectedTitle:nil selectedColor:nil image:nil selectedImage:nil font:font buttonType:UIButtonTypeCustom corner:0 target:nil action:nil];
    if (bgColor) {
        button.backgroundColor = bgColor;
    }
    return button;
}

/// 构建->图片-选中图片
/// @param image 图片
/// @param selectedImage 选中图片
+ (UIButton *)bf_createWithImage:(UIImage *)image
                selectedImage:(UIImage *)selectedImage {
    return [self bf_createWithImage:image selectedImage:selectedImage buttonType:UIButtonTypeCustom corner:0 target:nil action:nil];
}
/// 构建->图片-选中图片-样式-圆角
/// @param image 图片
/// @param selectedImage 选中图片
/// @param target 目标
/// @param action 函数
+ (UIButton *)bf_createWithImage:(UIImage *)image
                selectedImage:(UIImage *)selectedImage
                       target:(id)target
                       action:(SEL)action {
    return [self bf_createWithImage:image selectedImage:selectedImage buttonType:UIButtonTypeCustom corner:0 target:target action:action];
}
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
                       action:(SEL)action {
    return [self bf_createWithTitle:nil titleColor:nil selectedTitle:nil selectedColor:nil image:image selectedImage:selectedImage font:nil buttonType:buttonType corner:cornerRadius target:target action:action];
}

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
                         font:(UIFont *)font {
    return [self bf_createWithTitle:title titleColor:titleColor selectedTitle:selectedTitle selectedColor:selectedColor image:image selectedImage:selectedImage font:font buttonType:UIButtonTypeCustom corner:0 target:nil action:nil];
}
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
                       action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:buttonType];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (selectedTitle) {
        [button setTitle:selectedTitle forState:UIControlStateSelected];
    }
    if (selectedColor) {
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    if (image) {
        [button setImage:image forState:normal];
    }
    if (selectedImage) {
        [button setImage:selectedImage forState:UIControlStateSelected];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (cornerRadius > 0) {
        button.layer.cornerRadius = cornerRadius;
        button.layer.masksToBounds = YES;
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


@end
