/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/


#import <UIKit/UIKit.h>
#import "UIView+BFAdd.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, BFTextAlignement) {
    BFTextAlignmentLeft,
    BFTextAlignmentCenter,
    BFTextAlignmentRight
};

typedef NS_ENUM(NSUInteger, BFImagePosition) {
    BFImagePositionLeft = 0,              //图片在左，文字在右，默认
    BFImagePositionRight = 1,             //图片在右，文字在左
    BFImagePositionTop = 2,               //图片在上，文字在下
    BFImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (BFAdd)
//MARK: - 文本字体大小
@property (nonatomic, assign) CGFloat bf_titleFont;
//MARK: - 文本字体大小
@property (nonatomic, assign) UIFont * bf_font;
//MARK: - 文本对齐
@property (nonatomic, assign) BFTextAlignement bf_textAlignement;

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

//MARK: - 点击事件
- (void)bf_addTargetUpInside:(nullable id)tat action:(nonnull SEL)sel;

//MARK: - 图文位置
- (void)bf_imagePosition:(BFImagePosition)postitionStatus spacing:(CGFloat)spacing;
//MARK: - 渐变背景颜色
- (void)bf_backgroundGradientColorWithType:(BFGradientType)type colors:(NSArray *)colors;
//MARK: - 渐变背景颜色
- (void)bf_backgroundGradientColorWithType:(BFGradientType)type size:(CGSize)size colors:(NSArray<UIColor *> *)colors;
@end


NS_ASSUME_NONNULL_END
