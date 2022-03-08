/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

@interface UIImage (BFName)

//取到的图片不会自动渲染 会保持原样
+ (UIImage *)bf_imageWithName:(NSString *)name;

/**
 *  UIView 内容生成image , 设置生成image的尺寸
 */
+ (UIImage*)bf_convertViewToImage:(UIView*)v withSize:(CGSize)imageSize;

@end
