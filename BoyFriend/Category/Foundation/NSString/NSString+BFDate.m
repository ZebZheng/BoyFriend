/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/
#import "NSString+BFDate.h"
#import "NSDate+BFConversion.h"
@implementation NSString (BFDate)
#pragma mark ---- 将时间戳转换成时间
- (NSString *)bf_dateFromTimestampWithFormatter:(NSString  *)formatterstr {
    //将对象类型的时间转换为NSDate类型
    double time = self.doubleValue;
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    
    if (formatterstr) {
        [formatter setDateFormat: formatterstr];
    } else {
        [formatter setDateFormat: @"YYYY-MM-dd HH:mm:ss"];
    }
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}

- (NSDate *)bf_dateFromStringFormat:(NSString *)format {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:self];
}
///转时间戳 - 默认格式YYYY-MM-dd HH:mm:ss
- (NSString *)bf_toTimestamp {
    return [self bf_toTimestampWithFormat:@"YYYY-MM-dd HH:mm:ss"];
}
///转时间戳
- (NSString *)bf_toTimestampWithFormat:(NSString *)format {
    return [[self bf_dateFromStringFormat:format] bf_toTimestampWithFormatter:format];
}
@end
