//
//  BFLateralSlideAnimator.h
//  ViewControllerTransition
//
//  Created by chavez on 2017/6/29.
//  Copyright © 2017年 chavez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFLateralSlideConfiguration.h"
#import "BFInteractiveTransition.h"

@interface BFLateralSlideAnimator : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) BFLateralSlideConfiguration *configuration;
@property (nonatomic,assign) BFDrawerAnimationType animationType;

- (instancetype)initWithConfiguration:(BFLateralSlideConfiguration *)configuration;

+ (instancetype)lateralSlideAnimatorWithConfiguration:(BFLateralSlideConfiguration *)configuration;

@end
