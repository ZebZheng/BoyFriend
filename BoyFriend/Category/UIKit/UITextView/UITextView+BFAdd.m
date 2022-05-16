/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "UITextView+BFAdd.h"
#import "NSString+BFAdd.h"

@interface UITextView ()

@property (nonatomic, assign,readonly) BOOL bf_addNoti;
@property (nonatomic, copy) NSString * bf_lastTextStr;
/// 判断是否使用edge
@property(nonatomic, assign) BOOL isEdge;
@end

@implementation UITextView (BFAdd)

- (UIColor *)bf_promptColor {
    return objc_getAssociatedObject(self, &@selector(bf_promptColor));
}
- (void)setBf_promptColor:(UIColor *)bf_promptColor {
    objc_setAssociatedObject(self, &@selector(bf_promptColor), bf_promptColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setIsEdge:(BOOL)isEdge {
    objc_setAssociatedObject(self, &@selector(isEdge), [NSNumber numberWithBool:isEdge], OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isEdge {
    BOOL obj = [objc_getAssociatedObject(self, &@selector(isEdge)) boolValue];
    return obj;
}

- (void)setBf_placeholderFont:(UIFont *)bf_placeholderFont {
    objc_setAssociatedObject(self, &@selector(bf_placeholderFont), bf_placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIFont *)bf_placeholderFont {
    return objc_getAssociatedObject(self, &@selector(bf_placeholderFont));
}

- (void)setBf_placeholderEdgeInsets:(UIEdgeInsets)bf_placeholderEdgeInsets {
    objc_setAssociatedObject(self, &@selector(bf_placeholderEdgeInsets), NSStringFromUIEdgeInsets(bf_placeholderEdgeInsets), OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.isEdge = YES;
}
- (UIEdgeInsets)bf_placeholderEdgeInsets {
    return UIEdgeInsetsFromString(objc_getAssociatedObject(self, &@selector(bf_placeholderEdgeInsets)));
}

- (void)setBf_promptFont:(UIFont *)promptFont {
    objc_setAssociatedObject(self, &@selector(bf_promptFont), promptFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIFont *)bf_promptFont {
    return objc_getAssociatedObject(self, &@selector(bf_promptFont));
}

- (void)setBf_addNoti:(BOOL)bf_addNoti {
    objc_setAssociatedObject(self, &@selector(bf_addNoti), [NSNumber numberWithBool:bf_addNoti], OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)bf_addNoti {
    
    BOOL obj = [objc_getAssociatedObject(self, &@selector(bf_addNoti)) boolValue];
    return obj;
}

- (void)setBf_placeholder:(NSString *)placeholder {
    
    objc_setAssociatedObject(self, &@selector(bf_placeholder), placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self addTextChangeNoti];
    [self setNeedsDisplay];
}
- (NSString *)bf_placeholder {
    
    NSString *obj = objc_getAssociatedObject(self, &@selector(bf_placeholder));
    return obj;
}

- (void)setBf_placeholderColor:(UIColor *)placeholderColor {
    
    objc_setAssociatedObject(self, &@selector(bf_placeholderColor), placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTextChangeNoti];
}
- (UIColor *)bf_placeholderColor {
    UIColor *obj = objc_getAssociatedObject(self, &@selector(bf_placeholderColor));
    return obj;
}

- (void)setBf_maximumLimit:(NSInteger)maximumLimit{
    
    objc_setAssociatedObject(self, &@selector(bf_maximumLimit), [NSNumber numberWithInteger:maximumLimit], OBJC_ASSOCIATION_ASSIGN);
    //setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self addTextChangeNoti];
    [self setNeedsDisplay];
}
- (NSInteger)bf_maximumLimit {
    id obj = objc_getAssociatedObject(self, &@selector(bf_maximumLimit));
    return [obj integerValue];
}

- (void)setBf_characterLengthPrompt:(BOOL)characterLengthPrompt {
    objc_setAssociatedObject(self, &@selector(bf_characterLengthPrompt), [NSNumber numberWithBool:characterLengthPrompt], OBJC_ASSOCIATION_ASSIGN);
    //setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self addTextChangeNoti];
    [self setNeedsDisplay];
}
- (BOOL)bf_characterLengthPrompt {
    id obj = objc_getAssociatedObject(self, &@selector(bf_characterLengthPrompt));
    return [obj boolValue];
}

- (void)setBf_textHandle:(void (^)(NSString *))textHandle {
    objc_setAssociatedObject(self, &@selector(bf_textHandle), textHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(NSString *))bf_textHandle {
    id handle = objc_getAssociatedObject(self, &@selector(bf_textHandle));
    if (handle) {
        return (void(^)(NSString *textStr))handle;
    }
    return nil;
}

- (void)setBf_lastTextStr:(NSString *)lastTextStr {
    objc_setAssociatedObject(self, @selector(bf_lastTextStr), lastTextStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)bf_lastTextStr {
    return [self emptyStr:objc_getAssociatedObject(self, _cmd)];
}

- (void)textDidChange:(void (^)(NSString *))handle {
    
    self.bf_textHandle = handle;
    [self addTextChangeNoti];
}

- (void)fixMessyDisplay {
    
    if(self.bf_maximumLimit <= 0) {self.bf_maximumLimit = MAXFLOAT;}
    [self addTextChangeNoti];
}

/**
 *  监听文字改变
 */
- (void)textDidChange {
    //重绘
    [self characterTruncation];
    [self setNeedsDisplay];
}

- (void)textDidEnd {
    if (self.text.length == 0 || self.text == nil) {
        [self characterTruncation];
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    CGFloat x = 5;
    CGFloat y = 5;
    CGFloat width = rect.size.width - 2 * x;
    CGFloat height = rect.size.height - 2 * y;
    if (self.isEdge) {
        x = self.bf_placeholderEdgeInsets.left;
        y = self.bf_placeholderEdgeInsets.top;
        width = rect.size.width - x - self.bf_placeholderEdgeInsets.right;
        height = rect.size.height - y - self.bf_placeholderEdgeInsets.bottom;
    }
    
    if (!self.font) {
        self.font = [UIFont systemFontOfSize:16];
    }
    
    //画最大字符文本,添加文本显示边界
    if((self.bf_maximumLimit > 0) && (self.bf_characterLengthPrompt == YES)) {
        //设置文字属性
        attributes[NSFontAttributeName] = self.bf_promptFont ?: self.font;
        attributes[NSForegroundColorAttributeName] = self.bf_promptColor ?: BFHexColor(#F2F2F2);
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.alignment = NSTextAlignmentRight;
        
        NSMutableDictionary *maximumLimitAttributes = [attributes mutableCopy];
        maximumLimitAttributes[NSParagraphStyleAttributeName] = paragraphStyle;
        
        NSString *limitStr = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.text.length > (long)self.bf_maximumLimit ? (long)self.bf_maximumLimit : (unsigned long)self.text.length ,(long)self.bf_maximumLimit];
        
        CGFloat limitHeight = [limitStr bf_heightWithFontConstrainedToWidth:rect.size.width font:self.bf_promptFont?:self.font];
        
        [self setContentInset:UIEdgeInsetsMake(0, 0, limitHeight, 0)];
        
        [limitStr drawInRect:CGRectMake(x, rect.size.height - limitHeight + self.contentOffset.y, width, limitHeight) withAttributes:maximumLimitAttributes];
    }
    //如果不需要显示最大字符限制文本，则把边界置为默认
    else {
        //设置文字属性
        [self setContentInset:UIEdgeInsetsZero];
    }
    
    // 如果有输入文字，就直接返回，不画占位文字
    if (self.hasText) return;
    //画文字
    attributes[NSFontAttributeName] = self.font;
    attributes[NSForegroundColorAttributeName] = self.bf_placeholderColor ?: BFHexColor(#F2F2F2);
    CGRect placeholderRect = CGRectMake(x, y, width, height);
    [self.bf_placeholder drawInRect:placeholderRect withAttributes:attributes];
}

- (void)characterTruncation {
    
    //字符截取
    if(self.bf_maximumLimit > 0) {
        
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
    
    if((self.bf_textHandle) && (![self.text isEqualToString:self.bf_lastTextStr])) {
        
        self.bf_textHandle(self.text);
    }
    self.bf_lastTextStr = self.text;
}

- (void)addTextChangeNoti {
    
    if(self.bf_addNoti == NO) {
        
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEnd) name:UITextViewTextDidEndEditingNotification object:nil];
    }
    self.bf_addNoti = YES;
}

- (void)dealloc {
    
    if(self.bf_addNoti == YES) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    }
}

- (NSString *)emptyStr:(NSString *)str {
    
    if(([str isKindOfClass:[NSNull class]]) || ([str isEqual:[NSNull null]]) || (str == nil) || (!str)) {
        str = @"";
    }
    return str;
}
@end
