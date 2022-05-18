//
//  BFLinkageTCLeftTableViewCell.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/17.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFLinkageTCLeftTableViewCell.h"

@interface BFLinkageTCLeftTableViewCell ()

/// 名称
@property (nonatomic,strong) UILabel *nameLabel;
/// 线
@property (nonatomic,strong) UIView *yellowView;

@end


@implementation BFLinkageTCLeftTableViewCell


- (void)bf_initSubviews {
    [self.contentView bf_addSubviews:@[self.nameLabel,self.yellowView]];

}

- (void)bf_makeContraints {
    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(BFRatio(5));
        make.left.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(-BFRatio(5));
        make.width.mas_equalTo(BFRatio(5));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(BFRatio(5), BFRatio(10), BFRatio(5), BFRatio(5)));
    }];
}

- (void)bf_setupWithData:(id)data {
    self.nameLabel.text = data;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1];
    self.highlighted = selected;
    self.nameLabel.highlighted = selected;
    self.yellowView.hidden = !selected;
}

#pragma 懒加载
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[BFUICreator createLabelWithText:@"" color:UIColor.blackColor font:BFSysFontWithSizes(15)];
        _nameLabel.numberOfLines = 0;
        _nameLabel.highlightedTextColor = BFRGB(253, 212, 49);
    }
    return _nameLabel;
}

-(UIView *)yellowView{
    if (!_yellowView) {
        _yellowView=[BFUICreator createViewWithBgColor:BFRGB(253, 212, 49) radius:0];
    }
    return _yellowView;
}


@end
