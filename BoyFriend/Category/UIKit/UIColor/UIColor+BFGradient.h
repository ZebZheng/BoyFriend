/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

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
