/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIFont (BFAdd)
//MARK: - 获取是否加粗
@property (nonatomic, readonly) BOOL isBold NS_AVAILABLE_IOS(7_0);
//MARK: - 获取是否斜体
@property (nonatomic, readonly) BOOL isItalic NS_AVAILABLE_IOS(7_0);
//MARK: - 获取是否等宽字体
@property (nonatomic, readonly) BOOL isMonoSpace NS_AVAILABLE_IOS(7_0);
//MARK: - 获取是否颜色符号
@property (nonatomic, readonly) BOOL isColorGlyphs NS_AVAILABLE_IOS(7_0);
/// Font weight from -1.0 to 1.0. Regular weight is 0.0.
@property (nonatomic, readonly) CGFloat fontWeight NS_AVAILABLE_IOS(7_0);


@end
NS_ASSUME_NONNULL_END

