//
//  BaseTableViewCell.m
//  Demon
//
//  Created by BoyFriend on 2017/11/9.
//  Copyright © 2017年 BoyFriend. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self bf_initSubviews];
    [self bf_makeContraints];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self bf_initSubviews];
        [self bf_makeContraints];
    }
    
    return self;
}

- (void)bf_initSubviews {
    
}

- (void)bf_makeContraints {
    
}

- (void)bf_setupWithData:(id)data {
    
}

@end
