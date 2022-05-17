/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "NSString+BFConversion.h"

@implementation NSString (BFConversion)

/// 阿拉伯数字转换成中文
+ (NSString *)bf_digitalConversionNumber:(int)number {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans"];
    formatter.locale = locale;
    formatter.numberStyle = NSNumberFormatterNoStyle;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithDouble:number]];
    return string;
}
    
///汉语数字转阿拉伯数字
+(NSString *)bf_chaptersDealWithString:(NSString *)chapterStr {
    NSString *str = chapterStr;
    NSArray * chapter_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys: chapter_numerals];
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        
        [sums addObject:sum];
    }
    
    NSString *sumStr = [sums  componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
    NSLog(@"%@",str);
    NSLog(@"%@",chinese);
    return chinese;
}

- (NSArray *)bf_toArray {
    return [self componentsSeparatedByString:@","];
}
- (NSArray *)bf_toArrayByString:(NSString *)string {
    return [self componentsSeparatedByString:string];
}

- (NSData *)bf_toData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (UIImage *)bf_base64ToImage {
    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *photo = [UIImage imageWithData:imageData];
    return photo;
}

///适配网页图片
- (NSString *)bf_autoHtmlImage {
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                               "<head> \n"
                               "<style type=\"text/css\"> \n"
                               "p {width:100%%}\n"
                               "img {width:100%%!important;height:auto!important}\n"
                               "</style> \n"
                               "</head> \n"
                               "<body>"
                               "%@"
                               "</body>"
                               "</html>",self];
    return htmls;
}

///适配网页文本图片
- (NSString *)autoHtmlFontAndImage {
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                               "<head> \n"
                               "<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>\n"
                               "<style type=\"text/css\"> \n"
                               "p {width:100%%}\n"
                               "img {width:100%%!important;height:auto!important}\n"
                               "</style> \n"
                               "</head> \n"
                               "<body>"
                               "%@"
                               "</body>"
                               "</html>",self];
    return htmls;
}





@end
