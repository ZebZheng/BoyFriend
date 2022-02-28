/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#import <UIKit/UIKit.h>
@interface UITextField (BFBlocks)
/// 返回NO不允许编辑。
@property (copy, nonatomic) BOOL (^bf_shoulBFeginEditingBlock)(UITextField *textField);
/// 返回YES以允许停止编辑并退出第一响应器状态。NO表示不允许结束编辑会话
@property (copy, nonatomic) BOOL (^bf_shouldEndEditingBlock)(UITextField *textField);
/// 成为第一个回答者
@property (copy, nonatomic) void (^bf_diBFeginEditingBlock)(UITextField *textField);
/// 可能被强制调用，即使shouldEndEditing返回NO(例如，视图从窗口删除)或enditing:YES调用
@property (copy, nonatomic) void (^bf_didEndEditingBlock)(UITextField *textField);
/// 返回NO不改变文本
@property (copy, nonatomic) BOOL (^bf_shouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *replacementString);
/// 当按“返回”键时调用。返回NO来忽略。
@property (copy, nonatomic) BOOL (^bf_shouldReturnBlock)(UITextField *textField);
/// 当清除按钮被按下时调用。返回NO以忽略(没有通知)
@property (copy, nonatomic) BOOL (^bf_shouldClearBlock)(UITextField *textField);

- (void)setBf_shoulBFeginEditingBlock:(BOOL (^)(UITextField *textField))shoulBFegindEditingBlock;
- (void)setBf_shouldEndEditingBlock:(BOOL (^)(UITextField *textField))shouldEndEditingBlock;
- (void)setBf_diBFeginEditingBlock:(void (^)(UITextField *textField))diBFeginEditingBlock;
- (void)setBf_didEndEditingBlock:(void (^)(UITextField *textField))didEndEditingBlock;
- (void)setBf_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))shouldChangeCharactersInRangeBlock;
- (void)setBf_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock;
- (void)setBf_shouldReturnBlock:(BOOL (^)(UITextField *textField))shouldReturnBlock;
@end
