/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BFImagePosition) {
    BFImagePositionLeft = 0,              //图片在左，文字在右，默认
    BFImagePositionRight = 1,             //图片在右，文字在左
    BFImagePositionTop = 2,               //图片在上，文字在下
    BFImagePositionBottom = 3,            //图片在下，文字在上
    BFImagePositionMiddleAligning = 4,    //图文中间对齐
};

@interface UIButton (BFImagePosition)

//MARK: - 图文位置
- (void)bf_imagePosition:(BFImagePosition)postitionStatus spacing:(CGFloat)spacing;

@end


