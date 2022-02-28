//
//  UIControl+BFBlock.m
//  Created by BF on 2021
//

#import "UIControl+BFBlock.h"
#import <objc/runtime.h>

// UIControlEventTouchDown           = 1 <<  0,      // on all touch downs
// UIControlEventTouchDownRepeat     = 1 <<  1,      // on multiple touchdowns
// (tap count > 1)
// UIControlEventTouchDragInside     = 1 <<  2,
// UIControlEventTouchDragOutside    = 1 <<  3,
// UIControlEventTouchDragEnter      = 1 <<  4,
// UIControlEventTouchDragExit       = 1 <<  5,
// UIControlEventTouchUpInside       = 1 <<  6,
// UIControlEventTouchUpOutside      = 1 <<  7,
// UIControlEventTouchCancel         = 1 <<  8,
//
// UIControlEventValueChanged        = 1 << 12,     // sliders, etc.
//
// UIControlEventEditingDiBFegin     = 1 << 16,     // UITextField
// UIControlEventEditingChanged      = 1 << 17,
// UIControlEventEditingDidEnd       = 1 << 18,
// UIControlEventEditingDidEndOnExit = 1 << 19,     // 'return key' ending
// editing
//
// UIControlEventAllTouchEvents      = 0x00000FFF,  // for touch events
// UIControlEventAllEditingEvents    = 0x000F0000,  // for UITextField
// UIControlEventApplicationReserved = 0x0F000000,  // range available for
// application use
// UIControlEventSystemReserved      = 0xF0000000,  // range reserved for
// internal framework use
// UIControlEventAllEvents           = 0xFFFFFFFF

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
