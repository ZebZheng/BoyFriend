/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BFEncryption)
#pragma mark - MD5
/** 16位MD5加密--小写 */
@property (nonatomic, copy,readonly)NSString * bf_MD5Bits16LowercaseEncryption;
/** 16位MD5加密--大写 */
@property (nonatomic, copy,readonly)NSString * bf_MD5Bits16UppercaseEncryption;
/** 32位MD5加密--小写 */
@property (nonatomic, copy,readonly)NSString * bf_MD5Bits32LowercaseEncryption;
/** 32位MD5加密--大写 */
@property (nonatomic, copy,readonly)NSString * bf_MD5Bits32UppercaseEncryption;

#pragma mark - base64
/// base64
@property (nonatomic, copy,readonly)NSString * bf_base64String;

///base64加密
+(NSString *)bf_base64EncodingWithData:(NSData *)sourceData;
///base64解密
+(NSData *)bf_base64EncodingWithString:(NSString *)sourceString;

#pragma mark - UTF-8
///编码
- (NSString *)bf_urlEncodeWithUTF8;
///编码
- (NSString *)bf_urlEncodeWithUTF8:(NSCharacterSet *)characterSet;
///解码
- (NSString *)bf_urlDecodeWithUTF8;

#pragma mark - gb2312
///GB2312转成utf8Data
- (NSData *)bf_UTF8WithGB2312Data:(NSData *)gb2312Data;
///UTF8转成gb2312Data
- (NSData *)bf_GB2312WithUTF8Data:(NSData *)UTF8Data;

#pragma mark - MD5
/// 16位MD5加密
/// @param isUppercase 是否大写
+ (NSString *)bf_MD5_16BitEncry:(NSString *)MD5String isUppercase:(BOOL)isUppercase;
/// 16位MD5加密
/// @param isUppercase 是否大写
+ (NSString *)bf_MD5_NB16BitEncry:(NSString *)MD5String isUppercase:(BOOL)isUppercase;
/// 32位MD5加密
/// @param isUppercase 是否大写
+ (NSString *)bf_MD5_32BitEncry:(NSString *)MD5String isUppercase:(BOOL)isUppercase;
/// 32位MD5加密
/// @param isUppercase 是否大写
+ (NSString *)bf_MD5_NB32BitEncry:(NSString *)MD5String isUppercase:(BOOL)isUppercase;
@end

NS_ASSUME_NONNULL_END
