//
//  AppDelegate.h
//  Demon
//
//  Created by apple on 2019/1/16.
//  Copyright © 2019年 BoyFriend. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarController.h"
#import "BFLoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) BFLoginViewController *loginPageVC;
@property (nonatomic, strong) BaseTabBarController *tabBarVC;


@end

