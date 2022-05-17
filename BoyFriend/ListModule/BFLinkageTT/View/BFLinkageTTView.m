//
//  BFLinkageTTHeadView.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/29.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFLinkageTTHeadView.h"

@interface BFLinkageTTHeadView ()


@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation BFLinkageTTHeadView


#pragma mark - init
//MARK: - 视图初始化
- (void)bf_initSubviews {
    self.backgroundColor = BFRGB_A(240, 240, 240, 0.8);
    [self addSubview:self.nameLabel];

}

//MARK: - 约束
- (void)bf_makeContraints {
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, BFRatio(15), 0, BFRatio(15)));
    }];
}

//MARK: - 数据初始化
- (void)bf_setupWithData:(id)data {
    self.nameLabel.text = data;
}

#pragma mark - function


#pragma mark - Data


#pragma mark - Event Response / IBActions


#pragma mark - Setter


#pragma mark - Getter
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[BFUICreator createLabelWithText:@"" color:UIColor.blackColor font:BFSysFontWithSizes(13)];
    }
    return _nameLabel;
}



@end
