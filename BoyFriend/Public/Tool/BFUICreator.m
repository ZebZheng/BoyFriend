//
//  BFUICreator.m
//  FastApp
//
//  Created by tangkunyin on 16/3/7.
//  Copyright © 2016年 www.shuoit.net. All rights reserved.
//

#import "BFUICreator.h"
#import "BFStringTools.h"

@implementation BFUICreator

#pragma mark - UIView

/**
 UIView ( 背景色 圆角)

 @param bgColor 背景色
 @param cornerRadius 圆角
 @return UIView
 */
+ (UIView *)createViewWithBgColor:(UIColor *)bgColor
                           radius:(float)cornerRadius{
    return [self createViewWithSize:CGSizeZero bgColor:bgColor radius:cornerRadius];
}

/**
 UIView ( 背景色)

 @param bgColor 背景色
 @return UIView
 */
+ (UIView *)createViewWithBgColor:(UIColor *)bgColor{
    return [self createViewWithSize:CGSizeZero bgColor:bgColor];
}

/**
 UIView ( 背景色 圆角 手势)

 @param bgColor 背景色
 @param cornerRadius 圆角
 @param gesture 手势
 @return UIView
 */
+ (UIView *)createViewWithBgColor:(UIColor *)bgColor
                           radius:(float)cornerRadius
                          gesture:(UIGestureRecognizer *)gesture{
    return [self createViewWithSize:CGSizeZero bgColor:bgColor radius:cornerRadius gesture:gesture];
}



+ (UIView *)createViewWithSize:(CGSize)size
                       bgColor:(UIColor *)bgColor
                        radius:(float)cornerRadius{
    UIView *view = [[UIView alloc] initWithFrame:BFRectFromSize(size)];
    if (bgColor) {
        view.backgroundColor = bgColor;
    }
    if (cornerRadius) {
        view.layer.cornerRadius = cornerRadius;
        view.layer.masksToBounds = YES;
    }

    return view;
}

+ (UIView *)createViewWithSize:(CGSize)size
                       bgColor:(UIColor *)bgColor{
    UIView *view = [self createViewWithSize:size bgColor:bgColor radius:0];
    return view;
}

+ (UIView *)createViewWithSize:(CGSize)size
                       bgColor:(UIColor *)bgColor
                        radius:(float)cornerRadius
                       gesture:(UIGestureRecognizer *)gesture{
    UIView *view = [self createViewWithSize:size bgColor:bgColor radius:cornerRadius];
    [view addGestureRecognizer:gesture];
    return view;
}

#pragma mark - UILabel
/**
 UILabel ( 文本 系统字体大小号 会根据内容自动缩小字体)

 @param text 文本
 @param fontSize 系统字体大小号
 @return UILabel
 */
+ (UILabel *)createLabelWithText:(NSString *)text
                     sysFontSize:(int)fontSize{
    return [self createLabelWithSize:CGSizeZero text:text sysFontSize:fontSize];
}

/**
 UILabel ( 文本 系统字体大小号 是否根据内容自动缩小字体,不自动缩小是显示多行)

 @param text 文本
 @param fontSize 系统字体大小号
 @param scale  是否根据内容自动缩小字体
 @return UILabel
 */
+ (UILabel *)createLabelWithText:(NSString *)text
                     sysFontSize:(int)fontSize
                      adjustText:(BOOL)scale{
    return [self createLabelWithSize:CGSizeZero text:text sysFontSize:fontSize adjustText:scale];
}

/**
 UILabel (文本 字体颜色 字体(UIFont))

 @param text 文本
 @param color 字体颜色
 @param font 字体(UIFont)
 @return UILabel
 */
+ (UILabel *)createLabelWithText:(NSString *)text
                           color:(UIColor *)color
                            font:(UIFont *)font{
    return [self createLabelWithSize:CGSizeZero text:text color:color font:font];
}

/**
 UILabel (CGSize 富文本 背景颜色)

 @param aText 富文本
 @param bgColor 背景颜色
 @return UILabel
 */
