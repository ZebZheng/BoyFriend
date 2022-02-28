//
//  CocoaTextUtil.h
//  Lemeng
//
//  Created by wangjian on 14-11-6.
//  Copyright (c) 2014年 Xiamen justit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
@interface BFAttributeStringUtil : NSObject

#pragma mark - 设置富文本样式
/**
 设置 行距

 @param string 可变富文本
 @param space 距离
 @param range 位置
 */
+(void)setAttributeString:(NSMutableAttributedString*)string space:(CGFloat)space range:(NSRange)range;

/**
 设置 颜色

 @param string 可变富文本
 @param color 颜色
 @param range 位置
 */
+(void)setAttributeString:(NSMutableAttributedString*)string color:(UIColor*)color range:(NSRange)range;

/**
 设置 字体

 @param string 可变富文本
 @param font 字体
 @param range 位置
 */
+(void)setAttributeString:(NSMutableAttributedString*)string font:(UIFont*)font range:(NSRange)range;

/**
 添加 下划线

 @param string 可变富文本
 @param color 下划线颜色
 @param range 位置
 */
+(void)setAttributeString:(NSMutableAttributedString *)string underLineWithColor:(UIColor *)color range:(NSRange)range;

/**
 添加 删除线
 
 @param string 可变富文本
 @param color 删除线颜色
 @param range 位置
 */
+(void)setAttributeString:(NSMutableAttributedString *)string withStrikeThroughColor:(UIColor*)color range:(NSRange)range;

/**
 设置 背景色

 @param string 可变富文本
 @param color 背景色
 @param range 位置
 */
+(void)setAttributeString:(NSMutableAttributedString *)string backgroundColor:(UIColor *)color range:(NSRange)range;


/**
 设置 行高

 @param string 可变富文本
 @param height 行高
 @param range 位置
 */
+(void)setAttributeString:(NSMutableAttributedString *)string lineHeight:(CGFloat)height range:(NSRange)range;


/**
 设置多种样式 (文本颜色 行高 字体)

 @param string 可变富文本
 @param color 文本颜色
 @param height 行高(不设置可传0)
 @param font 字体
 @param range 位置
 */
+(void)setAttributeString:(NSMutableAttributedString *)string  color:(UIColor*)color lineHeight:(CGFloat)height font:(UIFont*)font range:(NSRange)range;

#pragma mark - coredata 属性字典
/**
 coredata 属性字典(颜色,行高,字号)

 @param color 颜色
 @param lineHeight 行高
 @param font 字号
 @return 属性字典
 */
+(NSDictionary*)attributeWithColor:(UIColor*)color
                        lineHeight:(CGFloat)lineHeight
                              font:(UIFont*)font;


/**
 coredata 属性字典(颜色,行高,字号,基线偏移值-往上往下偏)

 @param color 颜色
 @param lineHeight 行高
 @param font 字体
 @param offset 设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
 @return 属性字典
 */
+(NSDictionary*)attributeWithColor:(UIColor*)color
                        lineHeight:(CGFloat)lineHeight
                              font:(UIFont*)font
                          baseLine:(CGFloat)offset;


#pragma mark - 富文本相关操作
/**
 获取富文本高度

 @param string 富文本
 @param width 宽度
 @return 富文本高度
 */
+(CGFloat)getAttributedStringHeightWithString:(NSAttributedString *)string  WidthValue:(CGFloat)width;

/**
 系统方法获取 attributed string 高度
 
 @param string 富文本
 @param width 宽度
 @return 返回高度
 */
+(CGFloat)sysGetAttributedString:(NSAttributedString *)string heightWithWidth:(CGFloat)width;

/**
 系统方法获取 attributed string 大小
 
 @param string 富文本
 @param width 高度
 @return CGRect
 */
+(CGRect)rectOfAttributedString:(NSAttributedString *)string heightWithWidth:(CGFloat)width;




/**
 往富文本插入图片

 @param image 图片
 @param bounds 图片大小
 @param index 插入的位置
 @param string 富文本
 */
+(void)insertImage:(UIImage*)image bounds:(CGRect)bounds index:(NSUInteger)index toAttrString:(NSMutableAttributedString*)string;


/**
 HTML 格式 转换成 富文本

 @param string HTML文本
 @return 富文本
 */
+(NSAttributedString*)getHtmlAttributeString:(NSString*)string;





@end
