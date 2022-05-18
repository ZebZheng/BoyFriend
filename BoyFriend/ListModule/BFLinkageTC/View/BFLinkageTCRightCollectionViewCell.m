//
//  BFLinkageTCRightCollectionViewCell.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/17.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFLinkageTCRightCollectionViewCell.h"

@interface BFLinkageTCRightCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation BFLinkageTCRightCollectionViewCell

//MARK: - 视图初始化
- (void)bf_initSubviews {
    [self.contentView bf_addSubviews:@[self.imageV,self.nameLabel]];
}

//MARK: - 约束
- (void)bf_makeContraints {
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BFRatio(2));
        make.top.mas_equalTo(BFRatio(2));
        make.right.mas_equalTo(-BFRatio(2));
        make.height.mas_equalTo(self.imageV.mas_width);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.imageV);
        make.top.mas_equalTo(self.imageV.mas_bottom).offset(BFRatio(5));
    }];
}

//MARK: - 数据初始化
- (void)bf_setupWithData:(id)data {
    BFSubCategoryModel * model = data;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
    self.nameLabel.text = model.name;
}


#pragma 懒加载
-(UIImageView *)imageV{
    if (!_imageV) {
        _imageV=[BFUICreator createImageViewWithName:@""];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageV;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[BFUICreator createLabelWithText:@"" color:UIColor.blackColor font:BFSysFontWithSizes(13)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}



@end
