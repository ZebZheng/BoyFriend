//
//  BFCacheTools.m
//  FastApp
//
//  Created by tangkunyin on 16/3/7.
//  Copyright © 2016年 www.shuoit.net. All rights reserved.
//

#import "BFCacheTools.h"
#import <SDImageCache.h>

@implementation BFCacheTools


+ (id)dataForKey:(NSString *)key{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[BFPathTools libCachePath],key];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+ (id)tmpDataForKey:(NSString *)key{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[BFPathTools tmpPath],key];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+ (id)dataWithPath:(NSString *)path{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

+ (BOOL)cacheData:(id)data forKey:(NSString *)key{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[BFPathTools libCachePath],key];
    return [NSKeyedArchiver archiveRootObject:data toFile:filePath];
}

+ (BOOL)cacheTmpData:(id)data forKey:(NSString *)key{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[BFPathTools tmpPath],key];
    return [NSKeyedArchiver archiveRootObject:data toFile:filePath];
}

+ (BOOL)saveData:(id)data toPath:(NSString *)path{
    return [NSKeyedArchiver archiveRootObject:data toFile:path];
}




///获取缓存大小：
+(NSString *)getCacheSize{
//得到缓存路径
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSFileManager * manager = [NSFileManager defaultManager];
    CGFloat size = 0;
//首先判断是否存在缓存文件
    if ([manager fileExistsAtPath:path]) {
        NSArray * childFile = [manager subpathsAtPath:path];
        for (NSString * fileName in childFile) {
            //缓存文件绝对路径
            NSString * absolutPath = [path stringByAppendingPathComponent:fileName];
            size = size + [manager attributesOfItemAtPath:absolutPath error:nil].fileSize;
        }
        //计算sdwebimage的缓存和系统缓存总和
        size = size + SDImageCache.sharedImageCache.totalDiskSize;
    }
    return [NSString stringWithFormat:@"%.2fM",size / 1024 / 1024];
}
///删除缓存：
+(NSString *)cleanCache:(nullable SDWebImageNoParamsBlock)completion {
//获取缓存路径
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSFileManager * manager = [NSFileManager defaultManager];
//判断是否存在缓存文件
    if ([manager fileExistsAtPath:path]) {
        NSArray * childFile = [manager subpathsAtPath:path];
//逐个删除缓存文件
        for (NSString *fileName in childFile) {
            NSString * absolutPat = [path stringByAppendingPathComponent:fileName];
            [manager removeItemAtPath:absolutPat error:nil];
        }
//删除sdwebimage的缓存
        [SDImageCache.sharedImageCache clearMemory];
        [SDImageCache.sharedImageCache clearDiskOnCompletion:^{
            BFBlock_Safe_Calls(completion);
        }];
    }
    return @"0M";
}



@end
