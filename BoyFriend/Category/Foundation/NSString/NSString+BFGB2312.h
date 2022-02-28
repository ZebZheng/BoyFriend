/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BFGB2312)
///转成utf8Data
- (NSData *)bf_UTF8WithGB2312Data:(NSData *)gb2312Data;
///转成gb2312Data
- (NSData *)bf_GB2312WithUTF8Data:(NSData *)UTF8Data;
@end

NS_ASSUME_NONNULL_END
