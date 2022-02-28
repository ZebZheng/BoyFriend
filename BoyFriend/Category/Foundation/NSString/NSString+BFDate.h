/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/
#import <Foundation/Foundation.h>

@interface NSString (BFDate)
#pragma mark ---- 将时间戳转换成时间
- (nullable NSString *)bf_dateFromTimestampWithFormatter:(nullable NSString *)formatterstr;

/** 字符串转时间*/
- (nullable NSDate *)bf_dateFromStringFormat:(nullable NSString *)format;
///转时间戳 - 默认格式YYYY-MM-dd HH:mm:ss
- (nullable NSString *)bf_toTimestamp;
///转时间戳
- (nullable NSString *)bf_toTimestampWithFormat:(nullable NSString *)format;
@end

