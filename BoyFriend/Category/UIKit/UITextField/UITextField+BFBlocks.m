/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */


#import "UITextField+BFBlocks.h"
#import <objc/runtime.h>
typedef BOOL (^BFUITextFieldReturnBlock) (UITextField *textField);
typedef void (^BFUITextFieldVoiBFlock) (UITextField *textField);
typedef BOOL (^BFUITextFieldCharacterChangeBlock) (UITextField *textField, NSRange range, NSString *replacementString);
@implementation UITextField (BFBlocks)
static const void *BFUITextFieldDelegateKey = &BFUITextFieldDelegateKey;
static const void *BFUITextFieldShoulBFeginEditingKey = &BFUITextFieldShoulBFeginEditingKey;
static const void *BFUITextFieldShouldEndEditingKey = &BFUITextFieldShouldEndEditingKey;
static const void *BFUITextFieldDiBFeginEditingKey = &BFUITextFieldDiBFeginEditingKey;
static const void *BFUITextFieldDidEndEditingKey = &BFUITextFieldDidEndEditingKey;
static const void *BFUITextFieldShouldChangeCharactersInRangeKey = &BFUITextFieldShouldChangeCharactersInRangeKey;
static const void *BFUITextFieldShouldClearKey = &BFUITextFieldShouldClearKey;
static const void *BFUITextFieldShouldReturnKey = &BFUITextFieldShouldReturnKey;
#pragma mark UITextField Delegate methods
+ (BOOL)textFieldShoulBFeginEditing:(UITextField *)textField {
    BFUITextFieldReturnBlock block = textField.bf_shoulBFeginEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, BFUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShoulBFeginEditing:)]) {
        return [delegate textFieldShoulBFeginEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    BFUITextFieldReturnBlock block = textField.bf_shouldEndEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, BFUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [delegate textFieldShouldEndEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (void)textFieldDiBFeginEditing:(UITextField *)textField {
   BFUITextFieldVoiBFlock block = textField.bf_diBFeginEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, BFUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDiBFeginEditing:)]) {
        [delegate textFieldDiBFeginEditing:textField];
    }
}
+ (void)textFieldDidEndEditing:(UITextField *)textField {
    BFUITextFieldVoiBFlock block = textField.bf_didEndEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, BFUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [delegate textFieldDiBFeginEditing:textField];
    }
}
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BFUITextFieldCharacterChangeBlock block = textField.bf_shouldChangeCharactersInRangeBlock;
    if (block) {
        return block(textField,range,string);
    }
    id delegate = objc_getAssociatedObject(self, BFUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}
+ (BOOL)textFieldShouldClear:(UITextField *)textField {
    BFUITextFieldReturnBlock block = textField.bf_shouldClearBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, BFUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [delegate textFieldShouldClear:textField];
    }
    return YES;
}
+ (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BFUITextFieldReturnBlock block = textField.bf_shouldReturnBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, BFUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [delegate textFieldShouldReturn:textField];
    }
    return YES;
}
#pragma mark Block setting/getting methods
- (BOOL (^)(UITextField *))bf_shoulBFeginEditingBlock {
    return objc_getAssociatedObject(self, BFUITextFieldShoulBFeginEditingKey);
}
- (void)setBf_shoulBFeginEditingBlock:(BOOL (^)(UITextField *))shoulBFegindEditingBlock {
    [self bf_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BFUITextFieldShoulBFeginEditingKey, shoulBFegindEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))bf_shouldEndEditingBlock {
    return objc_getAssociatedObject(self, BFUITextFieldShouldEndEditingKey);
}
- (void)setBf_shouldEndEditingBlock:(BOOL (^)(UITextField *))shouldEndEditingBlock {
    [self bf_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BFUITextFieldShouldEndEditingKey, shouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(UITextField *))bf_diBFeginEditingBlock {
    return objc_getAssociatedObject(self, BFUITextFieldDiBFeginEditingKey);
}
- (void)setBf_diBFeginEditingBlock:(void (^)(UITextField *))diBFeginEditingBlock {
    [self bf_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BFUITextFieldDiBFeginEditingKey, diBFeginEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(UITextField *))bf_didEndEditingBlock {
    return objc_getAssociatedObject(self, BFUITextFieldDidEndEditingKey);
}
- (void)setBf_didEndEditingBlock:(void (^)(UITextField *))didEndEditingBlock {
    [self bf_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BFUITextFieldDidEndEditingKey, didEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *, NSRange, NSString *))bf_shouldChangeCharactersInRangeBlock {
    return objc_getAssociatedObject(self, BFUITextFieldShouldChangeCharactersInRangeKey);
}
- (void)setBf_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *, NSRange, NSString *))shouldChangeCharactersInRangeBlock {
    [self bf_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BFUITextFieldShouldChangeCharactersInRangeKey, shouldChangeCharactersInRangeBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))bf_shouldReturnBlock {
    return objc_getAssociatedObject(self, BFUITextFieldShouldReturnKey);
}
- (void)setBf_shouldReturnBlock:(BOOL (^)(UITextField *))shouldReturnBlock {
    [self bf_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BFUITextFieldShouldReturnKey, shouldReturnBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))bf_shouldClearBlock {
    return objc_getAssociatedObject(self, BFUITextFieldShouldClearKey);
}
- (void)setBf_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock {
    [self bf_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BFUITextFieldShouldClearKey, shouldClearBlock, OBJC_ASSOCIATION_COPY);
}
#pragma mark control method
/*
 Setting itself as delegate if no other delegate has been set. This ensures the UITextField will use blocks if no delegate is set.
 */
- (void)bf_setDelegateIfNoDelegateSet {
    if (self.delegate != (id<UITextFieldDelegate>)[self class]) {
        objc_setAssociatedObject(self, BFUITextFieldDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UITextFieldDelegate>)[self class];
    }
}
@end