+ (UILabel *)createLabelWithAttributeText:(NSAttributedString *)aText
                                  bgColor:(UIColor *)bgColor{
    return [self createLabelWithSize:[aText size] aText:aText bgColor:bgColor];
}
/**
 UILabel (富文本)
 
 @param aText 富文本
 @return UILabel
 */
+ (UILabel *)createLabelWithAttributedStringText:(NSAttributedString *)aText{
    //此处根据font确定控件大小
    UILabel *label = [self createLabelWithSize:[aText size] aText:aText bgColor:nil];
    return label;
}

+ (UILabel *)createLabelWithSize:(CGSize)size
                            text:(NSString *)text
                     sysFontSize:(int)fontSize{
    UILabel *label = [self createLabelWithSize:size text:text sysFontSize:fontSize adjustText:YES];
    return label;
}

+ (UILabel *)createLabelWithSize:(CGSize)size
                            text:(NSString *)text
                     sysFontSize:(int)fontSize
                      adjustText:(BOOL)scale{
    UILabel *label = [self createLabelWithSize:size text:text color:[UIColor blackColor] font:BFSysFontWithSizes(fontSize)];
    if (scale) {
        //文字自动适应label的宽度
        label.adjustsFontSizeToFitWidth = YES;
    }else{
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return label;
}

+ (UILabel *)createLabelWithSize:(CGSize)size
                            text:(NSString *)text
                           color:(UIColor *)color
                            font:(UIFont *)font{
    UILabel *label = [[UILabel alloc] initWithFrame:BFRectFromSize(size)];
    if (text) {
        label.text = text;
    }
    if (color) {
        label.textColor = color;
    }
    if (font) {
        label.font = font;
    }
    return label;
}

+ (UILabel *)createLabelWithSize:(CGSize)size
                           aText:(NSAttributedString *)aText
                         bgColor:(UIColor *)bgColor{
    UILabel *label = [self createLabelWithSize:size text:nil color:nil font:nil];
    if (aText) {
        label.attributedText = aText;
    }
    if (bgColor) {
        label.backgroundColor = bgColor;
    }
    return label;
}



#pragma mark - UIButton

/**
 UIButton (title titleColor UIFont)

 @param title 标题
 @param titleColor 标题颜色
 @param font 字体
 @param target target
 @param action action
 @return UIButton
 */
+ (UIButton *)createButtonWithTitle:(NSString *)title
                         titleColor:(UIColor *)titleColor
                               font:(UIFont *)font
                             target:(id)target
                             action:(SEL)action{
    return [self createButtonWithTitle:title size:CGSizeZero titleColor:titleColor font:font target:target action:action];
}

/**
 UIButton (title titleColor UIFont UIButtonType bgColor 圆角)

 @param title 标题
 @param titleColor 标题颜色
 @param font 字体
 @param buttonType 按钮类型
 @param bgColor 背景颜色
 @param cornerRadius 圆角大小
 @param target target
 @param action action
 @return UIButton
 */
+ (UIButton *)createButtonWithTitle:(NSString *)title
                         titleColor:(UIColor *)titleColor
                               font:(UIFont *)font
                         buttonType:(UIButtonType)buttonType
                            bgColor:(UIColor *)bgColor
                             corner:(float)cornerRadius
                             target:(id)target
                             action:(SEL)action{
    return [self createButtonWithTitle:title size:CGSizeZero titleColor:titleColor font:font buttonType:buttonType bgColor:bgColor corner:cornerRadius target:target action:action];
}
/**
 UIButton -(image左,title右)-(title imageName)

 @param title 标题
 @param imageName 图片名称
 @param target target
 @param action action
 @return UIButton
 */
+ (UIButton *)createButtonWithTitle:(NSString *)title
                              image:(NSString *)imageName
                             target:(id)target
                             action:(SEL)action{
    return [self createButtonWithTitle:title size:CGSizeZero image:imageName target:target action:action];
}
/**
 UIButton -(image左,title右,设置UIEdgeInsets)-(title imageName titleEdge imageEdge)

 @param title 标题
 @param imageName 图片名称
 @param titleEdge titleEdge
 @param imageEdge imageEdge
 @param target target
 @param action action
 @return UIButton
 */
+ (UIButton *)createButtonWithTitle:(NSString *)title
                              image:(NSString *)imageName
                          titleEdge:(UIEdgeInsets)titleEdge
                          imageEdge:(UIEdgeInsets)imageEdge
                             target:(id)target
                             action:(SEL)action{
    return [self createButtonWithTitle:title size:CGSizeZero image:imageName titleEdge:titleEdge imageEdge:imageEdge target:target action:action];
}

/**
 UIButton -(image,title可设置)-(title,imageName,titleColor,font,按钮类型,水平对齐方式,竖直对齐方式,contentView的偏移量,中间两者的间距)

 @param title 标题
 @param imageName 图片名称
 @param titleColor 标题颜色
 @param font 字体
 @param type 按钮类型(图片文字的四种组合方式)
 @param hAlign 水平对齐方式(默认可写0)
 @param vAlign 竖直对齐方式(默认可写0)
 @param contentEdge contentView的偏移量(默认可写UIEdgeInsetsZero)
 @param span 中间两者的间距
 @param target target
 @param action action
 @return UIButton
 */
+ (UIButton *)createButtonWithTitle:(NSString *)title
                              image:(NSString *)imageName
                         titleColor:(UIColor *)titleColor
                               font:(UIFont *)font
                      directionType:(BtnImgDirectionType)type
         contentHorizontalAlignment:(UIControlContentHorizontalAlignment)hAlign
           contentVerticalAlignment:(UIControlContentVerticalAlignment)vAlign
                  contentEdgeInsets:(UIEdgeInsets)contentEdge
                               span:(CGFloat)span
                             target:(id)target
                             action:(SEL)action{
    return [self createButtonWithTitle:title size:CGSizeZero image:imageName titleColor:titleColor font:font directionType:type contentHorizontalAlignment:hAlign contentVerticalAlignment:vAlign contentEdgeInsets:contentEdge span:span target:target action:action];
}



+ (UIButton *)createButtonWithTitle:(NSString *)title
                               size:(CGSize)size
                         titleColor:(UIColor *)titleColor
                               font:(UIFont *)font
                             target:(id)target
                             action:(SEL)action{
    return [self createButtonWithTitle:title
                                  size:(CGSize)size
                            titleColor:titleColor
                                  font:font
                            buttonType:UIButtonTypeCustom
                               bgColor:nil
                                corner:0
                                target:target
                                action:action];
}

+ (UIButton *)createButtonWithTitle:(NSString *)title
                               size:(CGSize)size
                         titleColor:(UIColor *)titleColor
                               font:(UIFont *)font
                         buttonType:(UIButtonType)buttonType
                            bgColor:(UIColor *)bgColor
                             corner:(float)cornerRadius
                             target:(id)target
                             action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:buttonType];
    button.frame = BFRectFromSize(size);
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (bgColor) {
        button.backgroundColor = bgColor;
    }
    if (cornerRadius > 0) {
        button.layer.cornerRadius = cornerRadius;
        button.layer.masksToBounds = YES;
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)createButtonWithTitle:(NSString *)title
                               size:(CGSize)size
                              image:(NSString *)imageName
                             target:(id)target
                             action:(SEL)action{
    UIButton *button = [self createButtonWithTitle:title size:size titleColor:nil font:nil target:target action:action];
    if ([imageName isNotBlank]) {
        [button setImage:[UIImage bf_imageWithName:imageName] forState:UIControlStateNormal];
    }
    return button;
}

