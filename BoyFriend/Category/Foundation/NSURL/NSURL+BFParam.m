/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "NSURL+BFParam.h"

@implementation NSURL (BFParam)
/**
 *  @brief  url参数转字典
 *
 *  @return 参数转字典结果
 */
- (NSDictionary *)bf_parameters {
    NSMutableDictionary * parametersDictionary = [NSMutableDictionary dictionary];
    NSArray * queryComponents = [self.query componentsSeparatedByString:@"&"];
    for (NSString * queryComponent in queryComponents) {
        NSString * key = [queryComponent componentsSeparatedByString:@"="].firstObject;
        NSString * value = [queryComponent substringFromIndex:(key.length + 1)];
        [parametersDictionary setObject:value forKey:key];
    }
    return parametersDictionary;
}
/**
 *  @brief  根据参数名 取参数值
 *
 *  @param parameterKey 参数名的key
 *
 *  @return 参数值
 */
- (NSString *)bf_valueForParameter:(NSString *)parameterKey {
    return [[self bf_parameters] objectForKey:parameterKey];
}
@end
