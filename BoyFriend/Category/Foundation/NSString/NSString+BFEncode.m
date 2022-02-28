/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/
#import "NSString+BFEncode.h"

@implementation NSString (BFEncode)
//编码
- (NSString *)bf_urlEncodeWithUTF8 {
    return [self bf_urlEncodeWithUTF8:NSCharacterSet.URLQueryAllowedCharacterSet];
}
- (NSString *)bf_urlEncodeWithUTF8:(NSCharacterSet *)characterSet {
    NSString *encoderStr = [self stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
    return encoderStr;
}

//解码
- (NSString *)bf_urlDecodeWithUTF8 {
    return [self stringByRemovingPercentEncoding];
}
@end
