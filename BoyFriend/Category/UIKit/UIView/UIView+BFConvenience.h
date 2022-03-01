//
//  UIView+Convenience.h
//
//  Created by Molon on 13/11/12.
//  Copyright (c) 2013 Molon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BFConvenience)

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