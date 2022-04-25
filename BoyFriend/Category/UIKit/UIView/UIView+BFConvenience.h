/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

@interface UIView (BFConvenience)

/// 背景图片(以图片设置背景色)
@property(nonatomic, strong) UIImage *bf_backgroundImage;

//提供自动布局后的View宽高及坐标值
@property (nonatomic, assign, readonly) CGPoint bf_layoutPoint;
@property (nonatomic, assign, readonly) CGSize bf_layoutSize;

//Frame 设置的对应的值
@property (nonatomic) CGPoint bf_origin;
@property (nonatomic) CGSize bf_size;

@property (nonatomic) CGFloat bf_X;
@property (nonatomic) CGFloat bf_Y;

@property (nonatomic) CGFloat bf_right;
@property (nonatomic) CGFloat bf_bottom;

@property (nonatomic) CGFloat bf_width;
@property (nonatomic) CGFloat bf_height;

@property (nonatomic) CGFloat bf_centerX;
@property (nonatomic) CGFloat bf_centerY;

- (BOOL)bf_containsSubView:(UIView *)subView;
- (BOOL)bf_containsSubViewOfClassType:(Class)classType;
- (void)bf_removeAllSubViews;
- (void)bf_addSubviews:(id)array;

@end
