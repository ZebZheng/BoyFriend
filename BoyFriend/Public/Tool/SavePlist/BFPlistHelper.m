//
//  BFPlistHelper.m
//  Demon
//
//  Created by apple on 2021/2/7.
//  Copyright © 2021 BoyFriend. All rights reserved.
//

#import "BFPlistHelper.h"

@implementation BFPlistHelper

+ (BOOL)createFileWithPlistName:(NSString *)plistName {
    NSString *path = [BFPathTools docFilePathWithFileName:plistName];
    if (![BFPathTools exists:path]) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict writeToFile:path atomically:YES];
    }
    return [BFPathTools exists:path];
}

// 添加
+ (void)setObject:(id)destObj forDestKey:(NSString *)destKey plistName:(NSString *)plistName {
    
    NSString *path = [BFPathTools docFilePathWithFileName:plistName];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    if (dict == nil) {
        dict = [NSMutableDictionary new];
    }
    [dict setObject:destObj forKey:destKey];
    
    [dict writeToFile:path atomically:YES];
}

// 读取
+ (id)objectForDestKey:(NSString *)destkey plistName:(NSString *)plistName {
    
    NSString *path = [BFPathTools docFilePathWithFileName:plistName];
    NSMutableDictionary *destObj = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    return destObj[destkey];
}

// 删除
+ (void)removeObjectForDestKey:(NSString *)destkey plistName:(NSString *)plistName {
    NSString *path = [BFPathTools docFilePathWithFileName:plistName];
    NSMutableDictionary *destObj = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    [destObj removeObjectForKey:destkey];
    [destObj writeToFile:path atomically:YES];
}

// 删除 Plist 文件
+ (void)removeFileWithPlistName:(NSString *)plistName {
    
    NSFileManager *fileMger = [NSFileManager defaultManager];
    NSString *path = [BFPathTools docFilePathWithFileName:plistName];

    //如果文件路径存在的话
    BOOL is = [fileMger fileExistsAtPath:path];
    if (is) {
        NSError *err;
        [fileMger removeItemAtPath:path error:&err];
    }
}


@end
