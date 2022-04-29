/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/


#import "UIImage+BFAdd.h"

@implementation UIImage (BFAdd)

- (nullable NSString *)bf_base64String {
    NSData * imagedata = UIImagePNGRepresentation(self);
    NSString * image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return image64;
}
///渐变
+ (nullable UIImage *)bf_imageFromSize:(CGSize)size Colors:(NSArray<UIColor *> *)colors byGradientType:(BFGradientType)gradientType {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case BFGradientTypeVertical:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        case BFGradientTypeHorizontal:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, 0.0);
            break;
        case BFGradientTypeUpLeftToBottomRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, size.height);
            break;
        case BFGradientTypeUpRightToBottomLeft:
            start = CGPointMake(size.width, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}


- (UIImage *)bf_imageByRoundCornerRadius:(CGFloat)radius {
    return [self bf_imageByRoundCornerRadius:radius corners:UIRectCornerAllCorners borderWidth:0 borderColor:nil borderLineJoin:(kCGLineJoinRound)];
}
- (nullable UIImage *)bf_imageByRoundCornerRadius:(CGFloat)radius
                                          corners:(UIRectCorner)corners {
    return [self bf_imageByRoundCornerRadius:radius corners:corners borderWidth:0 borderColor:nil borderLineJoin:(kCGLineJoinRound)];
}
- (UIImage *)bf_imageByRoundCornerRadius:(CGFloat)radius
                             borderWidth:(CGFloat)borderWidth
                             borderColor:(UIColor *)borderColor {
    return [self bf_imageByRoundCornerRadius:radius corners:UIRectCornerAllCorners borderWidth:borderWidth borderColor:borderColor borderLineJoin:(kCGLineJoinRound)];
}
- (nullable UIImage *)bf_imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin {
    
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
        corners = tmp;
    }
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
        [path closePath];
        
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
        [path closePath];
        
        path.lineWidth = borderWidth;
        path.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/// 获取图片、区域的主色
+ (nullable NSDictionary *)bf_mostColor:(UIImage *)image scale:(CGFloat)scale rect:(CGRect)rect {
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    if (scale <= 0.1) {
        scale = 0.1;
    }else if(scale >= 1){
        scale = 1;
    }
    
    if (rect.size.width > 0 && rect.size.height > 0) {
        image = [image bf_cropSquareImageRect:rect];
    }
    
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize = CGSizeMake([image size].width * scale, [image size].height * scale);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    
    if (data == NULL){
        CGContextRelease(context);
        return nil;
    }
    
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.height; x++) {
        for (int y=0; y<thumbSize.width; y++) {
            int offset = 4*(x*thumbSize.width + y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            
            NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
            [cls addObject:clr];
        }
    }
    CGContextRelease(context);

    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    
    while ( (curColor = [enumerator nextObject]) != nil ){
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
    }
    //返回三色值+透明度
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setValue:@([MaxColor[0] intValue]/255.0f) forKey:@"red"];
    [dic setValue:@([MaxColor[1] intValue]/255.0f) forKey:@"green"];
    [dic setValue:@([MaxColor[2] intValue]/255.0f) forKey:@"blue"];
    [dic setValue:@([MaxColor[3] intValue]/255.0f) forKey:@"alpha"];
    return dic;
}
///裁剪图片
- (nullable UIImage *)bf_cropSquareImageRect:(CGRect)rect {
    CGImageRef sourceImageRef = [self CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}



/**
 *  得到图片的缩略图(默认不变形)
 *  @param size  想得到的缩略图尺寸
 *
 *  @return 新生成的图片
 */
-(UIImage *)bf_thumbnailImageWithSize:(CGSize)size {
    return [self bf_thumbnailImageWithSize:size scale:NO];
}

/**
 *  得到图片的缩略图
 *  @param size  想得到的缩略图尺寸
 *  @param scale scale为YES：原图会根据size进行拉伸-会变形，scale为NO：原图会根据size进行填充-不会变形
 *
 *  @return 新生成的图片
 */
-(UIImage *)bf_thumbnailImageWithSize:(CGSize)size scale:(BOOL)scale {
    UIImage * image = self;
    UIGraphicsBeginImageContextWithOptions(size, NO, image.scale);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    if (!scale) {
        CGFloat bili_imageWH = image.size.width/image.size.height;
        CGFloat bili_SizeWH  = size.width/size.height;
        
        if (bili_imageWH > bili_SizeWH) {
            CGFloat bili_SizeH_imageH = size.height/image.size.height;
            CGFloat height = image.size.height*bili_SizeH_imageH;
            CGFloat width = height * bili_imageWH;
            CGFloat x = -(width - size.width)/2;
            CGFloat y = 0;
            rect = CGRectMake(x, y, width, height);
        }else{
            CGFloat bili_SizeW_imageW = size.width/image.size.width;
            CGFloat width = image.size.width * bili_SizeW_imageW;
            CGFloat height = width / bili_imageWH;
            CGFloat x = 0;
            CGFloat y = -(height - size.height)/2;
            rect = CGRectMake(x, y, width, height);
        }
    }
    [[UIColor clearColor] set];
    UIRectFill(rect);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
