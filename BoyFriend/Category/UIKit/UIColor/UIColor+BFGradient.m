//
//  UIColor+Gradient.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIColor+BFGradient.h"

@implementation UIColor (BFGradient)

#pragma mark - Gradient Color

/**
 *  @brief  渐变颜色(横向渐变, 纵向渐变,length为渐变长度)
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param isHorizontal 是否是水平
 *  @param length  渐变长度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)bf_gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 isHorizontal:(BOOL)isHorizontal Length:(int)length
{
    CGSize size = CGSizeZero;
    if (isHorizontal) {
        size = CGSizeMake(length, 1);
    } else {
        size = CGSizeMake(1, length);
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    // 创建Quartz上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 创建色彩空间对象
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    // 颜色数组
    NSArray* colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
    // 创建渐变对象
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    if (isHorizontal) {
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(size.width, 0), 0);
    } else {
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}
@end
