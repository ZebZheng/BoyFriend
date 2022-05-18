//
//  BFLinkageTCCollectionViewHeaderView.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/29.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFLinkageTCCollectionViewHeaderView.h"

@interface BFLinkageTCCollectionViewHeaderView ()



@end

@implementation BFLinkageTCCollectionViewHeaderView


#pragma mark - init

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self bf_initSubviews];
        [self bf_makeContraints];
    }
    return self;
}


//MARK: - 视图初始化
- (void)bf_initSubviews {
    self.backgroundColor = BFRGB_A(240, 240, 240, 0.8);
    [self addSubview:self.headTitleLabel];
}

//MARK: - 约束
- (void)bf_makeContraints {
    [self.headTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(BFRatio(8));
        make.right.mas_equalTo(self);
    }];
}

//MARK: - 数据初始化
- (void)bf_setupWithData:(id)data {
    self.headTitleLabel.text = data;
}

#pragma mark - function


#pragma mark - Data


#pragma mark - Event Response / IBActions


#pragma mark - Setter


#pragma mark - Getter

//复用cell复用标识
+(NSString *)bf_reuseIdentifier{
    return NSStringFromClass([self class]);
}

-(UILabel *)headTitleLabel{
    if (!_headTitleLabel) {
        _headTitleLabel=[BFUICreator createLabelWithText:@"" color:UIColor.blackColor font:BFSysFontWithSizes(14)];
        _headTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _headTitleLabel;
}



@end



