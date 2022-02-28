//
//  CommonsView.h
//  Demon
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 BoyFriend. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CommonsView : UIView
/**
 * 导航栏上通用按钮
 */
@property (nonatomic,strong) UIButton *button;
/*
 *  Base基类导航栏返回统一按钮 '<'
 */
@property (nonatomic,strong) UIButton *backButton;

/**
 * 统一 导航栏左上关闭按钮 'X'
 */
@property (nonatomic,strong) UIButton *closeButton;
/**
 * 导航栏上 更多按钮
 */
@property (nonatomic,strong) UIButton *moreButton;


/************** 导航栏标题的view *********************/
/**** 导航栏返回按钮 ****/
@property (nonatomic,strong) UIButton *navBackButton;
/**** 导航栏标题 ****/
@property (nonatomic,strong) UILabel *navTitleLabel;


/**
 * 一个label的view
 */
- (instancetype)initTitleViewWithFrame:(CGRect)frame Title:(NSString *)title BackgroundColor:(UIColor*)bgColor;


/**
 * 导航栏标题的view
 */
- (instancetype)initNavViewWithTitle:(NSString *)title BackgroundColor:(UIColor*)bgColor isWhite:(BOOL)isWhite;


@end
