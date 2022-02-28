//
//  UIDevice+BFUtils.h
//  AwesomeTips
//
//  Created by kangzubin on 2018/9/20.
//  Copyright © 2018 KANGZUBIN. All rights reserved.
//

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
 获取设备型号名称

 @return 设备型号名称，与 platformString 一致，只查询一次然后缓存
 */
+ (NSString *)bf_deviceName;

@end
