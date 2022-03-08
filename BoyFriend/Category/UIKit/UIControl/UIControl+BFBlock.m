/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#import "UIControl+BFBlock.h"
#import <objc/runtime.h>

#ifndef BFUICONTROL_EVENT
#define BFUICONTROL_EVENT(methodName, eventName)                                \
-(void)methodName : (void(^)(void))eventBlock {                              \
    objc_setAssociatedObject(self, @selector(methodName:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);\
    [self addTarget:self                                                        \
    action:@selector(methodName##Action:)                                       \
    forControlEvents:UIControlEvent##eventName];                                \
}                                                                               \
-(void)methodName##Action:(id)sender {                                        \
    void (^block)(void) = objc_getAssociatedObject(self, @selector(methodName:));  \
    if (block) {                                                                \
        block();                                                                \
    }                                                                           \
}
#endif

@interface UIControl ()

@end

@implementation UIControl (BFBlock)

BFUICONTROL_EVENT(touchDown, TouchDown)
BFUICONTROL_EVENT(touchDownRepeat, TouchDownRepeat)
BFUICONTROL_EVENT(touchDragInside, TouchDragInside)
BFUICONTROL_EVENT(touchDragOutside, TouchDragOutside)
BFUICONTROL_EVENT(touchDragEnter, TouchDragEnter)
BFUICONTROL_EVENT(touchDragExit, TouchDragExit)
BFUICONTROL_EVENT(touchUpInside, TouchUpInside)
BFUICONTROL_EVENT(touchUpOutside, TouchUpOutside)
BFUICONTROL_EVENT(touchCancel, TouchCancel)
BFUICONTROL_EVENT(valueChanged, ValueChanged)
BFUICONTROL_EVENT(editingDidBegin, EditingDidBegin)
BFUICONTROL_EVENT(editingChanged, EditingChanged)
BFUICONTROL_EVENT(editingDidEnd, EditingDidEnd)
BFUICONTROL_EVENT(editingDidEndOnExit, EditingDidEndOnExit)

@end
