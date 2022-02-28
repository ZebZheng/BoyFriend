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
    [self initSubviews];
    [self makeContraints];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
        [self makeContraints];
    }
    
    return self;
}

- (void)initSubviews{
    
}

- (void)makeContraints{
    
}

- (void)setupWithData:(id)datd{
    
}
//复用cell复用标识
+(NSString *)reuseIdentifier{
    return NSStringFromClass([self class]);
}
@end
