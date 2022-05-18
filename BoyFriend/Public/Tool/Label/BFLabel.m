/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "BFLabel.h"

@interface BFLabel ()
- (void)_initialize;
@end

@implementation BFLabel
@synthesize bf_verticalTextAlignment = _bf_verticalTextAlignment;

- (void)setBf_verticalTextAlignment:(BFLabelVerticalTextAlignment)bf_verticalTextAlignment {
    _bf_verticalTextAlignment = bf_verticalTextAlignment;

    [self setNeedsLayout];
}

@synthesize bf_textEdgeInsets = _bf_textEdgeInsets;

- (void)setBf_textEdgeInsets:(UIEdgeInsets)bf_textEdgeInsets {
    _bf_textEdgeInsets = bf_textEdgeInsets;
    
    [self setNeedsLayout];
}

#pragma mark - UIView
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self _initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)aFrame {
    if ((self = [super initWithFrame:aFrame])) {
        [self _initialize];
    }
    return self;
}


#pragma mark - UILabel

- (void)drawTextInRect:(CGRect)rect {
    rect = UIEdgeInsetsInsetRect(rect, _bf_textEdgeInsets);
    
    if (self.bf_verticalTextAlignment == BFLabelVerticalTextAlignmentTop) {
        CGSize sizeThatFits = [self sizeThatFits:rect.size];
        rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, sizeThatFits.height);
    } else if (self.bf_verticalTextAlignment == BFLabelVerticalTextAlignmentBottom) {
        CGSize sizeThatFits = [self sizeThatFits:rect.size];
        rect = CGRectMake(rect.origin.x, rect.origin.y + (rect.size.height - sizeThatFits.height), rect.size.width, sizeThatFits.height);
    }
        
    [super drawTextInRect:rect];
}


#pragma mark - Private

- (void)_initialize {
    self.bf_verticalTextAlignment = BFLabelVerticalTextAlignmentMiddle;
    self.bf_textEdgeInsets = UIEdgeInsetsZero;
}

@end
