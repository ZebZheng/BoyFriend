//
//  BFUICreator.h
//  FastApp
//
//  Created by tangkunyin on 16/3/7.
//  Copyright © 2016年 www.shuoit.net. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BFRectFromSize(size) CGRectMake(0,0,size.width,size.height)

//用于按钮中，文字和图片相对方向
typedef NS_ENUM(NSInteger,BtnImgDirectionType)
{
    BtnImgDirectionDefault, //默认：图片居左，文字居右。整体左右结构
    BtnImgDirectionRight,   //图片居右，文字居左。整体左右机构
    BtnImgDirectionTop,     //图片居上，文字居下。整体上下机构
    BtnImgDirectionBottom,  //图片居下，文字居上。整体上下机构
};

@interface BFUICreator : NSObject

#pragma mark - UIView

/**
 UIView ( 背景色 圆角)

 @param bgColor 背景色
 @param cornerRadius 圆角
 @return UIView
 */
+ (UIView *)createViewWithBgColor:(UIColor *)bgColor
                           radius:(float)cornerRadius;

/**
 UIView ( 背景色)

 @param bgColor 背景色
 @return UIView
 */
+ (UIView *)createViewWithBgColor:(UIColor *)bgColor;

/**
 UIView ( 背景色 圆角 手势)

 @param bgColor 背景色
 @param cornerRadius 圆角
 @param gesture 手势
 @return UIView
 */
+ (UIView *)createViewWithBgColor:(UIColor *)bgColor
                           radius:(float)cornerRadius
                          gesture:(UIGestureRecognizer *)gesture;


#pragma mark - UILabel

/**
 UILabel ( 文本 系统字体大小号 会根据内容自动缩小字体)

 @param text 文本
 @param fontSize 系统字体大小号
 @return UILabel
 */
+ (UILabel *)createLabelWithText:(NSString *)text
                     sysFontSize:(int)fontSize;

/**
 UILabel ( 文本 系统字体大小号 是否根据内容自动缩小字体,不自动缩小是显示多行)

 @param text 文本
 @param fontSize 系统字体大小号
 @param scale  是否根据内容自动缩小字体
 @return UILabel
 */
+ (UILabel *)createLabelWithText:(NSString *)text
                     sysFontSize:(int)fontSize
                      adjustText:(BOOL)scale;

/**
 UILabel (文本 字体颜色 字体(UIFont))

 @param text 文本
 @param color 字体颜色
 @param font 字体(UIFont)
 @return UILabel
 */
+ (UILabel *)createLabelWithText:(NSString *)text
                           color:(UIColor *)color
                            font:(UIFont *)font;

/**
 UILabel (CGSize 富文本 背景颜色)

 @param aText 富文本
 @param bgColor 背景颜色
 @return UILabel
 */
+ (UILabel *)createLabelWithAttributeText:(NSAttributedString *)aText
                                  bgColor:(UIColor *)bgColor;
/**
 UILabel (富文本)
 
 @param aText 富文本
 @return UILabel
 */
+ (UILabel *)createLabelWithAttributedStringText:(NSAttributedString *)aText;


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
                             action:(SEL)action;

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
                             action:(SEL)action;
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
                             action:(SEL)action;
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
                             action:(SEL)action;

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
                             action:(SEL)action;

/**
 UIButton (正常图片名字 高亮图片名字)

 @param normalImageName 正常图片名
 @param highlightedImageName 高亮图片名
 @param target target
 @param action action
 @return UIButton
 */
+ (UIButton *)createButtonWithNormalImage:(NSString *)normalImageName
                         highlightedImage:(NSString *)highlightedImageName
                                   target:(id)target
                                   action:(SEL)action;

/**
 UIButton (图片名)

 @param normalImageName normalImageName
 @param target target
 @param action action
 @return UIButton
 */
+ (UIButton *)createButtonWithNormalImage:(NSString *)normalImageName
                                   target:(id)target
                                   action:(SEL)action;

/**
 UIButton (正常图片名字 高亮图片名字)
 
 @param normalImageName 正常图片名
 @param SelectedImageName 选中图片名
 @param target target
 @param action action
 @return UIButton
 */
+ (UIButton *)createButtonWithNormalImage:(NSString *)normalImageName
                            SelectedImage:(NSString *)SelectedImageName
                                   target:(id)target
                                   action:(SEL)action;
#pragma mark - UIImageView
/**
 UIImageView(图片名)

 @param imageName 图片名
 @return UIImageView
 */
+ (UIImageView *)createImageViewWithName:(NSString *)imageName;

/**
 UIImageView(图片名)

 @param imageName 图片名
 @param size CGSize
 @return UIImageView
 */
+ (UIImageView *)createImageViewWithName:(NSString *)imageName size:(CGSize)size;

/**
 UIImageView(图片名 圆角大小)

 @param imageName 图片名
 @param cornerRadius 圆角大小
 @return UIImageView
 */
+ (UIImageView *)createImageViewWithName:(NSString *)imageName radius:(float)cornerRadius;

/**
 UIImageView(图片名 圆角大小)

 @param imageName 图片名
 @param size CGSize
 @param cornerRadius 圆角大小
 @return UIImageView
 */
+ (UIImageView *)createImageViewWithName:(NSString *)imageName size:(CGSize)size radius:(float)cornerRadius;


#pragma mark - UITextFiled
/**
 UITextField(提示语)

 @param placeholder 提示语
 @param delegate delegate
 @return UITextField
 */
+ (UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder
                                       delegate:(id<UITextFieldDelegate>)delegate;

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
                                delegate:(id<UITextFieldDelegate>)delegate;


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
                                      scroolEnable:(BOOL)sEnable;


#pragma mark - UITableView

/**
 UITableView(表格样式 高度)

 @param height 高度
 @param delegate 代理
 @return UITableView
 */
+ (UITableView *)createTableViewWithStyle:(UITableViewStyle)style
                                rowHeight:(float)height
                                 delegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate;

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
                                 delegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate;




@end
