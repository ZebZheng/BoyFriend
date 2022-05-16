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
//MARK: - 占位文字颜色 默认#F2F2F2
@property (nonatomic, strong) UIColor * bf_placeholderColor;
//MARK: - 占位尺寸
@property (nonatomic, strong) UIFont * bf_placeholderFont;
//MARK: - 占位内间距(默认(5,5,5,5))
@property (nonatomic, assign) UIEdgeInsets bf_placeholderEdgeInsets;
//MARK: - 右下角字符提示字体大小
@property (nonatomic, strong) UIFont * bf_promptFont;
//MARK: - 右下角字符提示字体颜色
@property (nonatomic, strong) UIColor * bf_promptColor;
//MARK: - 最大显示字符限制(会自动根据该属性截取文本字符长度)
@property (nonatomic, assign) NSInteger bf_maximumLimit;
//MARK: - 右下角字符长度提示(需要设置maximumLimit属性) 默认NO  颜色#F2F2F2
@property (nonatomic, assign) BOOL bf_characterLengthPrompt;

@end


NS_ASSUME_NONNULL_END
