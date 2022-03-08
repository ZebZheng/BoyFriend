/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "UIView+BFBlock.h"
#import <objc/runtime.h>

static char BFActionHandlerTapBlockKey;
static char BFActionHandlerTapGestureKey;
static char BFActionHandlerLongPressBlockKey;
static char BFActionHandlerLongPressGestureKey;
@implementation UIView (BFBlock)

- (void)bf_addTapActionWithBlock:(BFGestureActionBlock)block {
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &BFActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bf_handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &BFActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &BFActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)bf_handleActionForTapGesture:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        BFGestureActionBlock block = objc_getAssociatedObject(self, &BFActionHandlerTapBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

- (void)bf_addLongPressActionWithBlock:(BFGestureActionBlock)block {
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &BFActionHandlerLongPressGestureKey);
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(bf_handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &BFActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &BFActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)bf_handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        BFGestureActionBlock block = objc_getAssociatedObject(self, &BFActionHandlerLongPressBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

@end
