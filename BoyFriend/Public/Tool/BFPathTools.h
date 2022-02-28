//
//  BFPathTools.h
//  FastApp
//
//  Created by tangkunyin on 16/3/29.
//  Copyright © 2016年 www.shuoit.net. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,BFPathType)
{
    BFHomePathType,//沙盒主目录，可见子目录(3个):Documents、Library、tmp
    BFBundlePathType,//[NSBundle mainBundle]
    BFDocPathType,//文档目录
    BFLibPrefPathType,//配置目录
    BFLibCachePathType,//缓存目录
    BFTmpPathType//临时缓存目录
};

@interface BFPathTools : NSObject

/**
 *  判断文件夹是否存在，不存在则创建
 *
 *  @param path       文件夹路径
 *  @param autoCreate 如果文件夹不存在，是否自动创建
 *
 *  @return 文件夹是否存在或创建成功
 */
+ (BOOL)exists:(NSString *)path autoCreate:(BOOL)autoCreate;

/*
 *  判断某个具体文件是否存在
 *
 *  @param path       文件夹路径
 */
+ (BOOL)exists:(NSString *)path;

/*
 *  删除某个文件夹（包括内部文件）
 */
+ (void)removeFolderWithPath:(NSString *)path;

/**
 *  根据key和目录类型返回数据存放的地址
 *
 *  @param key  数据名称
 *  @param type 目录类型
 *
 *  @return 数据存放位置
 */
+ (NSString *)pathForKey:(NSString *)key type:(BFPathType)type;


/**
 *  @return 沙盒主目录，可见子目录(3个):Documents、Library、tmp
 */
+ (NSString *)homePath;

/**
 *  @return 文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据
 */
+ (NSString *)docPath;

/**
 *  @return 配置目录，偏好设置存这里
 */
+ (NSString *)libPrefPath;

/**
 *  @return 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
 */
+ (NSString *)libCachePath;

/**
 *  @return 临时缓存目录，APP退出后，系统可能会删除这里的内容
 */
+ (NSString *)tmpPath;



/*
 *  获取指定路径下某个文件的大小
 *
 *  @param path       目录路径
 */
+ (unsigned long long)fetchFileSizeWithFilePath:(NSString *)filePath;

/*
 *  将文件Size转换成合适的单位显示
 */
+ (NSString *)fileSizeWithInterge:(unsigned long long)size;


/**
*  @param fileName   子文件名称
*  @return 文档目录下的子文件路径
*/
+ (NSString *)docFilePathWithFileName:(NSString *)fileName;


@end
