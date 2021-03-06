//
//  AdvertiseHelper.m
//  Demon 启动广告帮助类
//
//  Created by BoyFriend on 16/6/14.
//  Copyright © 2016年 BoyFriend. All rights reserved.
//

#import "AdvertiseHelper.h"

@implementation AdvertiseHelper

+ (instancetype)sharedInstance
{
    static AdvertiseHelper* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AdvertiseHelper new];
    });

    return instance;
}


+(void)showAdvertiserView:(NSArray *)imageArray
{
    // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
    NSString *filePath = [[AdvertiseHelper sharedInstance] getFilePathWithImageName:[kAdUserDefaults valueForKey:adImageName]];
    BOOL isExist = [[AdvertiseHelper sharedInstance] isFileExistWithFilePath:filePath];
    if (isExist) {// 图片存在
        AdvertiseView *advertiseView = [[AdvertiseView alloc] initWithFrame:kAdMain_Screen_Bounds];
        advertiseView.filePath = filePath;
        [advertiseView show];
    }
    
    // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [[AdvertiseHelper sharedInstance] getAdvertisingImage:imageArray];
}


/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage:(NSArray *)imageArray
{
    //随机取一张
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    // 拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
    }
}

/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}


/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            BFDEBUG(@"保存成功");
            [self deleteOldImage];
            [kAdUserDefaults setValue:imageName forKey:adImageName];
            [kAdUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            BFDEBUG(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [kAdUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}
@end
