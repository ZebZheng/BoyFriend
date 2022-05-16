//
//  NSString+BFMutableAttributedString.m
//  BoyFriend
//
//  Created by 祎 on 2022/5/16.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "NSString+BFMutableAttributedString.h"

@implementation NSString (BFMutableAttributedString)


/// 创建富文本 - 大小-颜色-行间距-对齐方式
/// @param string 总富文本字符串
/// @param attributeFont 富文本字体大小
/// @param attributeColor 富文本字体颜色
/// @param selectData 点击的字符串或者点击的字符串数组
/// @param selectFont 点击字体
/// @param selectColor 点击文本颜色
/// @param lineSpacing 行间距
/// @param alignment 对齐方式
- (NSMutableAttributedString *)bf_createAttributeWithString:(NSString *)string
                                              attributeFont:(UIFont *)attributeFont
                                             attributeColor:(UIColor *)attributeColor
                                                 selectData:(id)selectData
                                                 selectFont:(UIFont *)selectFont
                                                selectColor:(UIColor *)selectColor
                                                lineSpacing:(CGFloat)lineSpacing
                                                  alignment:(NSTextAlignment)alignment {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing]; //设置行间距
    [paragraphStyle setAlignment:alignment];
    return [self bf_createAttributeWithParagraphStyle:paragraphStyle string:string attributeFont:attributeFont attributeColor:attributeColor selectData:selectData selectFont:selectFont selectColor:selectColor];
}


/// 创建富文本   段落-字体-颜色
/// @param paragraphStyle 段落样式
/// @param string 总富文本字符串
/// @param attributeFont 富文本字体大小
/// @param attributeColor 富文本字体颜色
/// @param selectData 点击的字符串或者点击的字符串数组
/// @param selectFont 点击字体
/// @param selectColor 点击文本颜色
- (NSMutableAttributedString *)bf_createAttributeWithParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle
                                                             string:(NSString *)string
                                                      attributeFont:(UIFont *)attributeFont
                                                     attributeColor:(UIColor *)attributeColor
                                                         selectData:(id)selectData
                                                         selectFont:(UIFont *)selectFont
                                                        selectColor:(UIColor *)selectColor {
    __block  NSMutableAttributedString *totalStr = [[NSMutableAttributedString alloc] initWithString:string];
    [totalStr addAttribute:NSFontAttributeName value:attributeFont range:NSMakeRange(0, string.length)];
    [totalStr addAttribute:NSForegroundColorAttributeName value:attributeColor range:NSMakeRange(0, string.length)];
    [totalStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalStr length])];
    if ([selectData isKindOfClass:[NSArray class]]) {
        
        __block NSString *oringinStr = string;
        __weak typeof(self) weakSelf = self;
        [selectData enumerateObjectsUsingBlock:^(NSString *  _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [oringinStr rangeOfString:str];
            [totalStr addAttribute:NSFontAttributeName value:selectFont range:range];
            [totalStr addAttribute:NSForegroundColorAttributeName value:selectColor range:range];
            oringinStr = [oringinStr stringByReplacingCharactersInRange:range withString:[weakSelf getStringWithRange:range]];
        }];
        
    }else if ([selectData isKindOfClass:[NSString class]]) {
        
        NSRange range = [string rangeOfString:selectData];
        [totalStr addAttribute:NSFontAttributeName value:selectFont range:range];
        [totalStr addAttribute:NSForegroundColorAttributeName value:selectColor range:range];
    }
    return totalStr;
}

- (NSString *)getStringWithRange:(NSRange)range
{
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < range.length ; i++) {
        [string appendString:@" "];
    }
    return string;
}

@end
