//
//  BFJXCategorySegmentedViewController.h
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/11.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BFJXCategorySegmentedViewController : BaseViewController

/// 当列表个数不够屏幕宽时,是否均分屏幕
@property(nonatomic, assign) BOOL averageWidthEnabled;

/// 是否添加到导航栏上面
@property(nonatomic, assign) BOOL isAddInNavigation;

@end

NS_ASSUME_NONNULL_END
