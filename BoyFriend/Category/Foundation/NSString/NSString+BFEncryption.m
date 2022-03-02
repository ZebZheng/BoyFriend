/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "NSString+BFEncryption.h"
#import "NSData+BFConversion.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (BFEncryption)

#pragma mark - base64
- (NSString *)bf_base64String {
    return [NSString bf_base64EncodingWithString:self].bf_toString;
}
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

#pragma mark - UTF-8
///编码
- (NSString *)bf_urlEncodeWithUTF8 {
    return [self bf_urlEncodeWithUTF8:NSCharacterSet.URLQueryAllowedCharacterSet];
}
///编码
- (NSString *)bf_urlEncodeWithUTF8:(NSCharacterSet *)characterSet {
    NSString *encoderStr = [self stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
    return encoderStr;
}
///解码
- (NSString *)bf_urlDecodeWithUTF8 {
    return [self stringByRemovingPercentEncoding];
}

#pragma mark - gb2312
///GB2312转成utf8Data
- (NSData *)bf_UTF8WithGB2312Data:(NSData *)gb2312Data {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *str = [[NSString alloc] initWithData:gb2312Data encoding:enc];
    NSData *utf8Data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return utf8Data;
            
}
///UTF8转成gb2312Data
-(NSData *)bf_GB2312WithUTF8Data:(NSData *)UTF8Data {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *str = [[NSString alloc] initWithData:UTF8Data  encoding:NSUTF8StringEncoding];
    NSData *gb2312Data = [str dataUsingEncoding:enc ];
    return gb2312Data;

}

#pragma mark - MD5
///16位MD5加密--小写
- (NSString *)bf_MD5Bits16LowercaseEncryption {
    return [NSString bf_MD5_NB16BitEncry:self isUppercase:NO];
}
///16位MD5加密--大写
- (NSString *)bf_MD5Bits16UppercaseEncryption {
    return [NSString bf_MD5_NB16BitEncry:self isUppercase:YES];
}
///32位MD5加密--小写
- (NSString *)bf_MD5Bits32LowercaseEncryption {
    return [NSString bf_MD5_NB32BitEncry:self isUppercase:NO];
}
///32位MD5加密--大写
- (NSString *)bf_MD5Bits32UppercaseEncryption {
    return [NSString bf_MD5_NB32BitEncry:self isUppercase:YES];
}
/// 16位MD5加密
/// @param isUppercase 是否大写
+ (NSString *)bf_MD5_16BitEncry:(NSString *)MD5String isUppercase:(BOOL)isUppercase {
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String = [self bf_MD5_32BitEncry:MD5String isUppercase:NO];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    if (isUppercase) {
        return [result uppercaseString];
    }else{
        return result;
    }
}
/// 16位MD5加密
/// @param isUppercase 是否大写
+ (NSString *)bf_MD5_NB16BitEncry:(NSString *)MD5String isUppercase:(BOOL)isUppercase {
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self bf_MD5_NB32BitEncry:MD5String isUppercase:NO];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    if (isUppercase) {
        return [result uppercaseString];
    }else{
        return result;
    }
}
/// 32位MD5加密
/// @param isUppercase 是否大写
+ (NSString *)bf_MD5_32BitEncry:(NSString *)MD5String isUppercase:(BOOL)isUppercase {
    const char *str = [MD5String UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( str, (CC_LONG)MD5String.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    if (isUppercase) {
        return [result uppercaseString];
    }else{
        return result;
    }
}
/// 32位MD5加密
/// @param isUppercase 是否大写
+ (NSString *)bf_MD5_NB32BitEncry:(NSString *)MD5String isUppercase:(BOOL)isUppercase {
    const char *cStr = [MD5String UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    [result appendFormat:@"%02x",digest[0]];
    for (int i = 1; i< CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x",digest[i]^digest[0]];
    }
    if (isUppercase) {
        return [result uppercaseString];
    }else{
        return result;
    }
}





@end