+ (UIButton *)createButtonWithTitle:(NSString *)title
                               size:(CGSize)size
                              image:(NSString *)imageName
                          titleEdge:(UIEdgeInsets)titleEdge
                          imageEdge:(UIEdgeInsets)imageEdge
                             target:(id)target
                             action:(SEL)action{
    UIButton *button = [self createButtonWithTitle:title size:size image:imageName target:target action:action];
    [button setTitleEdgeInsets:titleEdge];
    [button setImageEdgeInsets:imageEdge];
    return button;
}

+ (UIButton *)createButtonWithTitle:(NSString *)title
                               size:(CGSize)size
                              image:(NSString *)imageName
                         titleColor:(UIColor *)titleColor
                               font:(UIFont *)font
                      directionType:(BtnImgDirectionType)type
         contentHorizontalAlignment:(UIControlContentHorizontalAlignment)hAlign
           contentVerticalAlignment:(UIControlContentVerticalAlignment)vAlign
                  contentEdgeInsets:(UIEdgeInsets)contentEdge
                               span:(CGFloat)span
                             target:(id)target
                             action:(SEL)action{
    UIButton *button = [self createButtonWithTitle:title
                                              size:size
                                        titleColor:titleColor
                                              font:font
                                            target:target
                                            action:action];
    
    if ([imageName isNotBlank]) {
        [button setImage:[UIImage bf_imageWithName:imageName] forState:UIControlStateNormal];
    }
    //水平对齐方式
    button.contentHorizontalAlignment = hAlign;
    //竖直对齐方式
    button.contentVerticalAlignment = vAlign;
    //整个contentView的偏移量
    button.contentEdgeInsets = contentEdge;
    
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.frame.size;
    CGFloat totalWidth = (imageSize.width + titleSize.width) + span;
    CGFloat totalHeight = (imageSize.height + titleSize.height) + span;
    
    switch (type) {
        case BtnImgDirectionDefault:
        {
            if (UIControlContentHorizontalAlignmentRight == hAlign) {
                button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, span);
            }else{
                button.titleEdgeInsets = UIEdgeInsetsMake(0, span, 0, 0);
            }
        }
            break;
        case BtnImgDirectionRight:
            button.imageEdgeInsets = UIEdgeInsetsMake(0, (totalWidth - imageSize.width) , 0, -titleSize.width);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width , 0, (totalWidth - titleSize.width));
            break;
        case BtnImgDirectionTop:
            button.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0, 0, - titleSize.width);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height),0);
            break;
        case BtnImgDirectionBottom:
            button.imageEdgeInsets = UIEdgeInsetsMake((totalHeight - imageSize.height), 0, 0, - titleSize.width);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, (totalHeight - titleSize.height),0);
            break;
    }
    return button;
}

