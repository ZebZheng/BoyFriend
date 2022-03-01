//
//  BaseView.h
//  Demon
//
//  Created by BoyFriend on 2017/11/14.
//  Copyright © 2017年 BoyFriend. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

- (void)bf_initSubviews;

- (void)bf_makeContraints;

- (void)bf_setupWithData:(id)data;



#pragma mark 动画
//从中心往四周扩大动画
-(void)bf_centerToAroundWithView:(UIView *)view;

@end
