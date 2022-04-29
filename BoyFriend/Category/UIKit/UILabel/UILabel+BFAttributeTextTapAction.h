//
//  UILabel+BFAttributeTextTapAction.h
//
//  Created by LBF on 16/7/1.
//  Copyright © 2016年 LBF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFAttributeTapActionDelegate <NSObject>
@optional
/**
 *  BFAttributeTapActionDelegate
 *
 *  @param string  点击的字符串
 *  @param range   点击的字符串range
 *  @param index 点击的字符在数组中的index
 */
- (void)bf_tapAttributeInLabel:(UILabel *)label
                        string:(NSString *)string
                         range:(NSRange)range
                         index:(NSInteger)index;
@end


@interface UILabel (BFAttributeTextTapAction)

/**
 *  是否打开点击效果，默认是打开
 */
@property (nonatomic, assign) BOOL enabledTapEffect;

/**
 *  点击高亮色 默认是[UIColor lightGrayColor] 需打开enabledTapEffect才有效
 */
@property (nonatomic, strong) UIColor * tapHighlightedColor;

/**
 *  是否扩大点击范围，默认是打开
 */
@property (nonatomic, assign) BOOL enlargeTapArea;

/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)bf_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                 tapClicked:(void (^) (UILabel * label, NSString *string, NSRange range, NSInteger index))tapClick;

/**
 *  给文本添加点击事件delegate回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param delegate delegate
 */
- (void)bf_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                   delegate:(id <BFAttributeTapActionDelegate> )delegate;

/**
 *  根据range给文本添加点击事件Block回调
 *
 *  @param ranges  需要添加的Range字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)bf_addAttributeTapActionWithRanges:(NSArray <NSString *> *)ranges
                                 tapClicked:(void (^) (UILabel * label, NSString *string, NSRange range, NSInteger index))tapClick;

/**
 *  根据range给文本添加点击事件delegate回调
 *
 *  @param ranges  需要添加的Range字符串数组
 *  @param delegate delegate
 */
- (void)bf_addAttributeTapActionWithRanges:(NSArray <NSString *> *)ranges
                                   delegate:(id <BFAttributeTapActionDelegate> )delegate;

/**
 *  删除label上的点击事件
 */
- (void)bf_removeAttributeTapActions;



/// 创建富文本
/// @param sender 点击的字符串或者点击的字符串数组
/// @param string 总富文本字符串
/// @param lineSpacing 行间隙
/// @param orginFont 总富文本文本大小
/// @param orginColor 总富文本文本颜色
/// @param attributeFont 点击的富文本字体大小
/// @param attributeColor 点击的富文本字体颜色
- (NSMutableAttributedString *)bf_createAttributeWith:(id)sender
                                  string:(NSString *)string
                             lineSpacing:(CGFloat)lineSpacing
                               orginFont:(UIFont *)orginFont
                              orginColor:(UIColor *)orginColor
                           attributeFont:(UIFont *)attributeFont
                          attributeColor:(UIColor *)attributeColor;
/// 创建富文本
/// @param sender 点击的字符串或者点击的字符串数组
/// @param style 富文本段落样式
/// @param string 总富文本字符串
/// @param lineSpacing 行间隙
/// @param orginFont 总富文本文本大小
/// @param orginColor 总富文本文本颜色
/// @param attributeFont 点击的富文本字体大小
/// @param attributeColor 点击的富文本字体颜色
- (NSMutableAttributedString *)bf_createAttributeWith:(id)sender
                                                style:(NSMutableParagraphStyle *)style
                                               string:(NSString *)string
                                          lineSpacing:(CGFloat)lineSpacing
                                            orginFont:(UIFont *)orginFont
                                           orginColor:(UIColor *)orginColor
                                        attributeFont:(UIFont *)attributeFont
                                       attributeColor:(UIColor *)attributeColor;
@end

