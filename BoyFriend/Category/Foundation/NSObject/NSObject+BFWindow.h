/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BFWindow)

//获取当前控制器
- (UIViewController*)bf_currentViewController;
//获取KeyWindow
- (UIWindow *)bf_getKeyWindow;

@end

NS_ASSUME_NONNULL_END
