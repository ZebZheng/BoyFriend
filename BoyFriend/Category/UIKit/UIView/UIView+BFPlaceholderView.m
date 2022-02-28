//
//  UIView+PlaceholderView.m
//  LLHBaseProject
//
//  Created by 123456 on 2017/11/17.
//  Copyright © 2017年 llh. All rights reserved.
//

#import "UIView+BFPlaceholderView.h"
#import <objc/runtime.h>

@interface UIView()
/** 用来记录UIScrollView最初的scrollEnabled */
@property (nonatomic, assign) BOOL originalScrollEnabled;
@end


@implementation UIView (BFPlaceholderView)

static void *BFPlaceholderViewKey = &BFPlaceholderViewKey;
static void *BFOriginalScrollEnabledKey = &BFOriginalScrollEnabledKey;
static void *BFPlaceholderImageViewKey = &BFPlaceholderImageViewKey;
static void *BFPlaceholderDescLabelKey = &BFPlaceholderDescLabelKey;

- (UIView *)bf_placeholderView {
    return objc_getAssociatedObject(self, &BFPlaceholderViewKey);
}

- (void)setBf_placeholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, &BFPlaceholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImageView *)bf_placeholderImageView {
    return objc_getAssociatedObject(self, &BFPlaceholderImageViewKey);
}

- (void)setBf_placeholderImageView:(UIImageView *)placeholderImageView {
    objc_setAssociatedObject(self, &BFPlaceholderImageViewKey, placeholderImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UILabel *)bf_placeholderDescLabel {
    return objc_getAssociatedObject(self, &BFPlaceholderDescLabelKey);
}

- (void)setBf_placeholderDescLabel:(UILabel *)placeholderDescLabel {
    objc_setAssociatedObject(self, &BFPlaceholderDescLabelKey, placeholderDescLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)originalScrollEnabled {
    return [objc_getAssociatedObject(self, &BFOriginalScrollEnabledKey) boolValue];
}

- (void)setOriginalScrollEnabled:(BOOL)originalScrollEnabled {
    objc_setAssociatedObject(self, &BFOriginalScrollEnabledKey, @(originalScrollEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - 展示UIView或其子类的占位图
/**
 展示UIView或其子类的占位图
 
 @param type 占位图类型
 @param reloadBlock 重新加载回调的block
 */
- (void)bf_showPlaceholderViewWithType:(BFPlaceholderViewType)type reloadBlock:(void (^)(void))reloadBlock {
    // 如果是UIScrollView及其子类，占位图展示期间禁止scroll
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        // 先记录原本的scrollEnabled
        self.originalScrollEnabled = scrollView.scrollEnabled;
        self.originalScrollEnabled = YES;
        // 再将scrollEnabled设为NO
        scrollView.scrollEnabled = NO;
    }
    
    //------- 占位图 -------//
    if (self.bf_placeholderView) {
        [self.bf_placeholderView removeFromSuperview];
        self.bf_placeholderView = nil;
    }
    self.bf_placeholderView = [[UIView alloc] init];
    [self addSubview:self.bf_placeholderView];
    self.bf_placeholderView.backgroundColor = [UIColor whiteColor];
    [self.bf_placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(self);
    }];
    
    //------- 图标 -------//
    UIImageView *imageView = [[UIImageView alloc] init];
    self.bf_placeholderImageView=[[UIImageView alloc] init];
    self.bf_placeholderImageView=imageView;
    [self.bf_placeholderView addSubview:self.bf_placeholderImageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView.superview);
        make.top.mas_equalTo(imageView.superview).mas_offset(BFRatio(150));
    }];
    
    //------- 描述 -------//
    UILabel *descLabel = [[UILabel alloc] init];
    self.bf_placeholderDescLabel = [[UILabel alloc] init];
    self.bf_placeholderDescLabel=descLabel;
    descLabel.textColor=BFRGBHEX(0x666666);
    descLabel.font=BFPFRFontWithSizes(15);
    descLabel.numberOfLines=0;
    [self.bf_placeholderView addSubview:self.bf_placeholderDescLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(descLabel.superview);
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(BFRatio(18));
    }];
    
    //------- 重新加载button -------//
    UIButton *reloadButton = [BFUICreator createButtonWithTitle:@"" titleColor:[UIColor whiteColor] font:BFPFRFontWithSizes(18) buttonType:UIButtonTypeRoundedRect bgColor:BFTheme_Color corner:BFRatio(4) target:nil action:nil];
    reloadButton.hidden=NO;
    [self.bf_placeholderView addSubview:reloadButton];

    @weakify(self);
    [[reloadButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        // 执行block回调
        if (reloadBlock) {
            reloadBlock();
        }
        // 复原UIScrollView的scrollEnabled
        if ([self isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)self;
            scrollView.scrollEnabled = self.originalScrollEnabled;
        }
    }];
    [reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(reloadButton.superview);
        make.top.mas_equalTo(descLabel.mas_bottom).mas_offset(BFRatio(27));
        make.size.mas_equalTo(CGSizeMake(BFRatio(175), BFRatio(40)));
    }];
    //是否打开滚动属性
    BOOL isScrollEnable=NO;
    //------- 根据type设置不同UI -------//
    switch (type) {
        case BFPlaceholderViewType404NoButton:{//404没有按钮
            imageView.image = [UIImage imageNamed:@"qsy_404"];
            descLabel.text = @"服务器神游去外太空啦！程序员正在召回…";
            reloadButton.hidden=YES;
        }
            break;
        case BFPlaceholderViewTypeNoNet:{//暂无网络
            imageView.image = [UIImage imageNamed:@"qsy_wl"];
            descLabel.text = @"OOPS！网络君已失联，请点击重试～";
            [reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
        }
            break;
        case BFPlaceholderViewTypeNoList:{//列表为空
            imageView.image = [UIImage imageNamed:@"qsy_k"];
            descLabel.text = @"这里空空的,什么都没有~";
            reloadButton.hidden=YES;
            isScrollEnable=YES;
        }
            break;

        default:
            break;
    }
    if ([self isKindOfClass:[UIScrollView class]]&&isScrollEnable) {
        UIScrollView *scrollView = (UIScrollView *)self;
        scrollView.scrollEnabled = YES;
    }
}

#pragma mark - 主动移除占位图
/**
 主动移除占位图
 占位图会在你点击“重新加载”按钮的时候自动移除，你也可以调用此方法主动移除
 */
- (void)bf_removePlaceholderView {
    if (self.bf_placeholderView) {
        [self.bf_placeholderView removeFromSuperview];
        self.bf_placeholderView = nil;
        // 复原UIScrollView的scrollEnabled
        if ([self isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)self;
            scrollView.scrollEnabled = self.originalScrollEnabled;
        }
    }
}


@end
