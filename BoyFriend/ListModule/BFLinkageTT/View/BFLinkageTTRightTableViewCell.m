//
//  BFLinkageTTRightTableViewCell.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/17.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFLinkageTTRightTableViewCell.h"

@interface BFLinkageTTRightTableViewCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end


@implementation BFLinkageTTRightTableViewCell


- (void)bf_initSubviews {
    [self.contentView bf_addSubviews:@[self.imageV,self.nameLabel,self.priceLabel]];
}

- (void)bf_makeContraints {
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BFRatio(15));
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(BFRatio(50), BFRatio(50)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageV);
        make.left.mas_equalTo(self.imageV.mas_right).offset(BFRatio(15));
        make.right.mas_equalTo(-BFRatio(15));
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.imageV);
        make.left.right.mas_equalTo(self.nameLabel);
    }];
    
}

- (void)bf_setupWithData:(id)data {
    BFFoodModel * model = data;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.picture]];
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",@(model.min_price)];
}


#pragma 懒加载
-(UIImageView *)imageV{
    if (!_imageV) {
        _imageV=[BFUICreator createImageViewWithName:@""];
    }
    return _imageV;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[BFUICreator createLabelWithText:@"" color:UIColor.blackColor font:BFSysFontWithSizes(14)];
    }
    return _nameLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel=[BFUICreator createLabelWithText:@"" color:UIColor.redColor font:BFSysFontWithSizes(14)];
    }
    return _priceLabel;
}

@end
