/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <Foundation/Foundation.h>

@interface NSString (BFJudge)

////是否是空字符串(如果字符串是nil  会调不到这个方法  所以.h不往外面引用)
//- (BOOL)isBlank;

/**
 是否是数字

 @return 是否是数字
 */
- (BOOL)bf_isNumeric;

/**
 是否包含某个字符串

 @param asubstr 字符串
 @return 是否包含某个字符串
 */
- (BOOL)bf_isContain:(NSString *)asubstr;

/**
 是否包含空格

 @return 是否包含空格
 */
- (BOOL)bf_isContainBlank;
/**
 是否只包含空白和换行符。

 @return 是否只包含空白和换行符。
 */
- (BOOL)bf_isWhitespaceAndNewlines;


/**
 判断两者是否是一样的(一样的字符串或者一样是Blank)

 @param str 字符串
 @return 是否一样
 */
- (BOOL)bf_isEqualToStringOrblank:(NSString *)str;

/**
 根据身份证获取性别，返回0是女，1是男

 @param card 身份证
 @return 性别
 */
+ (NSInteger)bf_getIDCardSex:(NSString *)card;


/**
 是否只包含中文

 @return 是否只包含中文
 */
-(BOOL)bf_stringOnlyChinese;

/**
 是否包含中文

 @return 是否包含中文
 */
- (BOOL)bf_isContainChinese;

/**
 是否是以字母开头的

 @return  是否是以字母开头的
 */
- (BOOL)bf_isMatchLetter;

/**
 是否是合法邮箱

 @return 是否是合法邮箱
 */
- (BOOL)bf_isValidEmail;

/**
 是否是合法的18位身份证号码

 @return 是否是合法的18位身份证号码
 */
- (BOOL)bf_isValidPersonID;

/**
 是否是合法密码（6-8数字或字母）

 @return 是否是合法密码（6-8数字或字母）
 */
- (BOOL)bf_isValidPassword;

/**
  是否是6位验证码

 @return  是否是6位验证码
 */
- (BOOL)bf_isValidInvitationCode;

/**
 6-16位(包含数字和字母)

 @return 6-16位(包含数字和字母)
 */
- (BOOL)bf_judgePassWordLegal;

/**
 是否是合法URL

 @return 是否是合法URL
 */
- (BOOL)bf_isValidUrl;


/**
 是否是‘digit’位小数的数字。digit:几位小数位。

 @param number 数字
 @param digit 几位小数位
 @return 是否是‘digit’位小数的数字。digit:几位小数位。
 */
+ (BOOL)bf_isDecimalForNumber:(NSString *)number withDigit:(NSInteger)digit;

@end
