//
//  UIAlertController+Extensions.h
//  Demon
//
//  Created by BoyFriend on 2018/6/27.
//  Copyright © 2018年 BoyFriend. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Extensions)


/**
 Alert 中间弹出来 (只有两个按钮)

 @param title 标题
 @param message 内容
 @param doneTitle 确定按钮的标题
 @param cancelTitle 取消按钮的掉头
 @param completeBlock 确定事件的回调
 */
+ (void)bf_presentAlertControllerWithTitle:(NSString *)title
                                message:(NSString *)message
                              doneTitle:(NSString *)doneTitle
                            cancelTitle:(NSString *)cancelTitle
                          completeBlock:(void (^)(BOOL isCancelled))completeBlock;



/**
 Action 样式(底下弹上来) 可以多个action

 @param title 标题
 @param actionTitles 所有action
 @param completed 回调,根据action的index判断
 */
+ (void)bf_presentActionControllerWithTitle:(NSString *)title
                            actionTitles:(NSArray<NSString *> *)actionTitles
                           completeBlock:(void (^)(NSString *selectTitleString, NSUInteger index))completed;


@end
