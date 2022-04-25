/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "UIButton+BFImagePosition.h"

@implementation UIImage (MiddleAligning)

- (UIImage *)bf_middleAlignedButtonImageScaleToSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end

@implementation UIButton (BFImagePosition)

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
            break;
            
        case BFImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageHeight + spacing/2), 0, imageHeight + spacing/2);
            break;
            
        case BFImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            break;
            
        case BFImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            break;
        case BFImagePositionMiddleAligning:
            [self bf_middleAlignButtonWithSpacing:spacing];
            break;
        default:
            break;
    }
}

- (void)bf_middleAlignButtonWithSpacing:(CGFloat)spacing {
    NSString *titleString = [self titleForState:UIControlStateNormal]?:@"";
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:titleString attributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGSize titleSize = [attributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    CGFloat maxImageHeight = CGRectGetHeight(self.frame) - titleSize.height - spacing * 2;
    CGFloat maxImageWidth = CGRectGetWidth(self.frame);
    UIImage *newImage = nil;
    if (imageSize.width > ceilf(maxImageWidth)) {
        CGFloat ratio = maxImageWidth / imageSize.width;
        newImage = [self.imageView.image bf_middleAlignedButtonImageScaleToSize:CGSizeMake(maxImageWidth, imageSize.height * ratio)];
        imageSize = newImage.size;
    }
    if (imageSize.height > ceilf(maxImageHeight)) {
        CGFloat ratio = maxImageHeight / imageSize.height;
        newImage = [self.imageView.image bf_middleAlignedButtonImageScaleToSize:CGSizeMake(imageSize.width * ratio, maxImageHeight)];
        imageSize = newImage.size;
    }
    if (newImage) {
        if ([newImage respondsToSelector:@selector(imageWithRenderingMode:)]) {
            newImage = [newImage imageWithRenderingMode:self.imageView.image.renderingMode];
        }
        [self setImage:newImage forState:UIControlStateNormal];
    }
    CGFloat imageVerticalDiff = titleSize.height + spacing;
    CGFloat imageHorizontalDiff = titleSize.width;
    self.imageEdgeInsets = UIEdgeInsetsMake(-imageVerticalDiff, 0, 0, -imageHorizontalDiff);
    CGFloat titleVerticalDiff = imageSize.height + spacing;
    CGFloat titleHorizontalDiff = imageSize.width;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -titleHorizontalDiff, -titleVerticalDiff, 0);
}

@end
