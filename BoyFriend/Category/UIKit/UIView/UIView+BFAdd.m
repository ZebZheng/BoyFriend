/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/


#import "UIView+BFAdd.h"
#import <objc/runtime.h>
#import "NSObject+BFWindow.h"

@implementation UIView (BFAdd)
- (void)bf_roundeWithSize:(CGSize)size conrners:(UIRectCorner)rectCon cornerRadii:(CGFloat)radii {
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners:rectCon cornerRadii:CGSizeMake(radii, radii)];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}
- (void)bf_roundeConrners:(UIRectCorner)rectCon cornerRadii:(CGSize)size {
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCon cornerRadii:size];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

- (void)bf_shadowsColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius opacity:(CGFloat)opacity {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = size;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
}

- (void)bf_imageFromSize:(CGSize)size Colors:(NSArray*)colors byGradientType:(BFGradientType)gradientType {
    
    UIImage * image = [UIImage bf_imageFromSize:size Colors:colors byGradientType:gradientType];
    
    UIColor * color = [UIColor colorWithPatternImage:image];
    self.backgroundColor = color;
}

- (void)bf_removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}
- (nullable UIViewController *)bf_viewController {
    return [self bf_currentViewController];
}
- (void)bf_borderAllWithColor:(UIColor *)color borderWidth:(CGFloat)width {
    [self bf_borderWithTop:YES left:YES bottom:YES right:YES borderColor:color borderWidth:width];
}
- (void)bf_borderTopWithColor:(UIColor *)color borderWidth:(CGFloat)width {
    [self bf_borderWithTop:YES left:NO bottom:NO right:NO borderColor:color borderWidth:width];
}
- (void)bf_borderLeftWithColor:(UIColor *)color borderWidth:(CGFloat)width {
    [self bf_borderWithTop:NO left:YES bottom:NO right:NO borderColor:color borderWidth:width];
}
- (void)bf_borderRightWithColor:(UIColor *)color borderWidth:(CGFloat)width {
    [self bf_borderWithTop:NO left:NO bottom:NO right:YES borderColor:color borderWidth:width];
}
- (void)bf_borderBottomWithColor:(UIColor *)color borderWidth:(CGFloat)width {
    [self bf_borderWithTop:NO left:NO bottom:YES right:NO borderColor:color borderWidth:width];
}
- (void)bf_borderWithTop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width {
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, self.bounds.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, self.bounds.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.bounds.size.height - width, self.bounds.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(self.bounds.size.width - width, 0, width, self.bounds.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
}
///边框渐变
/// @param gradientType 渐变方向
/// @param colors 颜色
/// @param lineWidth 边框线大小
/// @param cornerRadius 圆角
- (void)bf_borderGradientWithType:(BFGradientType)gradientType colors:(NSArray *)colors lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)cornerRadius {
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = colors;
    CGPoint startPoint;
    CGPoint endPoint;
    switch (gradientType) {
        case BFGradientTypeVertical:
            startPoint = CGPointMake(0.0, 0.0);
            endPoint = CGPointMake(0.0, self.frame.size.height);
            break;
        case BFGradientTypeHorizontal:
            startPoint = CGPointMake(0.0, 0.0);
            endPoint = CGPointMake(self.frame.size.width, 0.0);
            break;
        case BFGradientTypeUpLeftToBottomRight:
            startPoint = CGPointMake(0.0, 0.0);
            endPoint = CGPointMake(self.frame.size.width, self.frame.size.height);
            break;
        case BFGradientTypeUpRightToBottomLeft:
            startPoint = CGPointMake(self.frame.size.width, 0.0);
            endPoint = CGPointMake(0.0, self.frame.size.height);
            break;
        default:
            break;
    }
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.lineWidth = lineWidth;
    maskLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    maskLayer.fillColor = UIColor.clearColor.CGColor;
    maskLayer.strokeColor = UIColor.redColor.CGColor;
    gradientLayer.mask = maskLayer;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    maskLayer.path = bezierPath.CGPath;
    [self.layer addSublayer:gradientLayer];
}


@end
