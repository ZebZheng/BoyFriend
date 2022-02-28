//
//  NSString+Extension.h
//  Demon
//
//  Created by apple on 2019/1/31.
//  Copyright © 2019年 BoyFriend. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BFExtension)

/**
 去除头尾空格和换行符

 @return 返回去除头尾空格后的字符串
 */
- (NSString *)bf_trim;
/**
 去除所有空格
 
 @return 返回去除所有空格
 */
- (NSString *)bf_trimAllSpace;

/**
 去除开头的某个字符串

 @param strBegin 要去除的字符串
 @return 返回去除后的字符串
 */
- (NSString *)bf_trimBegin:(NSString *)strBegin;

/**
 去除结尾的某个字符串

 @param strEnd 要去除的字符串
 @return 返回去除后的字符串
 */
- (NSString *)bf_trimEnd:(NSString *)strEnd;

/**
 替换某个字符串

 @param strOld 要替换的旧的字符串
 @param strNew 替换的新的字符串
 @return 替换完成后的字符串
 */
- (NSString *)bf_replaceOldString:(NSString *)strOld WithNewString:(NSString *)strNew;

/**
 反转字符串

 @return 反转后字符串
 */
- (NSString *)bf_reverseString;

/**
 数字金额转为汉子(例如:12.5 ->壹拾贰元伍角零分)

 @return 返回转换后的汉字
 */
- (NSString *)bf_numberUppercaseString;

@end