+ (UIButton *)createButtonWithNormalImage:(NSString *)normalImageName
                         highlightedImage:(NSString *)highlightedImageName
                                   target:(id)target
                                   action:(SEL)action{
    UIButton *button = [self createButtonWithTitle:nil size:CGSizeZero titleColor:nil font:nil target:target action:action];
    [button setImage:[UIImage bf_imageWithName:normalImageName] forState:UIControlStateNormal];
    [button setImage:[UIImage bf_imageWithName:highlightedImageName] forState:UIControlStateHighlighted];
    CGSize size = [button imageForState:UIControlStateNormal].size;
    button.frame = BFRectFromSize(size);;
    return button;
}

+ (UIButton *)createButtonWithNormalImage:(NSString *)normalImageName
                                   target:(id)target
                                   action:(SEL)action{
    UIButton *button = [self createButtonWithTitle:nil size:CGSizeZero titleColor:nil font:nil target:target action:action];
    [button setImage:[UIImage bf_imageWithName:normalImageName] forState:UIControlStateNormal];
    CGSize size = [button imageForState:UIControlStateNormal].size;
    button.frame = BFRectFromSize(size);;
    return button;
}

+ (UIButton *)createButtonWithNormalImage:(NSString *)normalImageName
                            SelectedImage:(NSString *)SelectedImageName
                                   target:(id)target
                                   action:(SEL)action{
    UIButton *button = [self createButtonWithTitle:nil size:CGSizeZero titleColor:nil font:nil target:target action:action];
    if ([normalImageName isNotBlank]) {
        [button setImage:[UIImage bf_imageWithName:normalImageName] forState:UIControlStateNormal];
    }
    if ([SelectedImageName isNotBlank]) {
        [button setImage:[UIImage bf_imageWithName:SelectedImageName] forState:UIControlStateSelected];
    }
    CGSize size = [button imageForState:UIControlStateNormal].size;
    button.frame = BFRectFromSize(size);;
    return button;
}

