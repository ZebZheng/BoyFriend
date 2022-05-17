//
//  BFLabel.m
//  DriftingBottle
//
//  Created by IMAC-1 on 2022/5/9.
//  Copyright © 2022 Apple. All rights reserved.
//

#import "BFEdgeLabel.h"

@implementation BFEdgeLabel
 
// 修改绘制文字的区域，bf_edgeInsets增加bounds
-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    /*
    调用父类该方法
    注意传入的UIEdgeInsetsInsetRect(bounds, self.bf_edgeInsets),bounds是真正的绘图区域
    */
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds,
     self.bf_edgeInsets) limitedToNumberOfLines:numberOfLines];
    //根据bf_edgeInsets，修改绘制文字的bounds
    rect.origin.x -= self.bf_edgeInsets.left;
    rect.origin.y -= self.bf_edgeInsets.top;
    rect.size.width += self.bf_edgeInsets.left + self.bf_edgeInsets.right;
    rect.size.height += self.bf_edgeInsets.top + self.bf_edgeInsets.bottom;
    return rect;
}
 
//绘制文字
- (void)drawTextInRect:(CGRect)rect {
    //令绘制区域为原始区域，增加的内边距区域不绘制
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.bf_edgeInsets)];
}
@end
