//
//  BFDrawerTransition.h
//  ViewControllerTransition
//
//  Created by chavez on 2017/6/27.
//  Copyright © 2017年 chavez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BFLateralSlideConfiguration.h"

typedef NS_ENUM(NSUInteger,BFDrawerTransitiontype) {
    BFDrawerTransitiontypeShow = 0,      // 显示抽屉
    BFDrawerTransitiontypeHidden,        // 隐藏抽屉
};


typedef NS_ENUM(NSUInteger,BFDrawerAnimationType) {
    BFDrawerAnimationTypeDefault = 0,
    BFDrawerAnimationTypeMask
};

@interface BFDrawerTransition : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTransitionType:(BFDrawerTransitiontype)transitionType animationType:(BFDrawerAnimationType)animationType configuration:(BFLateralSlideConfiguration *)configuration;

+ (instancetype)transitionWithType:(BFDrawerTransitiontype)transitionType animationType:(BFDrawerAnimationType)animationType configuration:(BFLateralSlideConfiguration *)configuration;

@end


@interface BFMaskView : UIView<UIGestureRecognizerDelegate>

@property (nonatomic,copy) NSArray *toViewSubViews;

+ (instancetype)shareInstance;

+ (void)releaseInstance;

@end


UIKIT_EXTERN NSString *const BFLateralSlideAnimatorKey;
UIKIT_EXTERN NSString *const BFLateralSlideMaskViewKey;
UIKIT_EXTERN NSString *const BFLateralSlideInterativeKey;

UIKIT_EXTERN NSString *const BFLateralSlidePanNoticationKey;
UIKIT_EXTERN NSString *const BFLateralSlideTapNoticationKey;

UIKIT_EXTERN NSString *const BFLateralSlideDirectionKey;



