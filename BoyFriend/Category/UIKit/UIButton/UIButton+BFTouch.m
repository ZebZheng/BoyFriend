/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "UIButton+BFTouch.h"
#import <objc/runtime.h>

@implementation UIButton (BFTouch)

- (UIEdgeInsets)bf_touchAreaInsets {
    return [objc_getAssociatedObject(self, @selector(bf_touchAreaInsets)) UIEdgeInsetsValue];
}
/**
 *  @brief  设置按钮额外热区
 */
- (void)setBf_touchAreaInsets:(UIEdgeInsets)bf_touchAreaInsets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:bf_touchAreaInsets];
    objc_setAssociatedObject(self, @selector(bf_touchAreaInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    UIEdgeInsets touchAreaInsets = self.bf_touchAreaInsets;
    CGRect bounds = self.bounds;
    bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                        bounds.origin.y - touchAreaInsets.top,
                        bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                        bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
    return CGRectContainsPoint(bounds, point);
}

@end
