/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <Foundation/Foundation.h>

@interface NSString (BFRemoveEmoji)
/**
 *  @brief  是否包含emoji
 *
 *  @return 是否包含emoji
 */
- (BOOL)bf_isIncludingEmoji;

/**
 *  @brief  删除掉包含的emoji
 *
 *  @return 清除后的string
 */
- (instancetype)bf_removedEmojiString;

@end
