/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

typedef UIView *(^BFConrnerCorner) (UIRectCorner  corner );
typedef UIView *(^BFConrnerRadius) (CGFloat       radius );

typedef UIView *(^BFBorderColor  ) (UIColor      *color  );
typedef UIView *(^BFBorderWidth  ) (CGFloat       width  );

typedef UIView *(^BFShadowColor  ) (UIColor      *color  );
typedef UIView *(^BFShadowOffset ) (CGSize        size   );
typedef UIView *(^BFShadowRadius ) (CGFloat       radius );
typedef UIView *(^BFShadowOpacity) (CGFloat       opacity);

typedef UIView *(^BFBezierPath) (UIBezierPath    *path   );
typedef UIView *(^BFViewBounds) (CGRect           rect   );

typedef UIView *(^BFShowVisual) (void);
typedef UIView *(^BFClerVisual) (void);

/**
 注意：在设置圆角和阴影时会去获取视图控件的bounds，所以在视图控件的bounds变化后，需要重新设置
 */
@interface UIView (BFEffects)

//MARK: - 圆角 默认 UIRectCornerAllCorners
@property(nonatomic, strong, readonly)BFConrnerCorner bf_conrnerCorner;
//MARK: - 圆角半径 默认 0.0
@property(nonatomic, strong, readonly)BFConrnerRadius bf_conrnerRadius;

//MARK: - 边框颜色 默认 black
@property(nonatomic, strong, readonly)BFBorderColor   bf_borderColor;
//MARK: - 边框宽度 默认 0.0
@property(nonatomic, strong, readonly)BFBorderWidth   bf_borderWidth;

//MARK: - 阴影颜色 默认 black
@property(nonatomic, strong, readonly)BFShadowColor   bf_shadowColor;
//MARK: - 阴影偏移方向和距离 默认 {0.0，0.0}
@property(nonatomic, strong, readonly)BFShadowOffset  bf_shadowOffset;
//MARK: - 阴影模糊度 默认 0.0
@property(nonatomic, strong, readonly)BFShadowRadius  bf_shadowRadius;
//MARK: - (0~1] 默认 0.0
@property(nonatomic, strong, readonly)BFShadowOpacity bf_shadowOpacity;

//MARK: - 贝塞尔路径   默认 nil (有值时，radius属性将失效)
@property(nonatomic, strong, readonly)BFBezierPath bf_bezierPath;
//MARK: - 设置圆角时，会去获取视图的bounds属性，如果此时获取不到，则需要传入该参数，默认为 nil，如果传入该参数，则不会去回去视图的bounds属性了
@property(nonatomic, strong, readonly)BFViewBounds bf_viewBounds;

//MARK: - 调用
@property(nonatomic, strong, readonly)BFShowVisual bf_showVisual;
//MARK: - 隐藏
@property(nonatomic, strong, readonly)BFClerVisual bf_clerVisual;

@end
