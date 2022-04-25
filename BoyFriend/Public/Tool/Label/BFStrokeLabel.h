/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///带边框的
@interface BFStrokeLabel : UILabel

/** 描多粗的边*/

@property (nonatomic, assign) NSInteger outLineWidth;

/** 外轮颜色*/

@property (nonatomic, strong) UIColor *outLinetextColor;

/** 里面字体默认颜色*/

@property (nonatomic, strong) UIColor *labelTextColor;

@end

NS_ASSUME_NONNULL_END
