//
//  NSString+BFMutableAttributedString.h
//  BoyFriend
//
//  Created by 祎 on 2022/5/16.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BFMutableAttributedString)

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
                                                  alignment:(NSTextAlignment)alignment;

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
                                                        selectColor:(UIColor *)selectColor;

@end

NS_ASSUME_NONNULL_END
