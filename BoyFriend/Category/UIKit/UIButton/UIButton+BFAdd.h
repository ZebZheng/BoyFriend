/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/


#import <UIKit/UIKit.h>
#import "UIView+BFAdd.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, BFButtonTextAlignement) {
    BFButtonTextAlignmentLeft,
    BFButtonTextAlignmentCenter,
    BFButtonTextAlignmentRight
};

@interface UIButton (BFAdd)

//MARK: - 文本字体大小
@property (nonatomic, assign) CGFloat bf_titleFont;
//MARK: - 文本字体大小
@property (nonatomic, assign) UIFont * bf_font;
//MARK: - 文本对齐
@property (nonatomic, assign) BFButtonTextAlignement bf_textAlignement;

//MARK: - 文本
@property (nonatomic, copy) NSString * bf_titleText;
//MARK: - 文本颜色
@property (nonatomic, strong) UIColor * bf_titleColor;
//MARK: - 图片
@property (nonatomic, strong) UIImage * bf_image;
//MARK: - 背景图片
@property (nonatomic, strong) UIImage * bf_backgroundImage;
//MARK: - 富文本
@property (nonatomic, copy) NSAttributedString * bf_attributedText;

//MARK: - 选中文本
@property (nonatomic, copy) NSString * bf_selectTitle;
//MARK: - 选中文本颜色
@property (nonatomic, strong) UIColor * bf_selectTitleColor;
//MARK: - 选中图片
@property (nonatomic, strong) UIImage * bf_selectImage;
//MARK: - 选中背景图片
@property (nonatomic, strong) UIImage * bf_selectBackgroundImage;
//MARK: - 选中富文本
@property (nonatomic, copy) NSAttributedString * bf_selectAttributedText;

//MARK: - 设置按钮额外点击区域
@property (nonatomic, assign) UIEdgeInsets bf_touchAreaInsets;

/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)bf_backgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

//MARK: - 点击事件
- (void)bf_addTargetUpInside:(nullable id)tat action:(nonnull SEL)sel;

//MARK: - 渐变背景颜色
- (void)bf_backgroundGradientColorWithType:(BFGradientType)type colors:(NSArray *)colors;
//MARK: - 渐变背景颜色
- (void)bf_backgroundGradientColorWithType:(BFGradientType)type size:(CGSize)size colors:(NSArray<UIColor *> *)colors;

@end


NS_ASSUME_NONNULL_END
