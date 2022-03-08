/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "UIButton+BFAdd.h"
#import <objc/runtime.h>

static const char BFTitleFontSizeKey;
static const char BFTitleFontKey;
static const char BFTitleKey;
static const char BFTitleColorKey;
static const char BFSelectTitleKey;
static const char BFSelectTitleColorKey;
static const char BFBackgroundImageKey;
static const char BFSelectBackgroundImageKey;
static const char BFImageKey;
static const char BFSelectImageKey;
static const char BFAttributedTextKey;
static const char BFSelectAttributedTextKey;
static const char BFTextAlignementKey;



@implementation UIButton (BFAdd)

- (void)bf_addTargetUpInside:(id)tat action:(SEL)sel {
    [self addTarget:tat action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (void)bf_imagePosition:(BFImagePosition)postitionStatus spacing:(CGFloat)spacing {
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop
    
    CGFloat imageOffsetX = (imageWith + labelWidth) / 2 - imageWith / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 - spacing;//image中心移动的y距离
    CGFloat labelOffsetX = (imageWith + labelWidth / 2) - (imageWith + labelWidth) / 2;//label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing * 2;//label中心移动的y距离
    
    switch (postitionStatus) {
        case BFImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            break;
            
        case BFImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageHeight + spacing/2), 0, imageHeight + spacing/2);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            break;
            
        case BFImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            break;
            
        case BFImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            break;
            
        default:
            break;
    }
}

///渐变背景颜色
- (void)bf_backgroundGradientColorWithType:(BFGradientType)type colors:(NSArray<UIColor *> *)colors {
    [self bf_backgroundGradientColorWithType:type size:self.bounds.size colors:colors];
}
///渐变背景颜色
- (void)bf_backgroundGradientColorWithType:(BFGradientType)type size:(CGSize)size colors:(NSArray<UIColor *> *)colors {
    UIImage * image = [UIImage bf_imageFromSize:size Colors:colors byGradientType:type];
    UIColor * color = [UIColor colorWithPatternImage:image];
    self.backgroundColor = color;
}




#pragma make ------ runtime ------
- (void)setBf_titleFont:(CGFloat)titleFont {
    objc_setAssociatedObject(self, &BFTitleFontSizeKey, @(titleFont), OBJC_ASSOCIATION_ASSIGN);
    self.titleLabel.font = [UIFont systemFontOfSize:titleFont];
}
- (CGFloat)bf_titleFont {
    return [objc_getAssociatedObject(self, &BFTitleFontSizeKey) floatValue];
}

- (void)setBf_font:(UIFont *)font {
    objc_setAssociatedObject(self, &BFTitleFontKey, font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.titleLabel.font = font;
}
- (UIFont *)bf_font {
    return objc_getAssociatedObject(self, &BFTitleFontKey);
}

- (void)setBf_titleText:(NSString *)titleText {
    objc_setAssociatedObject(self, &BFTitleKey, titleText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTitle:titleText forState:UIControlStateNormal];
}
- (NSString *)bf_titleText {
    return objc_getAssociatedObject(self, &BFTitleKey);
}

- (void)setBf_titleColor:(UIColor *)titleColor {
    objc_setAssociatedObject(self, &BFTitleColorKey, titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}
- (UIColor *)bf_titleColor {
    return objc_getAssociatedObject(self, &BFTitleColorKey);
}

- (void)setBf_selectTitle:(NSString *)selectTitle {
    objc_setAssociatedObject(self, &BFSelectTitleKey, selectTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTitle:selectTitle forState:UIControlStateSelected];
}
- (NSString *)bf_selectTitle {
    return objc_getAssociatedObject(self, &BFSelectTitleKey);
}

- (void)setBf_selectTitleColor:(UIColor *)selectTitleColor {
    objc_setAssociatedObject(self, &BFSelectTitleColorKey, selectTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTitleColor:selectTitleColor forState:UIControlStateSelected];
}
- (UIColor *)bf_selectTitleColor {
    return objc_getAssociatedObject(self, &BFSelectTitleColorKey);
}

- (void)setBf_backgroundImage:(UIImage *)backgroundImage{
    objc_setAssociatedObject(self, &BFBackgroundImageKey, backgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}
- (UIImage *)bf_backgroundImage {
    return objc_getAssociatedObject(self, &BFBackgroundImageKey);
}

- (void)setBf_selectBackgroundImage:(UIImage *)selectBackgroundImage {
    objc_setAssociatedObject(self, &BFSelectBackgroundImageKey, selectBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setBackgroundImage:selectBackgroundImage forState:UIControlStateSelected];
}
- (UIImage *)bf_selectBackgroundImage {
    return objc_getAssociatedObject(self, &BFSelectBackgroundImageKey);
}

- (void)setBf_image:(UIImage *)image {
    objc_setAssociatedObject(self, &BFImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setImage:image forState:UIControlStateNormal];
}
- (UIImage *)bf_image {
    return objc_getAssociatedObject(self, &BFImageKey);
}

- (void)setBf_selectImage:(UIImage *)selectImage {
    objc_setAssociatedObject(self, &BFSelectImageKey, selectImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setImage:selectImage forState:UIControlStateSelected];
}
- (UIImage *)bf_selectImage {
    return objc_getAssociatedObject(self, &BFSelectImageKey);
}

- (void)setBf_attributedText:(NSAttributedString *)attributedText {
    objc_setAssociatedObject(self, &BFAttributedTextKey, attributedText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setAttributedTitle:attributedText forState:UIControlStateNormal];
}
- (NSAttributedString *)bf_attributedText {
    return objc_getAssociatedObject(self, &BFAttributedTextKey);
}

- (void)setBf_selectAttributedText:(NSAttributedString *)selectAttributedText {
    objc_setAssociatedObject(self, &BFSelectAttributedTextKey, selectAttributedText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setAttributedTitle:selectAttributedText forState:UIControlStateSelected];
}
- (NSAttributedString *)bf_selectAttributedText {
    return objc_getAssociatedObject(self, &BFSelectAttributedTextKey);
}

- (void)setBf_textAlignement:(BFTextAlignement)textAlignement {
    objc_setAssociatedObject(self, &BFTextAlignementKey, @(textAlignement), OBJC_ASSOCIATION_ASSIGN);
    if (textAlignement == BFTextAlignmentLeft) {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    } else if (textAlignement == BFTextAlignmentCenter) {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    } else {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
}
- (BFTextAlignement)bf_textAlignement {
    return [objc_getAssociatedObject(self,&BFTextAlignementKey) integerValue];
}




@end
