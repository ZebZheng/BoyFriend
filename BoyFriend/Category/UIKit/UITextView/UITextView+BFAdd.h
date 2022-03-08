/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>
#import <objc/runtime.h>


NS_ASSUME_NONNULL_BEGIN
@interface UITextView (BFAdd)

//MARK: - 编辑中代理block
@property (nonatomic, copy) void(^bf_textHandle) (NSString *textStr);
//MARK: - 占位文字
@property (nonatomic, copy) NSString * bf_placeholder;
//MARK: - 占位文字颜色
@property (nonatomic, strong) UIColor * bf_placeholderColor;
//MARK: - 最大显示字符限制(会自动根据该属性截取文本字符长度)
@property (nonatomic, assign) NSInteger bf_maximumLimit;
//MARK: - 右下角字符长度提示(需要设置maximumLimit属性)，与占位文本颜色、字号一致  默认NO
@property (nonatomic, assign) BOOL bf_characterLengthPrompt;
//MARK: - 右下角字符提示字体大小
@property (nonatomic, strong) UIFont * bf_promptFont;

@end


NS_ASSUME_NONNULL_END
