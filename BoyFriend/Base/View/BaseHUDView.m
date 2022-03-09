//
//  BaseHUDView.m
//  Demon
//
//  Created by BoyFriend on 2018/8/28.
//  Copyright © 2018年 BoyFriend. All rights reserved.
//

#import "BaseHUDView.h"

@interface BaseHUDView ()

@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation BaseHUDView

- (void)initSubviews {
    self.backgroundColor = [UIColor clearColor];
    
    UIImageView * animatedImageView = [[UIImageView alloc] initWithFrame:CGRectMake((BFScreen_Width - BFRatio(160)) / 2.0, (BFScreen_Height - BFRatio(100)) / 2.0f, BFRatio(160), BFRatio(100))];
    animatedImageView.animationImages = @[BFImageName(@"hud_loading1_icon"),
                                          BFImageName(@"hud_loading2_icon"),
                                          BFImageName(@"hud_loading3_icon"),
                                          BFImageName(@"hud_loading4_icon"),
                                          BFImageName(@"hud_loading5_icon"),
                                          BFImageName(@"hud_loading6_icon")
                                          ];
    animatedImageView.animationDuration = 1.0f;
    animatedImageView.animationRepeatCount = 0;

    [self addSubview:animatedImageView];
    [animatedImageView startAnimating];

    [animatedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-BFRatio(100));
        make.centerX.equalTo(self);
        make.width.equalTo(@(BFRatio(160)));
        make.height.equalTo(@(BFRatio(100)));
    }];

    self.messageLabel = [BFUICreator createLabelWithText:@"正在努力加载中..." color:BFRGB_FontColor font:BFPFRFontWithSizes(14)];

    [self addSubview:self.messageLabel];

    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(animatedImageView.mas_bottom).offset(BFRatio(18));
        make.centerX.equalTo(self);
    }];
}

- (void)setIsTransparent:(BOOL)isTransparent {
    _isTransparent = isTransparent;
    
    self.backgroundColor = isTransparent ? [UIColor clearColor] : [UIColor whiteColor];
}

- (void)setMessage:(NSString *)message {
    _message = message;
    
    self.messageLabel.text = message;
}

- (void)hideHUD {
//    [self removeAllSubViews];
    [self removeFromSuperview];
}

@end
