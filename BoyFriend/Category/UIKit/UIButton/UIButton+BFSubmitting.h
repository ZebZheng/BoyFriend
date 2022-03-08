/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

@interface UIButton (BFSubmitting)

/**
 按钮点击后，禁用按钮并在按钮上显示ActivityIndicator，以及title

 @param title 按钮上显示的文字
 */
- (void)bf_beginSubmitting:(NSString *)title;

/**
 按钮点击后，恢复按钮点击前的状态
 */
- (void)bf_endSubmitting;


/**
 按钮是否正在提交中
 */
@property(nonatomic, readonly, getter=isSubmitting) NSNumber *bf_submitting;

@end
