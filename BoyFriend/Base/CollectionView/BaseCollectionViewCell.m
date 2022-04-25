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
    [self bf_initSubviews];
    [self bf_makeContraints];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self bf_initSubviews];
        [self bf_makeContraints];
    }
    
    return self;
}

- (void)bf_initSubviews{
    
}

- (void)bf_makeContraints{
    
}

- (void)bf_setupWithData:(id)datd{
    
}
//复用cell复用标识
+(NSString *)bf_reuseIdentifier{
    return NSStringFromClass([self class]);
}

@end
