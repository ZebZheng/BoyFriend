//
//  BFInteractiveTransition.h
//  ViewControllerTransition
//
//  Created by chavez on 2017/6/28.
//  Copyright © 2017年 chavez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFDrawerTransition.h"

@interface BFInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic,weak) BFLateralSlideConfiguration *configuration;
@property (nonatomic,assign) BOOL interacting;


- (instancetype)initWithTransitiontype:(BFDrawerTransitiontype)type;

+ (instancetype)interactiveWithTransitiontype:(BFDrawerTransitiontype)type;

- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end



