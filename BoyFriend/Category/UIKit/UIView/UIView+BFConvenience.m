/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "UIView+BFConvenience.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (BFConvenience)

- (CGPoint)bf_layoutPoint {
    [self layoutIfNeeded];
    return self.frame.origin;
}

- (CGSize)bf_layoutSize {
    [self layoutIfNeeded];
    return self.frame.size;
}

- (CGPoint)bf_origin {
	return self.frame.origin;
}

- (void)setBf_origin:(CGPoint)newOrigin {
	self.frame = CGRectMake(newOrigin.x, newOrigin.y, self.frame.size.width, self.frame.size.height);
}

- (CGSize)bf_size {
	return self.frame.size;
}

- (void)setBf_size:(CGSize)newSize {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
							newSize.width, newSize.height);
}

- (CGFloat)bf_X {
	return self.frame.origin.x;
}

- (void)setBf_X:(CGFloat)newX {
	self.frame = CGRectMake(newX, self.frame.origin.y,
							self.frame.size.width, self.frame.size.height);
}

- (CGFloat)bf_Y {
	return self.frame.origin.y;
}

- (void)setBf_Y:(CGFloat)newY {
	self.frame = CGRectMake(self.frame.origin.x, newY,
							self.frame.size.width, self.frame.size.height);
}

- (CGFloat)bf_right {
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setBf_right:(CGFloat)newRight {
	self.frame = CGRectMake(newRight - self.frame.size.width, self.frame.origin.y,
							self.frame.size.width, self.frame.size.height);
}

- (CGFloat)bf_bottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setBf_bottom:(CGFloat)newBottom {
	self.frame = CGRectMake(self.frame.origin.x, newBottom - self.frame.size.height,
							self.frame.size.width, self.frame.size.height);
}

- (CGFloat)bf_width {
	return self.frame.size.width;
}

- (void)setBf_width:(CGFloat)newWidth {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
							newWidth, self.frame.size.height);
}

- (CGFloat)bf_height {
	return self.frame.size.height;
}

- (void)setBf_height:(CGFloat)newHeight {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
							self.frame.size.width, newHeight);
}

- (CGFloat)bf_centerX {
    return self.center.x;
}

- (void)setBf_centerX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)bf_centerY {
    return self.center.y;
}

- (void)setBf_centerY:(CGFloat)centerY{
    self.center = CGPointMake(self.center.x, centerY);
}

- (BOOL)bf_containsSubView:(UIView *)subView {
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)bf_containsSubViewOfClassType:(Class)classType {
    for (UIView *view in [self subviews]) {
        if ([view isMemberOfClass:classType]) {
            return YES;
        }
    }
    return NO;
}

- (void)bf_removeAllSubViews {
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
}
- (void)bf_addSubviews:(id)array {
    NSDictionary *dic = array;
    
    for (UIView *tmpView in dic) {
        [self addSubview:tmpView];
    }
}
@end
