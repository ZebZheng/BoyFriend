//
//  BFLateralSlideAnimator.m
//  ViewControllerTransition
//
//  Created by chavez on 2017/6/29.
//  Copyright © 2017年 chavez. All rights reserved.
//

#import "BFLateralSlideAnimator.h"
#import "BFDrawerTransition.h"

@interface BFLateralSlideAnimator ()

@property (nonatomic,strong) BFInteractiveTransition *interactiveHidden;
@property (nonatomic,strong) BFInteractiveTransition *interactiveShow;

@end

@implementation BFLateralSlideAnimator


- (instancetype)initWithConfiguration:(BFLateralSlideConfiguration *)configuration {
    if (self = [super init]) {
        _configuration = configuration;
    }
    return self;
}

+ (instancetype)lateralSlideAnimatorWithConfiguration:(BFLateralSlideConfiguration *)configuration {
    return [[self alloc] initWithConfiguration:configuration];
}

- (void)dealloc {
//    NSLog(@"%s",__func__);
}

- (void)setConfiguration:(BFLateralSlideConfiguration *)configuration {
    _configuration = configuration;
    [self.interactiveShow setValue:configuration forKey:@"configuration"];
    [self.interactiveHidden setValue:configuration forKey:@"configuration"];

}

#pragma mark -UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [BFDrawerTransition transitionWithType:BFDrawerTransitiontypeShow animationType:_animationType configuration:_configuration];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [BFDrawerTransition transitionWithType:BFDrawerTransitiontypeHidden animationType:_animationType configuration:_configuration];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveShow.interacting ? self.interactiveShow : nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
//    NSLog(@"----------------------%@",self.interactiveHidden);
    return self.interactiveHidden.interacting ? self.interactiveHidden : nil;
}




@end
