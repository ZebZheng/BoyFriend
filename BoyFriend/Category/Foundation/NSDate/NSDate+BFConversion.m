/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "NSDate+BFConversion.h"

@implementation NSDate (BFConversion)

#pragma mark --- 将时间转换成时间戳
///将时间转换成时间戳
- (nullable NSString *)bf_toTimestamp {
    return [self bf_toTimestampWithFormatter:nil];
}
///将时间转换成时间戳
- (nullable NSString *)bf_toTimestampWithFormatter:(nullable NSString *)formatterStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (formatterStr) {
        [formatter setDateFormat: formatterStr];
    } else {
        [formatter setDateFormat: @"YYYY-MM-dd HH:mm:ss"];
    }
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = self;
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}


@end
