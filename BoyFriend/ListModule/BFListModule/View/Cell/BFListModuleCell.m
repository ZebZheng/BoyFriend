//
//  BFListModuleCell.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/27.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFListModuleCell.h"

@interface BFListModuleCell ()

/// 名称
@property(nonatomic, strong) UILabel *nameLabel;
/// 线
@property (nonatomic,strong) UIView *lineView;


@end

@implementation BFListModuleCell


- (void)bf_initSubviews {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.lineView];
}

- (void)bf_makeContraints {
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(LeftMargin_Constant);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)bf_setupWithData:(id)data {
    BFListModuleInfoModel  * infoModel = data;
    self.nameLabel.text = infoModel.name;
    
}


-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[BFUICreator createLabelWithText:@"" color:UIColor.blackColor font:BFPFRFontWithSizes(18)];
        _nameLabel.userInteractionEnabled = NO;
    }
    return _nameLabel;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView=[BFUICreator createViewWithBgColor:BFRGB_Line radius:0];
    }
    return _lineView;
}

@end
