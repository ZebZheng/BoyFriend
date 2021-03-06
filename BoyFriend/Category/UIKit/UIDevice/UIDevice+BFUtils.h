/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

@interface UIDevice (BFUtils)

/**
 获取硬件平台名称，叫 device model 或者 machine name

 @return 硬件平台名称，如 iPhone3,1、iPad7,4 等
 */
+ (NSString *)bf_platform;

/**
 获取设备型号名称

 @return 设备型号名称，如 iPhone 7、iPhone X、iPad Pro 10.5-inch 等
 */
+ (NSString *)bf_platformString;

/**
 获取设备型号名称 只查询一次然后缓存

 @return 设备型号名称，与 platformString 一致，只查询一次然后缓存
 */
+ (NSString *)bf_deviceName;

@end
