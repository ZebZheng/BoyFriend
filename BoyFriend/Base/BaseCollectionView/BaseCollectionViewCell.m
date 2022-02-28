//
//  BaseCollectionViewCell.m
//  Demon
//
//  Created by apple on 2020/2/15.
//  Copyright © 2020 BoyFriend. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSubviews];
    [self makeContraints];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
