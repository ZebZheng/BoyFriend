/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <Foundation/Foundation.h>

@interface NSURL (BFParam)

/**
 *  @brief  url参数转字典
 *
 *  @return 参数转字典结果
 */
- (NSDictionary *)bf_parameters;
/**
 *  @brief  根据参数名 取参数值
 *
 *  @param parameterKey 参数名的key
 *
 *  @return 参数值
 */
- (NSString *)bf_valueForParameter:(NSString *)parameterKey;

@end
