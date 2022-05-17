/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (BFAdd)
/** HTML转成富文本 */
@property (nonatomic, copy,readonly)NSAttributedString * bf_HTMLAttributedString;
/** 首字母转换成大写 */
@property (nonatomic, copy,readonly) NSString * bf_firstCharUpper;
/** 首字母转换成小写 */
@property (nonatomic, copy,readonly) NSString * bf_firstCharLower;
/** json 转 dictionary */
@property (nonatomic, copy,readonly)NSDictionary * bf_jsonConversionDictionary;


/** string judge empty */
+ (BOOL)bf_judgeEmpty:(NSString *)str;

/** dateString from formatter */
- (NSString *)bf_dateStringFromFormat:(NSString *)format;

/*
 *  @brief 计算文字的宽度
 *
 *  param font   字体(默认为系统字体)
 *  param height 约束高度
 */
- (CGFloat)bf_widthWithFontConstrainedToHeight:(CGFloat)height font:(UIFont *)font;

/**
 *  @brief 计算文字的高度
 *
 *  param font  字体(默认为系统字体)
 *  param width 约束宽度
 */
- (CGFloat)bf_heightWithFontConstrainedToWidth:(CGFloat)width font:(UIFont *)font;

/**
 *  @brief 计算文字的大小
 *
 *  param font   字体(默认为系统字体)
 *  param height 约束高度
 */
- (CGSize)bf_sizeWithFontConstrainedToHeight:(CGFloat)height font:(UIFont *)font;

/**
 *  @brief 计算文字的大小
 *
 *  param font  字体(默认为系统字体)
 *  param width 约束宽度
 */
- (CGSize)bf_sizeWithFontConstrainedToWidth:(CGFloat)width font:(UIFont *)font;


/** 拼接字符串判空 */
+ (instancetype)stringWithFormatNoNull:(NSString *)format, ... ;
/** 用字符串中的数字的值进行比较 */
- (NSComparisonResult)compareByCasesNumeric:(NSString *)anotherCom;
/** 不区分大小写 */
- (NSComparisonResult)compareByCaseInsensitive:(NSString *)anotherCom;
/** 区分大小写 */
- (NSComparisonResult)compareByCaseSensitive:(NSString *)anotherCom;

@end


