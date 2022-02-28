/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <Foundation/Foundation.h>

@interface NSString (BFHGBTransForm)

/**
 十六进制转换为普通字符串的
 @return 普通字符串
 */
- (NSString *)bf_stringFromHexString;
/**
 普通字符串转换为十六进制的
 
 @return 十六进制字符串
 */
- (NSString *)bf_hexString;

/**
 *  身份证号码转生日
 *
 *
 *  @return 生日
 */
-(NSString *)bf_idCardNumTransToBirthday;


@end
