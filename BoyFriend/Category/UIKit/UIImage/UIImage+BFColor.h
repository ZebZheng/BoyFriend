/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

#define stretchImgFromMiddle(img)    [(img) stretchableImageWithLeftCapWidth:(img).size.width / 2 topCapHeight:(img).size.height / 2]

@interface UIImage (BFColor)

/**
 *  重新绘制图片
 *
 *  @param color 填充色
 *
 *  @return UIImage
 */
- (UIImage *)bf_imageWithColor:(UIColor *)color;

/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)bf_imageWithColor:(UIColor *)color;
/**
 *  @brief  取图片某一点的颜色
 *
 *  @param point 某一点
 *
 *  @return 颜色
 */
- (UIColor *)bf_colorAtPoint:(CGPoint )point;
//more accurate method ,bf_colorAtPixel 1x1 pixel
/**
 *  @brief  取某一像素的颜色(较比上面更准确)
 *
 *  @param point 一像素
 *
 *  @return 颜色
 */
- (UIColor *)bf_colorAtPixel:(CGPoint)point;
/**
 *  @brief  返回该图片是否有透明度通道
 *
 *  @return 是否有透明度通道
 */
- (BOOL)bf_hasAlphaChannel;

/**
 *  @brief  获得灰度图
 *
 *  @param sourceImage 图片
 *
 *  @return 获得灰度图片
 */
+ (UIImage*)bf_covertToGrayImageFromImage:(UIImage*)sourceImage;

@end
