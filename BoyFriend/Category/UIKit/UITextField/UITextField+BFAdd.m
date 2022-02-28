/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "UITextField+BFAdd.h"
#import <objc/runtime.h>

@implementation UITextField (BFAdd)

- (void)setBf_placeholderColor:(UIColor *)placeholderColor {
    objc_setAssociatedObject(self, &@selector(placeholderColor), placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (@available(iOS 13.0, *)) {
        NSMutableAttributedString * att = [NSMutableAttributedString.alloc initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:placeholderColor}];
        self.attributedPlaceholder = att;
    } else {
        [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
}

- (UIColor *)bf_placeholderColor {
    return objc_getAssociatedObject(self, &@selector(placeholderColor));
}

- (void)setAddNoti:(BOOL)addNoti {
    
    objc_setAssociatedObject(self, @selector(addNoti), [NSNumber numberWithBool:addNoti], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)addNoti {
    
    BOOL obj = [objc_getAssociatedObject(self, _cmd) boolValue];
    return obj;
}

- (void)setBf_maximumLimit:(NSInteger)bf_maximumLimit {
    objc_setAssociatedObject(self, @selector(bf_maximumLimit), @(bf_maximumLimit), OBJC_ASSOCIATION_ASSIGN);
    [self addTextChangeNoti];
}

- (NSInteger)bf_maximumLimit {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setBf_textHandle:(void (^)(NSString *))textHandle {
    objc_setAssociatedObject(self, @selector(bf_textHandle), textHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString *))bf_textHandle {
    return objc_getAssociatedObject(self, @selector(bf_textHandle));
}

- (void)setLastTextStr:(NSString *)lastTextStr {
    objc_setAssociatedObject(self, @selector(lastTextStr), lastTextStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastTextStr {
    return objc_getAssociatedObject(self, _cmd);
}

/**
 *  监听文字改变
 */
- (void)textDidChange {
    [self characterTruncation];
}

- (void)bf_textDidChange:(void (^)(NSString *))handle {
    self.bf_textHandle = handle;
    [self addTextChangeNoti];
}

/**
*  处理系统输入法导致的乱码,如果调用了maximumLimit属性，内部会默认处理乱码
*/
- (void)bf_fixMessyDisplay {
    if(self.bf_maximumLimit <= 0) {self.bf_maximumLimit = MAXFLOAT;}
    [self addTextChangeNoti];
}

- (void)addTextChangeNoti {
    if(self.addNoti == NO) {
        // 当UITextField的文字发生改变时，UITextField自己会发出一个UITextFieldTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    }
    self.addNoti = YES;
}

- (NSString *)characterTruncation {
    //字符截取
    if(self.bf_maximumLimit) {
        
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制,如果有高亮待选择的字，则暂不对文字进行统计和限制
        if ((position == nil) && (self.text.length > self.bf_maximumLimit)) {
            const char *res = [self.text substringToIndex:self.bf_maximumLimit].UTF8String;
            if (res == NULL) {
                self.text = [self.text substringToIndex:self.bf_maximumLimit - 1];
            }else{
                self.text = [self.text substringToIndex:self.bf_maximumLimit];
            }
        }
    }
    if((self.bf_textHandle) && (![self.text isEqualToString:self.lastTextStr])) {
        
        self.bf_textHandle(self.text);
    }
    self.lastTextStr = self.text;
    
    return self.text;
}

- (void)dealloc {
    if(self.addNoti == YES) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    }
}

@end
