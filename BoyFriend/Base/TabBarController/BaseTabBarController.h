//
//  BaseTabBarController.h
//  Demon
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 BoyFriend. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController<UITabBarControllerDelegate>

-(void)setBadgeValue:(NSString*)value;

@end
