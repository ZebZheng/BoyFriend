//
//  NetWorkHelper.h
//  Demon
//
//  Created by Social on 15/4/22.
//  Copyright (c) 2015年 Social . All rights reserved.
//

#import "NetWorkURL.h"
#import "API.h"
#import "BaseViewModel.h"

@interface NetWorkHelper : NSObject

+ (NetWorkHelper *)sharedInstance;

/**
 *  发送get请求
 *
 *  @param uriString  请求的Uri字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)getWithUriString:(NSString *)uriString
              Parameters:(NSDictionary*)parameters
                 Success:(void (^)(id responseObject))success
                 Failure:(void (^)(BaseResponseData *error))failure;

/**
 *  发送post请求
 *
 *  @param uriString  请求的Uri字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)postWithUriString:(NSString *)uriString
               Parameters:(NSDictionary*)parameters
                  Success:(void (^)(id responseObject))success
                  Failure:(void (^)(BaseResponseData *error))failure;
/**
 *  发送put请求
 *
 *  @param uriString  请求的Uri字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)putWithUriString:(NSString *)uriString
              Parameters:(NSDictionary*)parameters
                 Success:(void (^)(id responseObject))success
                 Failure:(void (^)(BaseResponseData *error))failure;

/**
 *  发送DELETE请求
 *
 *  @param uriString  请求的Uri字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)deleteWithUriString:(NSString *)uriString
                 Parameters:(NSDictionary*)parameters
                    Success:(void (^)(id responseObject))success
                    Failure:(void (^)(BaseResponseData *error))failure;

/**
 *  文件上传(Data)
 *
 *  @param uriString     uri地址
 *  @param files         要上传的文件(可上传多个)
 *  @param fileNames     文件类型名称(可传一个字符串 或者一个数组)
 *  @param parametersDic 参数
 *  @param progressBlock 进度
 *  @param success       访问成功block回调
 *  @param failure       访问失败block回调
 */
- (void)uploadFileWithUriString:(NSString *)uriString
                          Files:(NSArray  *)files
                       FileName:(id)fileNames
                     Parameters:(NSDictionary *)parametersDic
                  ProgressBlock:(void (^)(NSProgress*progress))progressBlock
                        Success:(void (^)(id responseObject))success
                        Failure:(void (^)(BaseResponseData *error))failure;


#pragma mark 文件下载(不支持断点跟离线)
/**
文件下载(不支持断点跟离线)
需要支持断点跟离线的可参考   https://www.jianshu.com/p/01390c7a4957

@param uriString     uri地址
@param fileDownloadPath 文件下载到本地指定路径,不传默认下载到 Documents/FileDownload
@param progressBlock 文件下载进度
@param success 下载成功
@param failure 下载失败
*/
- (void)downloadFileWithUriString:(NSString *)uriString
                 FileDownloadPath:(NSString *)fileDownloadPath
                    ProgressBlock:(void (^)(NSProgress*progress))progressBlock
                          Success:(void (^)(id responseObject))success
                          Failure:(void (^)(BaseResponseData *error))failure;

/**
 文件下载(不支持断点跟离线)
 需要支持断点跟离线的可参考   https://www.jianshu.com/p/01390c7a4957
 
 @param serverString  服务器地址
 @param uriString     uri地址
 @param fileDownloadPath 文件下载到本地指定路径,不传默认下载到 Documents/FileDownload
 @param progressBlock 文件下载进度
 @param success 下载成功
 @param failure 下载失败
 */
- (void)downloadFileWithServerString:(NSString *)serverString
                           UriString:(NSString *)uriString
                    FileDownloadPath:(NSString *)fileDownloadPath
                       ProgressBlock:(void (^)(NSProgress*progress))progressBlock
                             Success:(void (^)(id responseObject))success
                             Failure:(void (^)(BaseResponseData *error))failure;


#pragma mark - 构建通用参数

- (NSMutableDictionary *)buildCommonParameters:(NSDictionary *)parametersDic;

@end
