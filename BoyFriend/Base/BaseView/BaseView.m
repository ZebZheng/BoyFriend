//
//  BaseView.m
//  Demon
//
//  Created by BoyFriend on 2017/11/14.
//  Copyright © 2017年 BoyFriend. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self bf_initSubviews];
        [self bf_makeContraints];
    }
    return self;
}

- (void)bf_initSubviews{
    
}

- (void)bf_makeContraints{
    
}

- (void)bf_setupWithData:(id)data{
    
}






@end
