//
//  BFSystemUtils.h
//  Demon
//
//  Created by BoyFriend on 2018/7/17.
//  Copyright © 2018年 BoyFriend. All rights reserved.
//  系统权限管理类

#import <Foundation/Foundation.h>

/*
 *  系统权限 管理类
 */

@interface BFSystemUtils : NSObject

/**
 *  是否允许相册权限
 */
+ (BOOL)isAllowPhotoLibrary;

// 是否允许相册权限 Block 形式场景
+ (void)isAllowPhotoLibraryCompleted:(void (^)(BOOL granted))completed;

/**
 *  是否允许相机访问
 */
+ (BOOL)isAllowCamera;

// 是否允许相机访问 Block 形式场景
+ (void)isAllowCameraCompleted:(void (^)(BOOL granted))completed;

/**
 *  是否允许麦克风访问
 */
+ (BOOL)isAllowAudio;

/**
 *  是否允许定位
 */
+ (BOOL)isAllowLocation;



//保存图片到系统相册
+(void)saveImageToSystemAlbum:(UIImage *)img;


@end
