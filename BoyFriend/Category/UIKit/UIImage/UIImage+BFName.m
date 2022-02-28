//
//  UIImage+Name.m
//  Demon
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 BoyFriend. All rights reserved.
//

#import "UIImage+BFName.h"

@implementation UIImage (BFName)

//图片是怎样就怎样 不会自动渲染
+ (UIImage *)bf_imageWithName:(NSString *)name{
    UIImage *image = [[self imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

+ (UIImage*)bf_convertViewToImage:(UIView*)v withSize:(CGSize)imageSize{
    
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
