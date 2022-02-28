/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#import "NSString+BFGB2312.h"

@implementation NSString (BFGB2312)
//转成utf8Data
- (NSData *)bf_UTF8WithGB2312Data:(NSData *)gb2312Data {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *str = [[NSString alloc] initWithData:gb2312Data encoding:enc];
    NSData *utf8Data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return utf8Data;
            
}

//转成gb2312Data
-(NSData *)bf_GB2312WithUTF8Data:(NSData *)UTF8Data {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *str = [[NSString alloc] initWithData:UTF8Data  encoding:NSUTF8StringEncoding];
    NSData *gb2312Data = [str dataUsingEncoding:enc ];
    return gb2312Data;

}
@end
