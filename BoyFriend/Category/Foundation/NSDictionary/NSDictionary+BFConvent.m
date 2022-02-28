/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#import "NSDictionary+BFConvent.h"

@implementation NSDictionary (BFConvent)
///字典转json格式字符串
- (NSString*)bf_toJson {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
