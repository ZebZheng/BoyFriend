/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (BFConversion)
/** base64 转 image */
@property (nonatomic, copy, readonly)UIImage * bf_base64ToImage;
/// 阿拉伯数字转换成中文
+ (NSString *)bf_digitalConversionNumber:(int)number;
    
///汉语数字转阿拉伯数字
+(NSString *)bf_chaptersDealWithString:(NSString *)chapterStr;

///转换成数组-> ","分割
- (NSArray *)bf_toArray;
///转换成数组
- (NSArray *)bf_toArrayByString:(NSString *)string;
///转换成data
- (NSData *)bf_toData;

@end


