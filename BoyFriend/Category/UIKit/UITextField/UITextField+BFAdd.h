/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>


@interface UITextField (BFAdd)
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor * bf_placeholderColor;
/** 最大显示字符限制(会自动根据该属性截取文本字符长度) */
@property (nonatomic, assign) NSInteger bf_maximumLimit;

/**
 *  文本发生改变时回调
 */
- (void)bf_textDidChange:(void (^)(NSString *string))handle;
/**
 *  处理系统输入法导致的乱码,如果调用了maximumLimit属性，内部会默认处理乱码
 */
- (void)bf_fixMessyDisplay;

@end


