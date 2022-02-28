/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/


#import "NSString+BFMD5.h"
#import "NSString+BFBase64.h"
#import "NSData+BFConversion.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (BFMD5)
- (NSString *)bf_MD5Bits16LowercaseEncryption
{
    return [NSString bf_MD5_NB16BitEncry:self isUppercase:NO];
}
- (NSString *)bf_MD5Bits16UppercaseEncryption
{
    return [NSString bf_MD5_NB16BitEncry:self isUppercase:YES];
}
- (NSString *)bf_MD5Bits32LowercaseEncryption
{
    return [NSString bf_MD5_NB32BitEncry:self isUppercase:NO];
}
- (NSString *)bf_MD5Bits32UppercaseEncryption
{
    return [NSString bf_MD5_NB32BitEncry:self isUppercase:YES];
}

- (NSString *)bf_base64Decryption {
    return [NSString bf_base64EncodingWithString:self].bf_toString;
}

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

+ (NSString *)bf_MD5_32BitEncry:(NSString *)MD5String isUppercase:(BOOL)isUppercase {
    
    const char *str = [MD5String UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( str, (CC_LONG)MD5String.length, digest );
    //CC_MD5(str, (CC_LONG)strlen(str), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    if (isUppercase) {
        return [result uppercaseString];
    }else{
        return result;
    }
}

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
