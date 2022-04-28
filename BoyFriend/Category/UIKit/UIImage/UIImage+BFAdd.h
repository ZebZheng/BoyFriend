/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/


#import <UIKit/UIKit.h>

typedef enum  {
    ///垂直
    BFGradientTypeVertical ,
    ///水平
    BFGradientTypeHorizontal ,
    ///左上到右下
    BFGradientTypeUpLeftToBottomRight ,
    ///右上到左下
    BFGradientTypeUpRightToBottomLeft
} BFGradientType;

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (BFAdd)

/** image conversion base64 */
@property (nonatomic, copy, readonly,nullable)NSString * bf_base64String;

//MARK: - 渐变色
/// @param size 大小
/// @param colors 颜色组(UIcolor)
/// @param gradientType 渐变方向
+ (nullable UIImage *)bf_imageFromSize:(CGSize)size Colors:(NSArray<UIColor *> *)colors byGradientType:(BFGradientType)gradientType;

//MARK: - 获取图片、区域的主色
/// @param image 图片
/// @param scale 缩放比例
/// @param rect 位置
+ (nullable NSDictionary *)bf_mostColor:(UIImage *)image scale:(CGFloat)scale rect:(CGRect)rect;
//MARK: - 裁剪图片
- (nullable UIImage *)bf_cropSquareImageRect:(CGRect)rect;


/**
 用给定的角大小圆角一个新图像。
 
 @param radius       圆角半径
 */
- (UIImage *)bf_imageByRoundCornerRadius:(CGFloat)radius;

/**
 用给定的角大小圆角一个新图像。
 
 @param radius       圆角半径
 
 @param corners      圆角位置
 */
- (nullable UIImage *)bf_imageByRoundCornerRadius:(CGFloat)radius
                                          corners:(UIRectCorner)corners;

/**
 用给定的角大小圆角一个新图像。
 
 @param radius       圆角半径
 
 @param borderWidth  边框线的宽度
 
 @param borderColor  边框线的颜色
 */
- (UIImage *)bf_imageByRoundCornerRadius:(CGFloat)radius
                             borderWidth:(CGFloat)borderWidth
                             borderColor:(UIColor *)borderColor;
//MARK: - 用给定的角大小圆角一个新图像。
/// @param radius 圆角半径
/// @param corners 圆角位置
/// @param borderWidth 边框线的宽度
/// @param borderColor 边框线的颜色
/// @param borderLineJoin 边界线
- (nullable UIImage *)bf_imageByRoundCornerRadius:(CGFloat)radius
                                       corners:(UIRectCorner)corners
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(nullable UIColor *)borderColor
                                borderLineJoin:(CGLineJoin)borderLineJoin;

/**
 *  得到图片的缩略图(默认不变形)
 *  @param size  想得到的缩略图尺寸
 *
 *  @return 新生成的图片
 */
-(UIImage *)bf_thumbnailImageWithSize:(CGSize)size;

/**
 *  得到图片的缩略图
 *  @param size  想得到的缩略图尺寸
 *  @param scale scale为YES：原图会根据size进行拉伸-会变形，scale为NO：原图会根据size进行填充-不会变形
 *
 *  @return 新生成的图片
 */
-(UIImage *)bf_thumbnailImageWithSize:(CGSize)size scale:(BOOL)scale;


@end


NS_ASSUME_NONNULL_END
