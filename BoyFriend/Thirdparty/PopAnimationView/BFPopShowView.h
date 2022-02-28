//
//  BFPopShowView.h
//  AirMonitor
//
//  Created by Apple on 2016/11/29.
//  Copyright © 2016年 http://blog.csdn.net/WCea9306/. All rights reserved.
//  从中心往四周扩大动画

#import "BaseView.h"

@interface BFPopShowView : BaseView

- (instancetype)initWithCustomView:(UIView *)customView;

- (void)showViewAinmation:(BOOL)animation;

- (void)dismissView;

@end
