//
//  BFStringTools.m
//  FastApp
//
//  Created by tangkunyin on 16/3/7.
//  Copyright © 2016年 www.shuoit.net. All rights reserved.
//

#import "BFStringTools.h"

@implementation BFStringTools

+ (NSString *)uuid
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef cfStr = CFUUIDCreateString(NULL, uuid);
    
    NSString *ret = [NSString stringWithString:(__bridge NSString *)cfStr];
    
    CFRelease(uuid);
    CFRelease(cfStr);
    
    return ret;
}

//编码
+ (NSString *)urlEncodeWithUTF8:(NSString *)sourceString
{
    NSString *encoderStr = [sourceString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encoderStr;
}

//解码
+ (NSString *)urlDecodeWithUTF8:(NSString *)sourceString
{
    NSString *decoderStr = [sourceString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return decoderStr;
}

//判断字符串是否是邮箱
+ (BOOL)isValidateEmail:(NSString *)email
{
    //利用正则表达式验证
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//判断字符串是否是URL
+ (BOOL)isValidUrlWithStr:(NSString *)str
{
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:str];
}
//判断是否是重复或连续的6位数字
+(BOOL)isValidPassWordWithStr:(NSString *)str{
    if ([str length] == 6){
        NSInteger a=[[str substringWithRange:NSMakeRange(0, 1)] integerValue];
        NSInteger b=[[str substringWithRange:NSMakeRange(1, 1)] integerValue];
        NSInteger c=[[str substringWithRange:NSMakeRange(2, 1)] integerValue];
        NSInteger d=[[str substringWithRange:NSMakeRange(3, 1)] integerValue];
        NSInteger e=[[str substringWithRange:NSMakeRange(4, 1)] integerValue];
        NSInteger f=[[str substringWithRange:NSMakeRange(5, 1)] integerValue];
        if (a-b==b-c&&b-c==c-d&&c-d==d-e&&d-e==e-f) {
            if (a-b==0||a-b==1||a-b==-1) {
                return NO;
            } else {
                return YES;
            }
        } else {
            return YES;
        }
    }
    return NO;
}
#pragma mark - method 1
+ (NSMutableArray *)matchLinkWithStr:(NSString *)str withMatchStr:(NSString *)matchRegex;
{
    NSError *error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:matchRegex
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:&error];
    NSArray *match = [reg matchesInString:str
                                  options:NSMatchingReportCompletion
                                    range:NSMakeRange(0, [str length])];
    
    NSMutableArray *rangeArr = [NSMutableArray array];
    // 取得所有的NSRange对象
    if(match.count != 0)
    {
        for (NSTextCheckingResult *matc in match)
        {
            NSRange range = [matc range];
            NSValue *value = [NSValue valueWithRange:range];
            [rangeArr addObject:value];
        }
    }
    // 将要匹配的值取出来,存入数组当中
    __block NSMutableArray *mulArr = [NSMutableArray array];
    [rangeArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSValue *value = (NSValue *)obj;
        NSRange range = [value rangeValue];
        
        NSString *subString = [str substringWithRange:range];
        
        if (![mulArr containsObject:subString]) {
            [mulArr addObject:subString];
        }
        
    }];
    return mulArr;
}

//移除掉所有Html的tag
+ (NSString *)filtHtmlTag:(NSString *)string
{
    if (!string) {
        return @"";
    }
    
    NSString* startTag = @"<";
    NSString* endTag = @">";
    
    NSString* regularExpressionString  = [[NSString alloc] initWithFormat:@"%@.*?%@", startTag, endTag];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpressionString
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:NULL];
    NSString* result = [regex stringByReplacingMatchesInString:string
                                                       options:0
                                                         range:NSMakeRange(0, string.length)
                                                  withTemplate:@"$2"];
    
    return result;
}


+ (NSString *)currentDateOfToday
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *nowFormatter = [[NSDateFormatter alloc]init];
    [nowFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString *nowDateStr = [nowFormatter stringFromDate:nowDate];
    return nowDateStr;
}

+ (NSString *)getDateTimeString:(NSDate *)dateTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日 HH:mm";
    NSString *str = [formatter stringFromDate:dateTime];
    return str;
}

+ (NSString*)getTimeTextFromInterval:(NSTimeInterval)interval
{
    long min = (long)interval / 60;    // divide two longs, truncates
    long sec = (long)interval % 60;    // remainder of long divide
    NSString* str = [NSString stringWithFormat:@"%02ld:%02ld", min, sec];
    return str;
}

+ (BOOL)isEmpty:(id)object
{
    if (!object) {
        return YES;
    }
    if ((NSNull *)object == [NSNull null]) {
        return YES;
    }
    if ([object isKindOfClass:[NSString class]]) {
        NSString *strObject = (NSString *)object;
        return [[strObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""];
    }
    return NO;
}
//去除所有的空格
+ (NSString *)trimString:(NSString *)string
{
    //去除前后空格
    NSString *trimedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //创建一个正则表达式对象，存储匹配规则(\\s在正则里就是空格)
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s" options:0 error:nil];
    //用新字段替换原文本中的对应字段，并返回操作后的NSString
    NSString *finalTrimedString = [regex stringByReplacingMatchesInString:trimedString
                                                                  options:0
                                                                    range:NSMakeRange(0, [trimedString length])
                                                             withTemplate:@""];
    return finalTrimedString;
}


+ (NSString *)md5Strings:(NSArray *)strArray
{
    NSMutableString *string = [NSMutableString stringWithString:@""];
    for (NSString *str in strArray) {
        [string appendString:str];
    }
    NSString *mdtString = string.md5String;
    return mdtString;
}

+ (NSString *)stringFromArray:(NSArray<NSString *> *)array connector:(NSString *)connector
{
    if (array.count ==0) return @"";
    if (array.count == 1) return array.firstObject;
    
    NSMutableString *sb = [NSMutableString stringWithString:@""];
    connector = ([BFStringTools isEmpty:connector]) ? @"," : connector;
    for (NSString *str in array) {
        [sb appendFormat:@"%@%@",str,connector];
    }
    return [sb substringToIndex:sb.length-1];
}

+(NSMutableArray *)arrayFromString:(NSString *)str connector:(NSString *)connector{
    NSMutableArray *marr=[NSMutableArray new];
    if (str.length>0) {
        connector = ([BFStringTools isEmpty:connector]) ? @"," : connector;
        [marr addObjectsFromArray:[str componentsSeparatedByString:connector]];
    }
    return marr;
}



//(传秒进来的)根据时间计算出  ?天 ?时 ?分 ?秒
+(NSString *)getDayStringWithSecond:(NSInteger)value{
    NSInteger day = value /(24 * 3600);
    NSInteger house = ((value-day*24*3600)/3600);
    NSInteger minute = (value-day*24*3600-house*3600)/60;
    NSInteger second = (value-day*24*3600-house*3600-minute*60);
    NSString *str=@"";
    if (day != 0) {
        str = [NSString stringWithFormat:@"%ld天",day];
    }
    if (house != 0) {
        str = [NSString stringWithFormat:@"%@%ld小时",str,house];
    }
    if (minute!=0) {
        str = [NSString stringWithFormat:@"%@%ld分",str,minute];
    }
    if (second!=0) {
        str = [NSString stringWithFormat:@"%@%ld秒",str,second];
    }
    return str;
}

// 阿拉伯数字转汉字
+(NSString *)ChineseWithInteger:(NSInteger)integer{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt:(int)integer]];
    return string;
}


@end
