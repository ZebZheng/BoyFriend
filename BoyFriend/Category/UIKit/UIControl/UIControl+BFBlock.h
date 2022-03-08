/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//MARK: - 事件block
@interface UIControl (BFBlock)

///按下
- (void)touchDown:(void (^)(void))eventBlock;
///重复按下
- (void)touchDownRepeat:(void (^)(void))eventBlock;
///在..内拖拽
- (void)touchDragInside:(void (^)(void))eventBlock;
///在..外拖拽
- (void)touchDragOutside:(void (^)(void))eventBlock;
///进入拖拽
- (void)touchDragEnter:(void (^)(void))eventBlock;
///结束拖拽
- (void)touchDragExit:(void (^)(void))eventBlock;
///点击
- (void)touchUpInside:(void (^)(void))eventBlock;
///点击后
- (void)touchUpOutside:(void (^)(void))eventBlock;
///撤销
- (void)touchCancel:(void (^)(void))eventBlock;
///值变化
- (void)valueChanged:(void (^)(void))eventBlock;
///编辑开始
- (void)editingDidBegin:(void (^)(void))eventBlock;
///编辑改变
- (void)editingChanged:(void (^)(void))eventBlock;
///编辑结束
- (void)editingDidEnd:(void (^)(void))eventBlock;
///编辑结束退出
- (void)editingDidEndOnExit:(void (^)(void))eventBlock;

@end

NS_ASSUME_NONNULL_END
