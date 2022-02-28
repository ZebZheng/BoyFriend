/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (BFConversion)
///转成字符串,默认","拼接
- (NSString *)bf_toString;
///转成字符串
- (NSString *)bf_toStringBy:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
