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



#pragma mark 动画
//从中心往四周扩大动画
-(void)bf_centerToAroundWithView:(UIView *)view{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D: CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D: CATransform3DMakeScale(0.5, 0.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
}


@end