#pragma mark - UIImageView

//For UIImageView
+ (UIImageView *)createImageViewWithName:(NSString *)imageName{
    CGSize size = CGSizeZero;
    if ([imageName isNotBlank]) {
        size = [UIImage bf_imageWithName:imageName].size;
    }
    return [self createImageViewWithName:imageName size:size];
}

+ (UIImageView *)createImageViewWithName:(NSString *)imageName size:(CGSize)size{
    return [self createImageViewWithName:imageName size:size radius:0];
}

+ (UIImageView *)createImageViewWithName:(NSString *)imageName radius:(float)cornerRadius{
    return [self createImageViewWithName:imageName size:CGSizeZero radius:cornerRadius];
}

+ (UIImageView *)createImageViewWithName:(NSString *)imageName size:(CGSize)size radius:(float)cornerRadius{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:BFRectFromSize(size)];
    if ([imageName isNotBlank]) {
        imageView.image = [UIImage bf_imageWithName:imageName];
    }
    imageView.userInteractionEnabled = YES;
    if (cornerRadius) {
        imageView.layer.cornerRadius = cornerRadius;
        imageView.layer.masksToBounds = YES;
    }
    return imageView;
}

#pragma mark - UITextField

/**
 UITextField(提示语)

 @param placeholder 提示语
 @param delegate delegate
 @return UITextField
 */
