/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#import "UIControl+BFEventInterval.h"
#import <objc/runtime.h>

static char * const bf_eventIntervalKey = "bf_eventIntervalKey";
static char * const eventUnavailableKey = "eventUnavailableKey";

@interface UIControl ()

@property (nonatomic, assign) BOOL eventUnavailable;

@end

@implementation UIControl (BFEventInterval)

+ (void)load {
    
    Method method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method bf_method = class_getInstanceMethod(self, @selector(bf_sendAction:to:forEvent:));
    method_exchangeImplementations(method, bf_method);
}


#pragma mark - Action functions

- (void)bf_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([self isKindOfClass:UIButton.class] && self.bf_eventInterval > 0) {
        if (self.userInteractionEnabled == YES) {
            self.userInteractionEnabled = NO;
            [self bf_sendAction:action to:target forEvent:event];
            [self performSelector:@selector(setUserInteractionEnabled:) withObject:@(YES) afterDelay:self.bf_eventInterval];
        }
    } else {
        [self bf_sendAction:action to:target forEvent:event];
    }
}


#pragma mark - Setter & Getter functions

- (NSTimeInterval)bf_eventInterval {
    
    return [objc_getAssociatedObject(self, bf_eventIntervalKey) doubleValue];
}

- (void)setBf_eventInterval:(NSTimeInterval)bf_eventInterval {
    
    objc_setAssociatedObject(self, bf_eventIntervalKey, @(bf_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)eventUnavailable {
    
    return [objc_getAssociatedObject(self, eventUnavailableKey) boolValue];
}

- (void)setEventUnavailable:(BOOL)eventUnavailable {
    
    objc_setAssociatedObject(self, eventUnavailableKey, @(eventUnavailable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
