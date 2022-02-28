/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (BFInit)

#pragma make ------ 颜色生成图片 ------
//MARK: - 颜色生成图片
+ (nullable UIImage *)bf_imageWithColor:(UIColor *)color;
//MARK: - 颜色生成图片
+ (nullable UIImage *)bf_imageWithColor:(UIColor *)color size:(CGSize)size;
@end
NS_ASSUME_NONNULL_END

