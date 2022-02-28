//
//  UIImage+Name.h
//  Demon
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 BoyFriend. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BFName)

//取到的图片不会自动渲染 会保持原样
+ (UIImage *)bf_imageWithName:(NSString *)name;

/**
 *  UIView 内容生成image , 设置生成image的尺寸
 */
+ (UIImage*)bf_convertViewToImage:(UIView*)v withSize:(CGSize)imageSize;

@end
