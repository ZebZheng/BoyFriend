/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

typedef void (^BFGestureActionBlock)(UIGestureRecognizer * gestureRecoginzer);

@interface UIView (BFBlock)

//MARK: - tap手势
- (void)bf_addTapActionWithBlock:(BFGestureActionBlock)block;
//MARK: - 长按手势
- (void)bf_addLongPressActionWithBlock:(BFGestureActionBlock)block;

@end


