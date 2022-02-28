//
//  BFPopShowView.m
//  AirMonitor
//
//  Created by Apple on 2016/11/29.
//  Copyright © 2016年 http://blog.csdn.net/WCea9306/. All rights reserved.
//

#import "BFPopShowView.h"

@interface BFPopShowView ()

@property (nonatomic, strong) UIView *customView;

@end

@implementation BFPopShowView

- (instancetype)initWithCustomView:(UIView *)customView {
    self = [super initWithFrame:CGRectMake(0, 0, BFScreen_Width, BFScreen_Height)];
    if (self) {
        self.customView = customView;
        commonInitSafe(BFPopShowView);
    }
    return self;
}

commonInitImplementationSafe(BFPopShowView) {

    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:self.customView];
    [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.bottom.equalTo(@0);
    }];
}

- (void)showViewAinmation:(BOOL)animation {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    animation ?
    [self shakeToShow:self.customView] :
    nil;
}

- (void)dismissView {
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}

- (void)shakeToShow:(UIView *)detailView {
    
    [self centerToAroundWithView:detailView];
}

@end
