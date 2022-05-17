/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "BFStrokeLabel.h"

@implementation BFStrokeLabel
- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.outLineWidth = BFRatio(2);
        self.outLinetextColor = BFHexColor(#006DA5);
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
     CGSize shadowOffset = self.shadowOffset;
     UIColor *textColor = self.textColor;

     CGContextRef c = UIGraphicsGetCurrentContext();
     CGContextSetLineWidth(c, self.outLineWidth);//字体边缘的宽度
     CGContextSetLineJoin(c, kCGLineJoinRound);

     CGContextSetTextDrawingMode(c, kCGTextStroke);
     self.textColor = self.outLinetextColor;//字体边缘加的颜色
     [super drawTextInRect:rect];

     CGContextSetTextDrawingMode(c, kCGTextFill);
     self.textColor = textColor;
     self.shadowOffset = CGSizeMake(0, 0);
     [super drawTextInRect:rect];
     self.shadowOffset = shadowOffset;
}

@end
