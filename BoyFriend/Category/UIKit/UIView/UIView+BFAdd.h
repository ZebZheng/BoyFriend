/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/


#import <UIKit/UIKit.h>
#import "UIImage+BFAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (BFAdd)
//MARK: - 设置部分圆角
- (void)bf_roundeConrners:(UIRectCorner)rectCon cornerRadii:(CGSize)size;
//MARK: - 设置部分圆角
- (void)bf_roundeWithSize:(CGSize)size conrners:(UIRectCorner)rectCon cornerRadii:(CGFloat)radii;
//MARK: - 设置阴影
- (void)bf_shadowsColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius opacity:(CGFloat)opacity;
//MARK: - 渐变色
- (void)bf_imageFromSize:(CGSize)size Colors:(NSArray*)colors byGradientType:(BFGradientType)gradientType;

//MARK: - 移除所有子视图
- (void)bf_removeAllSubviews;
//MARK: - 边框线-四周
- (void)bf_borderAllWithColor:(UIColor *)color borderWidth:(CGFloat)width;
//MARK: - 边框线-上
- (void)bf_borderTopWithColor:(UIColor *)color borderWidth:(CGFloat)width;
//MARK: - 边框线-左
- (void)bf_borderLeftWithColor:(UIColor *)color borderWidth:(CGFloat)width;
//MARK: - 边框线-右
- (void)bf_borderRightWithColor:(UIColor *)color borderWidth:(CGFloat)width;
//MARK: - 边框线-下
- (void)bf_borderBottomWithColor:(UIColor *)color borderWidth:(CGFloat)width;
//MARK: - 边框线-通用
- (void)bf_borderWithTop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;

//MARK: - 边框渐变
/// @param gradientType 渐变方向
/// @param colors 颜色
/// @param lineWidth 边框线大小
/// @param cornerRadius 圆角
- (void)bf_borderGradientWithType:(BFGradientType)gradientType colors:(NSArray *)colors lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)cornerRadius;

@end
NS_ASSUME_NONNULL_END

