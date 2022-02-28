//
//  CommonsView.m
//  Demon
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 BoyFriend. All rights reserved.
//

#import "CommonsView.h"

@interface CommonsView()


@end


@implementation CommonsView

/**
 * 一个label的view
 */
- (instancetype)initTitleViewWithFrame:(CGRect)frame Title:(NSString *)title BackgroundColor:(UIColor*)bgColor{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *bgView=[BFUICreator createViewWithBgColor:bgColor];
        [self bf_addSubviews:@[bgView]];
        
        UILabel *label=[BFUICreator createLabelWithText:title color:BFRGB_FontColor font:BFPFRFontWithSizes(12)];
        [bgView bf_addSubviews:@[label]];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.top.equalTo(@0);
        }];

        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgView);
            make.centerY.mas_equalTo(bgView);
        }];
    }
    return self;
}


/**
 * 导航栏标题的view
 */
- (instancetype)initNavViewWithTitle:(NSString *)title BackgroundColor:(UIColor*)bgColor isWhite:(BOOL)isWhite{
    self = [super init];
    if (self) {
        self.backgroundColor=bgColor;
        self.frame=CGRectMake(0, 0, BFScreen_Width, BFStatusHeight+BFNavBarHeight);

        self.navTitleLabel=[BFUICreator createLabelWithText:title color:[UIColor whiteColor] font:BFPFRFontWithSizes(18)];
        self.navBackButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.navBackButton.adjustsImageWhenHighlighted=NO;
        [self bf_addSubviews:@[self.navTitleLabel,self.navBackButton]];
        [self.navBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(BFRatio(10));
            make.top.mas_equalTo(BFStatusHeight);
            make.size.mas_equalTo(CGSizeMake(BFNavBarHeight, BFNavBarHeight));
        }];
        [self.navTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self.navBackButton);
        }];
        if (isWhite) {
            [self.navBackButton setImage:[UIImage imageNamed:@"nav_back_white"] forState:UIControlStateNormal];
            self.navTitleLabel.tintColor=[UIColor whiteColor];
        } else {
            //dark_back
            [self.navBackButton setImage:[UIImage imageNamed:@"nav_back_black"] forState:UIControlStateNormal];
            self.navTitleLabel.tintColor=BFRGB_FontColor;
        }
    }
    return self;
}







#pragma mark 懒加载

/**
 * 导航栏上通用按钮
 */
-(UIButton *)button{
    if (_button==nil) {
        _button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,BFNavBarHeight,BFNavBarHeight)];
        [_button setTitleColor:BFRGB_FontColor forState:UIControlStateNormal];
        [_button setTitle:@"保存" forState:UIControlStateNormal];
        _button.titleLabel.textAlignment=NSTextAlignmentRight;
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_button.titleLabel setFont:BFPFRFontWithSizes(15)];
    }
    return _button;
}

/*
 *  Base基类导航栏返回统一按钮 '<'
 */
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,BFNavBarHeight,BFNavBarHeight)];
        [_backButton setTitleColor:BFRGB_FontColor forState:UIControlStateNormal];
        [_backButton setTitle:@"" forState:UIControlStateNormal];
        [_backButton setImage:BFImageName(@"nav_back_black") forState:UIControlStateNormal];
        _backButton.adjustsImageWhenHighlighted=NO;
        _backButton.titleLabel.textAlignment=NSTextAlignmentRight;
        [_backButton.titleLabel setFont:BFPFRFontWithSizes(15)];
    }
    return _backButton;
}

/**
 * 统一 导航栏左上关闭按钮
 */
-(UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton=[BFUICreator createButtonWithNormalImage:@"close_back" target:nil action:nil];
        _closeButton.frame = CGRectMake(0,0,BFNavBarHeight,BFNavBarHeight);
//        _closeButton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
    }
    return _closeButton;
}
/**
 * 导航栏上更多按钮
 */
- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.frame = CGRectMake(0,0,BFNavBarHeight,BFNavBarHeight);
        [_moreButton setImage:[UIImage imageNamed:@"more_icon"] forState:UIControlStateNormal];
        _moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _moreButton;
}

@end
