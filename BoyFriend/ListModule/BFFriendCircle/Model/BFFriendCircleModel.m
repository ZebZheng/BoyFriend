//
//  BFFriendCircleModel.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/18.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFFriendCircleModel.h"

extern const CGFloat contentLabelFontSize;
extern CGFloat maxContentLabelHeight;


@implementation BFFriendCircleModel
{
    CGFloat _lastContentWidth;
}
@synthesize msgContent = _msgContent;

- (void)setMsgContent:(NSString *)msgContent{
    _msgContent = msgContent;
}

- (NSString *)msgContent{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_msgContent boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : BFPFRFontWithSizes(contentLabelFontSize)} context:nil];
        if (textRect.size.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    
    return _msgContent;
}

- (void)setIsOpening:(BOOL)isOpening{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}



@end
