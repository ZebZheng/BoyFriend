/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

@interface UIImage (BFWechat)

/**
    微信聊天模式的图(--图片大小按800来计算--)
 */
- (UIImage *)wcSessionCompress;

/**
    微信朋友圈的图(--图片大小按1280来计算--)
 */
- (UIImage *)wcTimelineCompress;




/*
 策略算法
 
 
 图片尺寸
 
 宽高均 <= 1280，图片尺寸大小保持不变
 宽或高 > 1280 && 宽高比 <= 2，取较大值等于1280，较小值等比例压缩
 宽或高 > 1280 && 宽高比 > 2 && 宽或高 < 1280，图片尺寸大小保持不变
 宽高均 > 1280 && 宽高比 > 2，取较小值等于1280，较大值等比例压缩
 
 注：当宽和高均小于1280，并且宽高比大于2时，微信聊天会话和微信朋友圈的处理不一样。
 朋友圈：取较小值等于1280，较大值等比例压缩
 聊天会话：取较小值等于800，较大值等比例压缩
 
 图片质量
 
 经过大量的测试，微信的图片压缩质量值 ≈0.5
 
 UIImageJPEGRepresentation(resizeImage, 0.5)
 
 
 */


@end
