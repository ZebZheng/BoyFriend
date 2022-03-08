/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "UILabel+BFInit.h"

@implementation UILabel (BFInit)
/// 构建->文本-颜色-字体
/// @param text 文本
/// @param color 颜色
/// @param font 字体
+ (UILabel *)bf_createWithText:(NSString *)text color:(nullable UIColor *)color font:(nullable UIFont *)font {
    return [self bf_createWithFrame:CGRectZero text:text color:color font:font adjustText:NO];
}
/// 构建->位置-文本-颜色-字体
/// @param frame 位置
/// @param text 文本
/// @param color 颜色
/// @param font 字体
+ (UILabel *)bf_createWithFrame:(CGRect)frame text:(NSString *)text color:(nullable UIColor *)color font:(nullable UIFont *)font {
    return [self bf_createWithFrame:frame text:text color:color font:font adjustText:NO];
}
/// 构建->位置-文本-颜色-字体-是否自适应
/// @param frame 位置
/// @param text 文本
/// @param color 颜色
/// @param font 字体
/// @param isAdjust 是否自适应
+ (UILabel *)bf_createWithFrame:(CGRect)frame text:(NSString *)text color:(nullable UIColor *)color font:(nullable UIFont *)font adjustText:(BOOL)isAdjust{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    if (text) {
        label.text = text;
    }
    if (color) {
        label.textColor = color;
    }
    if (font) {
        label.font = font;
    }
    if (isAdjust) {
        label.adjustsFontSizeToFitWidth = YES;
    }
    return label;
}


@end
