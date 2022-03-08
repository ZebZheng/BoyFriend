/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (BFCompress)

//MARK: - 压缩上传图片到指定字节
/// @param image 压缩的图片
/// @param maxLength 压缩后最大字节大小
/// @param maxWidth 压缩后最大宽
+ (NSData *)bf_compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength maxWidth:(NSInteger)maxWidth;

//MARK: - 获得指定size的图片
/// @param image 原始图片
/// @param newSize 指定的size
+ (UIImage *)bf_resizeImage:(UIImage *) image withNewSize:(CGSize) newSize;

//MARK: - 通过指定图片最长边，获得等比例的图片size
/// @param image 原始图片
/// @param imageLength 图片允许的最长宽度（高度）
+ (CGSize)bf_scaleImage:(UIImage *) image withLength:(CGFloat) imageLength;

//MARK: - 对指定图片进行拉伸
+ (UIImage*)bf_resizableImage:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
