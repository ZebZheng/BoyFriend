/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BFBase64)
///base64加密
+(NSString *)bf_base64EncodingWithData:(NSData *)sourceData;
///base64解密
+(NSData *)bf_base64EncodingWithString:(NSString *)sourceString;
@end

NS_ASSUME_NONNULL_END
