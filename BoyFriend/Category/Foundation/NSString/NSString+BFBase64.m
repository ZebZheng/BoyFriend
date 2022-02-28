/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "NSString+BFBase64.h"

@implementation NSString (BFBase64)
///base64加密
+(NSString *)bf_base64EncodingWithData:(NSData *)sourceData {
    if (!sourceData) { //如果sourceData则返回nil，不进行加密。
        return nil;
    }
    NSString *resultString = [sourceData base64EncodedStringWithOptions: NSDataBase64Encoding64CharacterLineLength];
    return resultString;
    
}

///base64解密
+(NSData *)bf_base64EncodingWithString:(NSString *)sourceString {
    if (!sourceString) {
        return nil;//如果sourceString则返回nil，不进行解密。
    }
    NSData *resultData = [[NSData alloc]initWithBase64EncodedString:sourceString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return resultData;
    
}
@end
