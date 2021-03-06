/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <Foundation/Foundation.h>


@interface NSObject (BFGCD)

/**
 *  @brief  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)bf_performAsynchronous:(void(^)(void))block;
/**
 *  @brief  GCD主线程执行代码块
 *
 *  @param block 代码块
 *  @param wait  是否同步请求
 */
- (void)bf_performOnMainThread:(void(^)(void))block wait:(BOOL)wait;

/**
 *  @brief  延迟执行代码块
 *
 *  @param seconds 延迟时间 秒
 *  @param block   代码块
 */
- (void)bf_performAfter:(NSTimeInterval)seconds block:(void(^)(void))block;


@end
