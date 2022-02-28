//
//  KBTabbar.m
//  Demon
//
//  Created by BoyFriend on 2018/5/24.
//  Copyright © 2018年 BoyFriend. All rights reserved.
//

#import "KBTabbar.h"

@interface KBTabbar ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UILabel *centerTitleLabel;

@end

@implementation KBTabbar

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.centerButton.center = CGPointMake(self.bounds.size.width * 0.5, BFRatio(76) * 0.37);
    self.centerButton.bf_Y = self.backgroundImageView.bf_Y + (12 * BFProportion);
    
    int index = 0;
    
    CGFloat width = self.bounds.size.width / 5.0f;
    
    for (UIView* sub in self.subviews) {
        
        if ([sub isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            sub.frame = CGRectMake(index * width, self.bounds.origin.y, width, [[DataLibrery shareInstance] iSiPhoneX_Series] ? (50) : self.bounds.size.height - 2);
            index++;
            
            if (index == 2) {
                self.centerTitleLabel.bottom = sub.bottom;
                index++;
            }
        }
    }
}

#pragma mark - Private methods

- (void)setupUI {
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbarBackground_icon"]];
    [self addSubview:self.backgroundImageView];
    // 153 是图片高度 750 * 153, 这么约束保证图片不变形，并且在正确的高度上，0.34 是凸起的偏移量比
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(@0);
        make.top.equalTo(@(-(BFRatio(76) * 0.34)));
        make.height.equalTo(@BFRatio(76));
    }];
    
    // 中间 Item , 兼容iPhoneX
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"tabbarCenter_icon"] forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted=NO;
    self.centerButton = btn;
    [self addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImageView.mas_top).offset(12 * BFProportion);
        make.centerX.equalTo(self);
        make.width.height.equalTo(@(45 * BFProportion));
    }];
    
    self.centerTitleLabel = [UILabel new];
    self.centerTitleLabel.text = @"发布";
    self.centerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.centerTitleLabel.font = [UIFont systemFontOfSize:10];
    self.centerTitleLabel.textColor = BFRGB(146, 146, 146);//系统字体颜色
    
    [self addSubview:self.centerTitleLabel];
    [self.centerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn.mas_centerX);
        make.top.equalTo(btn.mas_bottom).offset(3);
        make.width.equalTo(@40);
        make.height.equalTo(@15);
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isHidden == NO) {
        
        CGPoint newPoint = [self convertPoint:point toView:self.centerButton];

        if ( [self.centerButton pointInside:newPoint withEvent:event]) {
            
            return self.centerButton;
        } else {
            
            return [super hitTest:point withEvent:event];
        }
    } else {
        return [super hitTest:point withEvent:event];
    }
}

@end
