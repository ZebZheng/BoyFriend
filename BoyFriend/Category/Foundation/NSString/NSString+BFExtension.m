/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "NSString+BFExtension.h"

@implementation NSString (BFExtension)

///按照中文 2 个字符、英文 1 个字符的方式来计算文本长度
- (NSUInteger)bf_lengthWhenCountingNonASCIICharacterAsTwo {
    NSUInteger length = 0;
    for (NSUInteger i = 0, l = self.length; i < l; i++) {
        unichar character = [self characterAtIndex:i];
        if (isascii(character)) {
            length += 1;
        } else {
            length += 2;
        }
    }
    return length;
}



- (NSString *)bf_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (NSString *)bf_trimAllSpace {
    NSString *str = self;
    // 去掉首尾空格和换行符
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // 去掉所有空格
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}

- (NSString *)bf_trimBegin:(NSString *)strBegin {
    if ([strBegin length] == 0) {
        return self;
    }
    if ([self hasPrefix:strBegin]) {
        return [self substringFromIndex:[strBegin length]];
    } else
        return self;
}

- (NSString *)bf_trimEnd:(NSString *)strEnd {
    if ([strEnd length] == 0) {
        return self;
    }
    if ([self hasSuffix:strEnd]) {
        return [self substringToIndex:[self length] - [strEnd length]];
    }
    return self;
}

- (NSString *)bf_replaceOldString:(NSString *)strOld WithNewString:(NSString *)strNew {
    NSMutableString *strMutale = [NSMutableString stringWithString:self];
    NSRange r;
    r.location = 0;
    r.length = [self length];
    [strMutale replaceOccurrencesOfString:strOld withString:strNew options:NSCaseInsensitiveSearch range:r];
    return [NSString stringWithString:strMutale];
}

- (NSString *)bf_numberUppercaseString {
    NSMutableString *moneyStr=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%.2f",[self doubleValue]]];
    NSArray *moneyScales = @[@"分", @"角", @"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
    NSArray *numberUppercaseStrings = @[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    NSMutableString *resultString = [[NSMutableString alloc] init];
    [moneyStr deleteCharactersInRange:NSMakeRange([moneyStr rangeOfString:@"."].location, 1)];
    for(NSInteger i = moneyStr.length;i>0;i--) {
        NSInteger MyData=[[moneyStr substringWithRange:NSMakeRange(moneyStr.length-i, 1)] integerValue];
        [resultString appendString:numberUppercaseStrings[MyData]];
        if([[moneyStr substringFromIndex:moneyStr.length-i+1] integerValue]==0&&i!=1&&i!=2) {
            [resultString appendString:@"元"];
            break;
        }
        [resultString appendString:moneyScales[i-1]];
    }
    return resultString;
}
/**
 *  @brief  反转字符串
 *
 *  @return 反转后字符串
 */
- (NSString *)bf_reverseString
{
    NSMutableString* reverseString = [[NSMutableString alloc] init];
    NSString * strSrc=self;
    NSInteger charIndex = [strSrc length];
    while (charIndex > 0) {
        charIndex --;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reverseString appendString:[strSrc substringWithRange:subStrRange]];
    }
    return reverseString;
}
@end
