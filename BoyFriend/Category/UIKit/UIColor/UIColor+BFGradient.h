//
//  UIColor+Gradient.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BFGradient)


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
+ (UIColor*)bf_gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 isHorizontal:(BOOL)isHorizontal Length:(int)length;
@end
