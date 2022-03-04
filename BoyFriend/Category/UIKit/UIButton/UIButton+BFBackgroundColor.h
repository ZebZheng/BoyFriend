/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface UIButton (BFBackgroundColor)

/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)bf_backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
