/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BFEncode)
//编码
- (NSString *)bf_urlEncodeWithUTF8;
- (NSString *)bf_urlEncodeWithUTF8:(NSCharacterSet *)characterSet;
//解码
- (NSString *)bf_urlDecodeWithUTF8;
@end

NS_ASSUME_NONNULL_END
