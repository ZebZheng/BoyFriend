//
//  BFPathTools.m
//  FastApp
//
//  Created by tangkunyin on 16/3/29.
//  Copyright © 2016年 www.shuoit.net. All rights reserved.
//

#import "BFPathTools.h"
#import "BFStringTools.h"
@implementation BFPathTools

+ (BOOL)exists:(NSString *)path autoCreate:(BOOL)autoCreate{
    if (autoCreate) {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL)exists:(NSString *)path {
    
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (void)removeFolderWithPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager removeItemAtPath:path error:NULL]) {
        NSLog(@"Removed successfully");
    }
}

+ (unsigned long long)fetchFileSizeWithFilePath:(NSString *)filePath {
    
    if ([BFPathTools exists:filePath]) {
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        return [attrs fileSize];
    }
    return 0.0;
}

+ (NSString *)homePath{
    return NSHomeDirectory();
}

+ (NSString *)docPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preferences"];
}

+ (NSString *)libCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)tmpPath{
    return NSTemporaryDirectory();
}


+ (NSString *)fileSizeWithInterge:(unsigned long long)size {
    if (size < 1024.0f) {  // 小于1k
        return [NSString stringWithFormat:@"%lld B", size];
    } else if (size < 1024.0 * 1024.0) { // 小于1M
        CGFloat aFloat = size / (CGFloat)1024.0f;
        return [NSString stringWithFormat:@"%.2f K",aFloat];
    } else if (size < 1024 * 1024 * 1024) {  // 小于1G
        CGFloat aFloat = size / (CGFloat)(1024 * 1024);
        return [NSString stringWithFormat:@"%.2f M",aFloat];
    } else {
        CGFloat aFloat = size / (CGFloat)(1024 * 1024 * 1024);
        return [NSString stringWithFormat:@"%.2f G",aFloat];
    }
}

+ (NSString *)pathForKey:(NSString *)key type:(BFPathType)type{
    if (![BFStringTools isEmpty:key]) {
        NSString *dataPath = @"";
        switch (type) {
            case BFHomePathType:
                dataPath = [NSString stringWithFormat:@"%@/%@",[self homePath],key];
                break;
            case BFBundlePathType:
                dataPath = [[NSBundle mainBundle] pathForResource:key ofType:nil];
                break;
            case BFDocPathType:
                dataPath = [NSString stringWithFormat:@"%@/%@",[self docPath],key];
                break;
            case BFLibPrefPathType:
                dataPath = [NSString stringWithFormat:@"%@/%@",[self libPrefPath],key];
                break;
            case BFLibCachePathType:
                dataPath = [NSString stringWithFormat:@"%@/%@",[self libCachePath],key];
                break;
            case BFTmpPathType:
                dataPath = [NSString stringWithFormat:@"%@%@",[self tmpPath],key];
                break;
        }
        return dataPath;
    }
    return nil;
}


+ (NSString *)docFilePathWithFileName:(NSString *)fileName{
    NSString *path = [self docPath];

    return [path stringByAppendingPathComponent:fileName];
}



@end
