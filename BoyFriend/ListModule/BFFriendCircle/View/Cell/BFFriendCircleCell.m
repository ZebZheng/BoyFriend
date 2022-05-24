//
//  BFFriendCircleCell.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/18.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFFriendCircleCell.h"
#import "PhotoContainerView.h"



const CGFloat contentLabelFontSize = 15;
CGFloat maxContentLabelHeight = 0; // 根据具体font而定



@interface BFFriendCircleCell ()

/// 头像
@property(nonatomic, strong) UIImageView *iconImageView;
/// 名称
@property (nonatomic,strong) UILabel *nameLabel;
/// 内容
@property (nonatomic,strong) UILabel *contentLabel;
/// 图片
@property(nonatomic, strong) PhotoContainerView *photoView;
/// 全文
@property (nonatomic,strong) UIButton *moreButton;
/// 时间
@property (nonatomic,strong) UILabel *timeLabel;
/// 线
@property (nonatomic,strong) UIView *lineView;

@end

@implementation BFFriendCircleCell


- (void)bf_initSubviews {
    [self.contentView bf_addSubviews:@[self.iconImageView,self.nameLabel,self.contentLabel,self.photoView,self.moreButton,self.timeLabel,self.lineView]];
}

- (void)bf_makeContraints {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(BFRatio(10));
        make.left.mas_equalTo(BFRatio(10));
        make.size.mas_equalTo(CGSizeMake(BFRatio(40), BFRatio(40)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(BFRatio(10));
        make.top.mas_equalTo(self.iconImageView);
        make.right.mas_equalTo(self.contentView).offset(-BFRatio(10));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(BFRatio(10));
        make.right.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(self.moreButton.mas_top).offset(-BFRatio(10));
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(BFRatio(10));
        make.size.mas_equalTo(CGSizeMake(BFRatio(30), BFRatio(20)));
    }];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.moreButton.mas_bottom).offset(BFRatio(10));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.photoView.mas_bottom).offset(BFRatio(10));
        make.right.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(-BFRatio(10));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BFRatio(10));
        make.right.mas_equalTo(-BFRatio(10));
        make.height.mas_equalTo(BFRatio(0.5));
        make.bottom.mas_equalTo(0);
    }];
    if (maxContentLabelHeight == 0) {
        maxContentLabelHeight = self.contentLabel.font.lineHeight * 3;
    }
    [self.contentView setNeedsLayout];

}

- (void)bf_setupWithData:(id)data {
    BFFriendCircleModel  * model = data;
    [self.iconImageView sd_setImageWithURL:BFURL_With_String(model.iconName)];
    self.nameLabel.text = model.name;
    self.contentLabel.text = model.msgContent;
    self.photoView.resourceArray = model.picNamesArray;
    if (model.shouldShowMoreButton) {
        [self.moreButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(BFRatio(30), BFRatio(20)));
        }];
        _moreButton.hidden = NO;
        if (model.isOpening) { // 如果需要展开
            _contentLabel.numberOfLines = 0;
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            _contentLabel.numberOfLines = 3;
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        [self.moreButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeZero);
        }];
        _moreButton.hidden = YES;
    }
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = BFRatio(10);
    }
    
    [self.photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.moreButton.mas_bottom).offset(picContainerTopMargin);
        make.size.mas_equalTo(self.photoView.size);
    }];

}

///全文
- (void)moreAction {
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock();
    }
}


#pragma 懒加载
-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView=[BFUICreator createImageViewWithName:@""];
    }
    return _iconImageView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[BFUICreator createLabelWithText:@"" color:UIColor.magentaColor font:BFPFRFontWithSizes(15)];
    }
    return _nameLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[BFUICreator createLabelWithText:@"" color:UIColor.blackColor font:BFPFRFontWithSizes(contentLabelFontSize)];
        _contentLabel.numberOfLines = 0 ;
    }
    return _contentLabel;
}
-(PhotoContainerView *)photoView{
    if (!_photoView) {
        _photoView=[[PhotoContainerView alloc]init];
        @weakify(self);
        [_photoView setTapImageViewBlock:^(NSArray * _Nonnull resourceArray, NSInteger tag) {
            @strongify(self);
            if (self.tapImageViewBlock) {
                self.tapImageViewBlock(resourceArray, tag);
            }
        }];
    }
    return _photoView;
}
-(UIButton *)moreButton{
    if (!_moreButton) {
        _moreButton=[BFUICreator createButtonWithTitle:@"全文" titleColor:UIColor.blueColor font:BFPFRFontWithSizes(15) target:self action:@selector(moreAction)];
    }
    return _moreButton;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel=[BFUICreator createLabelWithText:@"10分钟前" color:UIColor.blackColor font:BFPFRFontWithSizes(14)];
    }
    return _timeLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[BFUICreator createViewWithBgColor:BFRGB_Line radius:0];
    }
    return _lineView;
}

@end
