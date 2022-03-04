/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/
#import <Foundation/Foundation.h>

@interface NSDate (BFConversion)

#pragma mark --- 将时间转换成时间戳
///将时间转换成时间戳 (默认格式:YYYY-MM-dd HH:mm:ss)
- (nullable NSString *)bf_toTimestamp;

///将时间转换成时间戳
- (nullable NSString *)bf_toTimestampWithFormatter:(nullable NSString *)formatterStr;

@end


