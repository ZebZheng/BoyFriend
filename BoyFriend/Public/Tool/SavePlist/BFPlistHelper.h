//
//  BFPlistHelper.h
//  Demon
//
//  Created by apple on 2021/2/7.
//  Copyright © 2021 BoyFriend. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
*  本类用来 简单保存持久化数据的操作，基于 Plist 文件，支持自定义 Plist 文件
*/


@interface BFPlistHelper : NSObject


// 创建 plist 文件
+ (BOOL)createFileWithPlistName:(NSString *)plistName;

// 添加
+ (void)setObject:(id)destObj forDestKey:(NSString *)destKey plistName:(NSString *)plistName;

// 根据 Key 读取
+ (id)objectForDestKey:(NSString *)destkey plistName:(NSString *)plistName;

// 根据 key 删除
+ (void)removeObjectForDestKey:(NSString *)destkey plistName:(NSString *)plistName;

// 删除 Plist 文件
+ (void)removeFileWithPlistName:(NSString *)plistName;



@end

NS_ASSUME_NONNULL_END
