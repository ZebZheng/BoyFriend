/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#import <UIKit/UIKit.h>

@interface UIControl (BFEventInterval)

/// 两次事件的间隔时间 (例如按钮 设置不能连续点击)
@property (nonatomic, assign) NSTimeInterval bf_eventInterval;

@end
