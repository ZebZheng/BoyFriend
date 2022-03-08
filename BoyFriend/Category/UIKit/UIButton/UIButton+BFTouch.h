/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (BFTouch)

//MARK: - 设置按钮额外点击区域
@property (nonatomic, assign) UIEdgeInsets bf_touchAreaInsets;

@end

NS_ASSUME_NONNULL_END
