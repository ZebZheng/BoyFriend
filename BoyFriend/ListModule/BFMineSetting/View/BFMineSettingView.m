//
//  BFMineView.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/24.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFMineSettingView.h"

@interface BFMineSettingView ()

/// 背景
@property (nonatomic,strong) UIImageView *bgImageView;
/// 头像背景
@property (nonatomic,strong) UIView *headBgView;
/// 头像
@property (nonatomic,strong) UIImageView *headImageView;
/// 昵称
@property (nonatomic,strong) UILabel *nickNameLabel;

@end

@implementation BFMineSettingView


#pragma mark - init
//MARK: - 视图初始化
- (void)bf_initSubviews {
    [self bf_addSubviews:@[self.bgImageView]];
    [self.bgImageView bf_addSubviews:@[self.headBgView,self.nickNameLabel]];
    [self.headBgView addSubview:self.headImageView];
}

//MARK: - 约束
- (void)bf_makeContraints {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.headBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BFRatio(68), BFRatio(68)));
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(BFRatio(100));
    }];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BFRatio(64), BFRatio(64)));
        make.center.mas_equalTo(self.headBgView);
    }];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headBgView);
        make.top.mas_equalTo(self.headBgView.mas_bottom).offset(BFRatio(10));
        make.width.mas_lessThanOrEqualTo(BFScreen_Width-100);
    }];
}

//MARK: - 数据初始化
- (void)bf_setupWithData:(id)data {
    self.headImageView.image = BFImageName(@"landscape");
    self.nickNameLabel.text = @"昵称";
}

#pragma mark - function


#pragma mark - Data


#pragma mark - Event Response / IBActions


#pragma mark - Setter


#pragma mark - Getter
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView=[BFUICreator createImageViewWithName:@"me_headbg"];
    }
    return _bgImageView;
}

-(UIView *)headBgView{
    if (!_headBgView) {
        _headBgView=[BFUICreator createViewWithBgColor:UIColor.whiteColor radius:BFRatio(34)];
    }
    return _headBgView;
}
-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView=[[UIImageView alloc]init];
        _headImageView.layer.cornerRadius = BFRatio(32);
        _headImageView.layer.masksToBounds = YES;
        ///添加单击手势监听
        _headImageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(usertapGesture:)];
//        singleTap.numberOfTouchesRequired = 1; //手指数
//        singleTap.numberOfTapsRequired = 1; //tap次数
//        [_headImageView addGestureRecognizer:singleTap];
    }
    return _headImageView;
}
-(UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel=[BFUICreator createLabelWithText:@"" color:UIColor.whiteColor font:BFPFRFontWithSizes(17)];
        _nickNameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        ///添加单击手势监听
        _nickNameLabel.userInteractionEnabled = YES;
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(usertapGesture:)];
//        singleTap.numberOfTouchesRequired = 1; //手指数
//        singleTap.numberOfTapsRequired = 1; //tap次数
//        [_nickNameLabel addGestureRecognizer:singleTap];
    }
    return _nickNameLabel;
}

@end
