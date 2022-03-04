/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>
#import "UIImage+BFAdd.h"

NS_ASSUME_NONNULL_BEGIN
@interface UIColor (BFAdd)

//MARK: - 十六进制
+ (UIColor *)bf_hexStr:(NSString *)hexStr alpha:(CGFloat)a;
//MARK: - 十六进制
+ (UIColor *)bf_hexStr:(NSString *)hexStr;
//MARK: - 随机色
+ (UIColor *)bf_randomColor;
//MARK: - 判断颜色深浅
- (BOOL)bf_isDarkColor;

//MARK: - 渐变颜色(横向渐变, 纵向渐变,length为渐变长度)
/// @param color 开始颜色
/// @param toColor 结束颜色
/// @param isHorizontal 是否是水平
/// @param length 渐变长度
+ (nullable UIColor*)bf_gradientFromColor:(UIColor*)color toColor:(UIColor*)toColor isHorizontal:(BOOL)isHorizontal Length:(int)length;
//MARK: - 渐变颜色
+ (nullable UIColor *)bf_gradientColorWithType:(BFGradientType)type colors:(NSArray<UIColor *> *)colors;
//MARK: - 渐变颜色
+ (nullable UIColor *)bf_gradientColorWithType:(BFGradientType)type size:(CGSize)size colors:(NSArray<UIColor *> *)colors;

@end
NS_ASSUME_NONNULL_END



