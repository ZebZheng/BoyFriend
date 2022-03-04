//
//  UILabel+BFAttributeTextTapAction.h
//
//  Created by LYB on 16/7/1.
//  Copyright © 2016年 LYB. All rights reserved.
//
//  给文本添加点击事件Block回调 或者 添加点击事件delegate回调
// block 回调
/*
 数组里面是需要点击的字符串
 [ybLabel2 yb_addAttributeTapActionWithStrings:@[@"www.yb.com",@"9527"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
 NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),index];
 YBAlertShow(message, @"取消");
 }];
 
 */


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
- (void)bf_attributeTapReturnString:(NSString *)string
                              range:(NSRange)range
                              index:(NSInteger)index;
@end

@interface BFAttributeModel : NSObject

@property (nonatomic, copy) NSString *str;

@property (nonatomic, assign) NSRange range;

@end





@interface UILabel (BFAttributeTextTapAction)

/**
 *  是否打开点击效果，默认是打开
 */
@property (nonatomic, assign) BOOL enabledTapEffect;

/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)yb_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                 tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

/**
 *  给文本添加点击事件delegate回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param delegate delegate
 */
- (void)yb_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                   delegate:(id <BFAttributeTapActionDelegate> )delegate;

@end

