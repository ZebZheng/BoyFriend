/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 标签内文本的垂直对齐方式
 */
typedef enum {
    /** 顶部垂直对齐文本 */
    BFLabelVerticalTextAlignmentTop = UIControlContentVerticalAlignmentTop,
    
    /** 居中垂直对齐文本 */
    BFLabelVerticalTextAlignmentMiddle = UIControlContentVerticalAlignmentCenter,
    
    /** 底部垂直对齐文本 */
    BFLabelVerticalTextAlignmentBottom = UIControlContentVerticalAlignmentBottom
} BFLabelVerticalTextAlignment;

@interface BFLabel : UILabel

/**
 标签内文本的垂直对齐方式
 */
@property (nonatomic, assign) BFLabelVerticalTextAlignment bf_verticalTextAlignment;

/**
 内间距
 */
@property (nonatomic, assign) UIEdgeInsets bf_textEdgeInsets;
@end

NS_ASSUME_NONNULL_END