+ (UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder
                                       delegate:(id<UITextFieldDelegate>)delegate{
    return [self createTextFieldWithSize:CGSizeZero placeholder:placeholder delegate:delegate];
}

/**
 UITextField (字体,字颜色,背景颜色,样式,提示语,键盘类型,返回键类型)

 @param font 字体
 @param textColor textColor
 @param backgroundColor backgroundColor
 @param borderStyle UITextBorderStyle
 @param placeholder 提示语
 @param keyboardType 键盘类型
 @param returnKeyType 返回键类型
 @param delegate delegate
 @return UITextField
 */
+ (UITextField *)createTextFieldWithFont:(UIFont *)font
                               textColor:(UIColor *)textColor
                         backgroundColor:(UIColor *)backgroundColor
                             borderStyle:(UITextBorderStyle)borderStyle
                             placeholder:(NSString *)placeholder
                            keyboardType:(UIKeyboardType)keyboardType
                           returnKeyType:(UIReturnKeyType)returnKeyType
                                delegate:(id<UITextFieldDelegate>)delegate{
    return [self createTextFieldWithSize:CGSizeZero Font:font textColor:textColor backgroundColor:backgroundColor borderStyle:borderStyle placeholder:placeholder keyboardType:keyboardType returnKeyType:returnKeyType delegate:delegate];
}


//For UITextFiled
+ (UITextField *)createTextFieldWithSize:(CGSize)size
                             placeholder:(NSString *)placeholder
                                delegate:(id<UITextFieldDelegate>)delegate{
    UITextField *textField = [[UITextField alloc] initWithFrame:BFRectFromSize(size)];
    if ([placeholder isNotBlank]) {
        textField.placeholder = placeholder;
    }
    if (delegate) {
        textField.delegate = delegate;
    }
    return textField;
}

+ (UITextField *)createTextFieldWithSize:(CGSize)size
                                    Font:(UIFont *)font
                               textColor:(UIColor *)textColor
                         backgroundColor:(UIColor *)backgroundColor
                             borderStyle:(UITextBorderStyle)borderStyle
                             placeholder:(NSString *)placeholder
                            keyboardType:(UIKeyboardType)keyboardType
                           returnKeyType:(UIReturnKeyType)returnKeyType
                                delegate:(id<UITextFieldDelegate>)delegate{
    UITextField *textField = [self createTextFieldWithSize:size placeholder:placeholder delegate:delegate];
    if (font) {
        textField.font = font;
    }
    if (textColor) {
        textField.textColor = textColor;
    }
    if (backgroundColor) {
        textField.backgroundColor = backgroundColor;
    }
    if (borderStyle) {
        textField.borderStyle = borderStyle;
    }
    if (keyboardType) {
        textField.keyboardType = keyboardType;
    }
    if (returnKeyType) {
        textField.returnKeyType = returnKeyType;
    }
    return textField;
}

#pragma mark - UITextView
/**
 UITextView(富文本 是否可编辑 是否可滚动)

 @param atrributeString 富文本
 @param eEnable 是否可编辑
 @param sEnable 是否可滚动
 @return UITextView
 */
+ (UITextView *)createTextViewWithAttributedString:(NSAttributedString *)atrributeString
                                        editEnable:(BOOL)eEnable
                                      scroolEnable:(BOOL)sEnable{
    return [self createTextViewWithSize:CGSizeZero aString:atrributeString editEnable:eEnable scroolEnable:sEnable];
}
//For UITextView
+ (UITextView *)createTextViewWithSize:(CGSize)size
                               aString:(NSAttributedString *)atrributeString
                            editEnable:(BOOL)eEnable
                          scroolEnable:(BOOL)sEnable{
    UITextView *textView = [[UITextView alloc] initWithFrame:BFRectFromSize(size)];
    if (atrributeString) {
        textView.attributedText = atrributeString;
    }
    textView.editable = eEnable;
    textView.scrollEnabled = sEnable;
    //不显示左右滚动条
    textView.showsHorizontalScrollIndicator = NO;
    textView.showsVerticalScrollIndicator = NO;
    return textView;
}

#pragma mark - UITableView

/**
 UITableView(表格样式 高度)

 @param height 高度
 @param delegate 代理
 @return UITableView
 */
+ (UITableView *)createTableViewWithStyle:(UITableViewStyle)style
                                rowHeight:(float)height
                                 delegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate{
    return [self createTableViewWithSize:CGSizeZero style:style rowHeight:height delegate:delegate];
}

/**
 UITableView(表格样式,头部视图,尾部视图,是否可滚动,弹簧效果,表格行线的颜色)

 @param style 表格样式
 @param headerView 头部视图
 @param footerView 尾部视图
 @param sEnable 是否可滚动
 @param bEnable 弹框效果是否需要弹簧效果(yes:需要 NO:不需要)
 @param seporatorLineColor 表格行线的颜色
 @param delegate delegate
 @return UITableView
 */
+ (UITableView *)createTableViewWithStyle:(UITableViewStyle)style
                               headerView:(UIView *)headerView
                               footerView:(UIView *)footerView
                             scrollEnable:(BOOL)sEnable
                            bouncesEnable:(BOOL)bEnable
                       seporatorLineColor:(UIColor *)seporatorLineColor
                                 delegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate{
    return [self createTableViewWithSize:CGSizeZero style:style headerView:headerView footerView:footerView scrollEnable:sEnable bouncesEnable:bEnable seporatorLineColor:seporatorLineColor delegate:delegate];
}


//For UITableView
+ (UITableView *)createTableViewWithSize:(CGSize)size
                                   style:(UITableViewStyle)style
                               rowHeight:(float)height
                                delegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate{
    UITableView *tableView = [[UITableView alloc] initWithFrame:BFRectFromSize(size) style:style];
    if (height == 0) {
        height = 44;
    }
    tableView.rowHeight = height;
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    return tableView;
}

+ (UITableView *)createTableViewWithSize:(CGSize)size
                                   style:(UITableViewStyle)style
                              headerView:(UIView *)headerView
                              footerView:(UIView *)footerView
                            scrollEnable:(BOOL)sEnable
                           bouncesEnable:(BOOL)bEnable
                      seporatorLineColor:(UIColor *)seporatorLineColor
                                delegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate{
    UITableView *tableView = [self createTableViewWithSize:size style:style rowHeight:0 delegate:delegate];
    if (headerView) {
        tableView.tableHeaderView = headerView;
    }
    if (footerView) {
        tableView.tableFooterView = footerView;
    }else{
        tableView.tableFooterView = [[UIView alloc] init];
    }

    tableView.scrollEnabled = sEnable;
    tableView.bounces = bEnable;
    if (seporatorLineColor) {
        tableView.separatorColor = seporatorLineColor;
    }
    
    return tableView;
}



@end
