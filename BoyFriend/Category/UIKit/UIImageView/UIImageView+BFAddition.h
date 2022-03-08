/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (BFAddition)

//MARK: - 根据bundle中的图片名创建imageview
/// @param imageName bundle中的图片名
+ (id)bf_imageViewWithImageNamed:(NSString*)imageName;
//MARK: - 根据frame创建imageview
/// @param frame imageview frame
+ (id)bf_imageViewWithFrame:(CGRect)frame;

//MARK: - 能伸展的图片
+ (id)bf_imageViewWithStretchableImage:(NSString*)imageName Frame:(CGRect)frame;
//MARK: -  创建imageview动画
/// @param imageArray 图片名称数组
/// @param duration 动画时间
+ (id)bf_imageViewWithImageArray:(NSArray*)imageArray duration:(NSTimeInterval)duration;
- (void)bf_setImageWithStretchableImage:(NSString*)imageName;


//MARK: -  图片水印
- (void)bf_setImage:(UIImage *)image withWaterMark:(UIImage *)mark inRect:(CGRect)rect;
//MARK: -  文字水印
- (void)bf_setImage:(UIImage *)image withStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;
//MARK: -  文字水印
- (void)bf_setImage:(UIImage *)image withStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
