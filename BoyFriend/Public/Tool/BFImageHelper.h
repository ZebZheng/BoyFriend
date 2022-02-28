/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BFHandyMacro.h"
NS_ASSUME_NONNULL_BEGIN

@interface BFImageHelper : NSObject
BFSINGLETON_H

///gif转图片组
- (NSArray *)imagesWithGif:(NSString *)gifName type:(NSString *)type;
///保存到相册
- (void)bf_savedPhotosAlbum:(UIImage *)img successful:(void(^)(void))successBlock error:(void(^)(NSString *error))errorBlock;
@end

NS_ASSUME_NONNULL_END
