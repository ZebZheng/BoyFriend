//
//  BFStringTools.h
//  FastApp
//
//  Created by tangkunyin on 16/3/7.
//  Copyright © 2016年 www.shuoit.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFStringTools : NSObject

//获取UUID
+ (NSString *)uuid;
//编码
+ (NSString *)urlEncodeWithUTF8:(NSString *)sourceString;
//解码
+ (NSString *)urlDecodeWithUTF8:(NSString *)sourceString;

//判断是不是email
+ (BOOL)isValidateEmail:(NSString *)email;
//判断字符串是否是URL
+ (BOOL)isValidUrlWithStr:(NSString *)str;
//判断是否是重复或连续的6位数字
+(BOOL)isValidPassWordWithStr:(NSString *)str;


//移除掉所有Html的tag
+ (NSString *)filtHtmlTag:(NSString *)string;

//当天的日期   YYYY/MM/dd
+ (NSString *)currentDateOfToday;
//根据date计算 日期时间   yyyy年MM月dd日 HH:mm
+ (NSString *)getDateTimeString:(NSDate *)dateTime;
//给一个秒数  算出几分几秒     mm:ss
+ (NSString *)getTimeTextFromInterval:(NSTimeInterval)interval;

//是否是空对象
+ (BOOL)isEmpty:(id)object;
//去除所有的空格
+ (NSString *)trimString:(NSString *)string;
//多字符拼接后 MD5加密
+ (NSString *)md5Strings:(NSArray *)strArray;

/**
 *  将数组遍历返回由值拼接的字符串
 *  @param array     字符串数组
 *  @param connector 值之间连接的符号，默认英文逗号
 *  @return 拼接后的字符串
 */
// 将数组遍历返回由值拼接的字符串 connector 值之间连接的符号，默认英文逗号
+ (NSString *)stringFromArray:(NSArray<NSString *> *)array connector:(NSString *)connector;
/**
 *  将字符串拆分成数组
 *  @param str     字符串
 *  @param connector 值之间连接的符号，默认英文逗号
 *  @return 拆分的数组
 */
+ (NSMutableArray *)arrayFromString:(NSString *)str connector:(NSString *)connector;



//(传秒进来的)根据时间计算出  ?天 ?时 ?分 ?秒
+ (NSString *)getDayStringWithSecond:(NSInteger)value;

// 阿拉伯数字转汉字  
+ (NSString *)ChineseWithInteger:(NSInteger)integer;





@end
