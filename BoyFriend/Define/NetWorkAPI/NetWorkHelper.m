//
//  NetWorkHelper.m
//  Demon
//
//  Created by Social on 15/4/22.
//  Copyright (c) 2015年 Social . All rights reserved.
//

#import "NetWorkHelper.h"
#import "AFHTTPSessionManager.h"

#define AppSecret @"aepvtlrml9hfkdomfahsmdpj2qgszoxv6ougbej2l"


// 请求结果 对应的 code message
NSString *const RequestSuccessCode = @"code";
NSString *const RequestSuccessMessage = @"message";

NSString *const RequestFailureCode = @"code";
NSString *const RequestFailureMessage = @"message";


@interface NetWorkHelper()

@property(nonatomic,strong) AFSecurityPolicy   *securityPolicy;

@end

@implementation NetWorkHelper

+ (NetWorkHelper *)sharedInstance{
    static NetWorkHelper *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetWorkHelper alloc] init];
    });
    
    return instance;
}

#pragma mark - Get网络请求
- (void)getWithUriString:(NSString *)uriString
              parameters:(NSDictionary*)parameters
            successBlock:(void (^)(id responseObject))successBlock
            failureBlock:(void (^)(BaseResponseData *error))failureBlock{
    [self getWithServerString:[NetWorkURL sharedInstance].environmentModel.apiUrl uriString:uriString parameters:parameters successBlock:successBlock failureBlock:failureBlock];
}

- (void)getWithServerString:(NSString *)serverString
                  uriString:(NSString *)uriString
                 parameters:(NSDictionary*)parameters
               successBlock:(void (^)(id responseObject))successBlock
               failureBlock:(void (^)(BaseResponseData *error))failureBlock{

    NSString * urlString = [serverString stringByAppendingString:uriString];
    parameters = [self buildCommonParameters:parameters];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = BFApi_RequestTimeoutInterval;
    //设置加密方式
    manager.securityPolicy = self.securityPolicy;


//    BFDEBUG(@"\n地址:%@\n参数:%@",urlString,parameters);
    [manager GET:urlString parameters:parameters headers:[self buildHeaderDicParameters:parameters] progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        BFDEBUG(@"获取到的数据:%@",dic);
        NSString *code =[NSString stringWithFormat:@"%@",[dic objectForKey:RequestSuccessCode]];
        if ([self tokenIsInvalid:code]) {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = code;
            NSString * message = [NSString stringWithFormat:@"%@",[dic objectForKey:RequestSuccessMessage]];
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:[code integerValue] Info:message];

            if (failureBlock) {
                failureBlock(result);
            }
        } else {
            if (successBlock) {
                successBlock(dic);
            }
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //服务器返回的业务逻辑报文信息
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse mj_JSONObject];
        NSString *code =[NSString stringWithFormat:@"%@",[json objectForKey:RequestFailureCode]];
        NSString *message =[NSString stringWithFormat:@"%@",[json objectForKey:RequestFailureMessage]];
        
        if (json==nil) {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = [NSString stringWithFormat:@"%ld",(long)error.code];;
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:error.code Info:message];

            if (failureBlock) {
                failureBlock(result);
            }
        } else {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = code;
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:[code integerValue] Info:message];
            //token是否失效
            [self tokenIsInvalid:code];
            if (failureBlock) {
                failureBlock(result);
            }
        }
    }];
}

#pragma mark - Post网络请求

- (void)postWithUriString:(NSString *)uriString
               parameters:(NSDictionary*)parameters
             successBlock:(void (^)(id responseObject))successBlock
             failureBlock:(void (^)(BaseResponseData *error))failureBlock{
    [self postWithServerString:[NetWorkURL sharedInstance].environmentModel.apiUrl uriString:uriString parameters:parameters successBlock:successBlock failureBlock:failureBlock];
}

- (void)postWithServerString:(NSString *)serverString
                   uriString:(NSString *)uriString
                  parameters:(NSDictionary*)parameters
                successBlock:(void (^)(id responseObject))successBlock
                failureBlock:(void (^)(BaseResponseData *error))failureBlock{
    NSString * urlString = [serverString stringByAppendingString:uriString];
    parameters = [self buildCommonParameters:parameters];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    //解决乱码问题
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    manager.requestSerializer.timeoutInterval = BFApi_RequestTimeoutInterval;
    //设置加密方式
    manager.securityPolicy = self.securityPolicy;
    
//    BFDEBUG(@"\n地址:%@\n参数:%@",urlString,parameters);
    [manager POST:urlString parameters:parameters headers:[self buildHeaderDicParameters:parameters] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        BFDEBUG(@"\n地址:%@\ntoken:%@\n参数:%@获取到的数据:%@",urlString,token,parameters,dic);
        NSString *code =[NSString stringWithFormat:@"%@",[dic objectForKey:RequestSuccessCode]];
        if ([self tokenIsInvalid:code]) {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = code;
            NSString * message = [NSString stringWithFormat:@"%@",[dic objectForKey:RequestSuccessMessage]];
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:[code integerValue] Info:message];
            if (failureBlock) {
                failureBlock(result);
            }
        } else {
            if (successBlock) {
                successBlock(dic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
//        //通讯协议状态码
//        NSInteger statusCode = response.statusCode;
        //服务器返回的业务逻辑报文信息
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse mj_JSONObject];
        NSString *code =[NSString stringWithFormat:@"%@",[json objectForKey:RequestFailureCode]];
        NSString *message =[NSString stringWithFormat:@"%@",[json objectForKey:RequestFailureMessage]];
        if (json==nil) {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = [NSString stringWithFormat:@"%ld",(long)error.code];
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:error.code Info:message];

            if (failureBlock) {
                failureBlock(result);
            }

        } else {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = code;
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:[code integerValue] Info:message];
            //token是否失效
            [self tokenIsInvalid:code];
            if (failureBlock) {
                failureBlock(result);
            }
        }
    }];
}


#pragma mark - Put网络请求

- (void)putWithUriString:(NSString *)uriString
              parameters:(NSDictionary*)parameters
            successBlock:(void (^)(id responseObject))successBlock
            failureBlock:(void (^)(BaseResponseData *error))failureBlock{
    [self putWithServerString:[NetWorkURL sharedInstance].environmentModel.apiUrl uriString:uriString parameters:parameters successBlock:successBlock failureBlock:failureBlock];
}

- (void)putWithServerString:(NSString *)serverString
                  uriString:(NSString *)uriString
                 parameters:(NSDictionary*)parameters
               successBlock:(void (^)(id responseObject))successBlock
               failureBlock:(void (^)(BaseResponseData *error))failureBlock{
    NSString * urlString = [serverString stringByAppendingString:uriString];
    parameters = [self buildCommonParameters:parameters];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //解决乱码问题
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = BFApi_RequestTimeoutInterval;
    //设置加密方式
    manager.securityPolicy = self.securityPolicy;
   
//    BFDEBUG(@"\n地址:%@\n参数:%@",urlString,parameters);
    [manager PUT:urlString parameters:parameters headers:[self buildHeaderDicParameters:parameters] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        BFDEBUG(@"\n地址:%@\ntoken:%@\n参数:%@获取到的数据:%@",urlString,token,parameters,dic);
        NSString *code =[NSString stringWithFormat:@"%@",[dic objectForKey:RequestSuccessCode]];
        if ([self tokenIsInvalid:code]) {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = code;
            NSString * message = [NSString stringWithFormat:@"%@",[dic objectForKey:RequestSuccessMessage]];
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:[code integerValue] Info:message];
            if (failureBlock) {
                failureBlock(result);
            }
        } else {
            if (successBlock) {
                successBlock(dic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
//        //通讯协议状态码
//        NSInteger statusCode = response.statusCode;
        //服务器返回的业务逻辑报文信息
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse mj_JSONObject];
        NSString *code =[NSString stringWithFormat:@"%@",[json objectForKey:RequestFailureCode]];
        NSString *message =[NSString stringWithFormat:@"%@",[json objectForKey:RequestFailureMessage]];
        if (json==nil) {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = [NSString stringWithFormat:@"%ld",(long)error.code];
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:error.code Info:message];

            if (failureBlock) {
                failureBlock(result);
            }

        } else {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = code;
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:[code integerValue] Info:message];
            //token是否失效
            [self tokenIsInvalid:code];
            if (failureBlock) {
                failureBlock(result);
            }
        }
    }];

}

#pragma mark - DELETE网络请求

- (void)deleteWithUriString:(NSString *)uriString
                 parameters:(NSDictionary*)parameters
               successBlock:(void (^)(id responseObject))successBlock
               failureBlock:(void (^)(BaseResponseData *error))failureBlock{
    [self deleteWithServerString:[NetWorkURL sharedInstance].environmentModel.apiUrl uriString:uriString parameters:parameters successBlock:successBlock failureBlock:failureBlock];
}

- (void)deleteWithServerString:(NSString *)serverString
                     uriString:(NSString *)uriString
                    parameters:(NSDictionary*)parameters
                  successBlock:(void (^)(id responseObject))successBlock
                  failureBlock:(void (^)(BaseResponseData *error))failureBlock{
    NSString * urlString = [serverString stringByAppendingString:uriString];
    parameters = [self buildCommonParameters:parameters];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //解决乱码问题
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = BFApi_RequestTimeoutInterval;
    //设置加密方式
    manager.securityPolicy = self.securityPolicy;
//    BFDEBUG(@"\n地址:%@\n参数:%@",urlString,parameters);
    [manager DELETE:urlString parameters:parameters headers:[self buildHeaderDicParameters:parameters] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        BFDEBUG(@"\n地址:%@\ntoken:%@\n参数:%@获取到的数据:%@",urlString,token,parameters,dic);
        NSString *code =[NSString stringWithFormat:@"%@",[dic objectForKey:RequestSuccessCode]];
        if ([self tokenIsInvalid:code]) {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = code;
            NSString * message = [NSString stringWithFormat:@"%@",[dic objectForKey:RequestSuccessMessage]];
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:[code integerValue] Info:message];
            if (failureBlock) {
                failureBlock(result);
            }
        } else {
            if (successBlock) {
                successBlock(dic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
//        //通讯协议状态码
//        NSInteger statusCode = response.statusCode;
        //服务器返回的业务逻辑报文信息
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse mj_JSONObject];
        NSString *code =[NSString stringWithFormat:@"%@",[json objectForKey:RequestFailureCode]];
        NSString *message =[NSString stringWithFormat:@"%@",[json objectForKey:RequestFailureMessage]];
        if (json==nil) {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = [NSString stringWithFormat:@"%ld",(long)error.code];
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:error.code Info:message];

            if (failureBlock) {
                failureBlock(result);
            }

        } else {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = code;
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:[code integerValue] Info:message];
            //token是否失效
            [self tokenIsInvalid:code];
            if (failureBlock) {
                failureBlock(result);
            }
        }
    }];

}


#pragma mark 文件上传(Data)
- (void)uploadFileWithUriString:(NSString *)uriString
                          files:(NSArray  *)files
                       fileName:(id)fileNames
                     parameters:(NSDictionary *)parametersDic
                  progressBlock:(void (^)(NSProgress*progress))progressBlock
                   successBlock:(void (^)(id responseObject))successBlock
                   failureBlock:(void (^)(BaseResponseData *error))failureBlock{
    [self uploadFileWithServerString:[NetWorkURL sharedInstance].environmentModel.apiUrl uriString:uriString files:files fileName:fileNames parameters:parametersDic progressBlock:progressBlock successBlock:successBlock failureBlock:failureBlock];
}
/**
 *  文件上传(Data)
 *
 *  @param serverString  服务器地址
 *  @param uriString     uri地址
 *  @param files         要上传的文件(可上传多个)
 *  @param fileNames     文件类型名称(可传一个字符串 或者一个数组)
 *  @param parameters 参数
 *  @param progressBlock 进度
 *  @param successBlock       访问成功block回调
 *  @param failureBlock       访问失败block回调
 */
- (void)uploadFileWithServerString:(NSString *)serverString
                         uriString:(NSString *)uriString
                             files:(NSArray  *)files
                          fileName:(id)fileNames
                        parameters:(NSDictionary *)parameters
                     progressBlock:(void (^)(NSProgress*progress))progressBlock
                      successBlock:(void (^)(id responseObject))successBlock
                      failureBlock:(void (^)(BaseResponseData *error))failureBlock{
    NSString * urlString = [serverString stringByAppendingString:uriString];

    UIApplication *app=[UIApplication sharedApplication];
    dispatch_async(dispatch_get_main_queue(), ^{
        app.networkActivityIndicatorVisible = YES;
    });
    parameters = [self buildCommonParameters:parameters];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //https ssl 验证。
    manager.securityPolicy = self.securityPolicy;
    
    BFDEBUG(@"上传文件\n地址:%@\n参数:%@",urlString,parameters);
    [manager POST:urlString parameters:parameters headers:[self buildHeaderDicParameters:parameters] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (files.count>0 && fileNames !=nil) {
            [files enumerateObjectsUsingBlock:^(id  _Nonnull file, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString * fileName = @"";
                if ([fileNames isKindOfClass:[NSString class]]){
                    fileName = fileNames;
                }else if ([fileNames isKindOfClass:[NSArray class]]) {
                    NSArray *fnarr = (NSArray *)fileNames;
                    if (fnarr.count == files.count) {
                        fileName = fnarr[idx];
                    } else {
                        fileName = fnarr.firstObject;
                    }
                }else {
                    fileName = @"what.jpg";
                }
                
                if ([file isKindOfClass:[UIImage class]]) {
                    UIImage *img = (UIImage *)file;
                    //这边先压缩
                    UIImage *ysImage=[img wcSessionCompress];
                    //5M
                    NSData *fileData=[BFTool resetSizeOfImageData:ysImage maxSize:(5 * 1024)];
                    BFDEBUG(@"数据大小:%ld",fileData.length);
                    NSString *fileNameLower = [fileName lowercaseString];
                    if ([fileNameLower rangeOfString:@".png"].location != NSNotFound) {
                        [formData appendPartWithFileData:fileData name:@"files" fileName:fileName mimeType:@"image/png"];
                    }else if ([fileNameLower rangeOfString:@".jpeg"].location != NSNotFound || [fileNameLower rangeOfString:@".jpg"].location != NSNotFound) {
                        [formData appendPartWithFileData:fileData name:@"files" fileName:fileName mimeType:@"image/jpeg"];
                    }else if ([fileNameLower rangeOfString:@".amr"].location != NSNotFound) {
                        [formData appendPartWithFileData:fileData name:@"files" fileName:fileName mimeType:@"audio/amr"];
                    }else if ([fileNameLower rangeOfString:@".gif"].location != NSNotFound) {
                        [formData appendPartWithFileData:fileData name:@"files" fileName:fileName mimeType:@"image/gif"];
                    }else{
                        [formData appendPartWithFileData:fileData name:@"files" fileName:fileName mimeType:@"form-data"];
                    }
                } else if ([file isKindOfClass:[NSData class]]) {
                    NSData *fileData = (NSData *)file;
                    NSString *fileNameLower = [fileName lowercaseString];
                    if ([fileNameLower rangeOfString:@".png"].location != NSNotFound) {
                        [formData appendPartWithFileData:fileData name:@"files" fileName:fileName mimeType:@"image/png"];
                    }else if ([fileNameLower rangeOfString:@".jpeg"].location != NSNotFound || [fileNameLower rangeOfString:@".jpg"].location != NSNotFound) {
                        [formData appendPartWithFileData:fileData name:@"files" fileName:fileName mimeType:@"image/jpeg"];
                    }else if ([fileNameLower rangeOfString:@".amr"].location != NSNotFound) {
                        [formData appendPartWithFileData:fileData name:@"files" fileName:fileName mimeType:@"audio/amr"];
                    }else if ([fileNameLower rangeOfString:@".gif"].location != NSNotFound) {
                        [formData appendPartWithFileData:fileData name:@"files" fileName:fileName mimeType:@"image/gif"];
                    }else if ([fileNameLower rangeOfString:@".mp4"].location != NSNotFound) {
                        [formData appendPartWithFileData:fileData name:@"files" fileName:fileName mimeType:@"video/mp4"];
                    }else{
                        [formData appendPartWithFileData:fileData name:@"files" fileName:fileName mimeType:@"form-data"];
                    }
                } else if ([file isKindOfClass:[NSString class]]) {
//                    if ([fileName rangeOfString:@".log"].location != NSNotFound) {
//                        NSString *fileName = (NSString *)file;
//
//                        NSString *path=[[NSFileManager pathUserErrorLog] stringByAppendingString:fileName];
//                        NSData *  data = [NSData dataWithContentsOfFile:path];
//                        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"text/json"];
//                    }
                }
            }];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            app.networkActivityIndicatorVisible = NO;
        });
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        BFDEBUG(@"上传文件获取到的数据:%@",dic);
        NSString *code =[NSString stringWithFormat:@"%@",[dic objectForKey:RequestSuccessCode]];
        if ([self tokenIsInvalid:code]) {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = code;
            NSString * message = [NSString stringWithFormat:@"%@",[dic objectForKey:RequestSuccessMessage]];
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:[code integerValue] Info:message];
            if (failureBlock) {
                failureBlock(result);
            }
        } else {
            if (successBlock) {
                successBlock(dic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            app.networkActivityIndicatorVisible = NO;
        });
        //服务器返回的业务逻辑报文信息
        NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSDictionary *json = [errResponse mj_JSONObject];
        NSString *code =[NSString stringWithFormat:@"%@",[json objectForKey:RequestFailureCode]];
        NSString *message =[NSString stringWithFormat:@"%@",[json objectForKey:RequestFailureMessage]];
        
        if (json==nil) {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = [NSString stringWithFormat:@"%ld",(long)error.code];;
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:error.code Info:message];

            if (failureBlock) {
                failureBlock(result);
            }
            
        } else {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = code;
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:[code integerValue] Info:message];
            //token是否失效
            [self tokenIsInvalid:result.code];
            if (failureBlock) {
                failureBlock(result);
            }
        }
    }];
}

#pragma mark 文件下载(不支持断点跟离线)
- (void)downloadFileWithUriString:(NSString *)uriString
                 fileDownloadPath:(NSString *)fileDownloadPath
                    progressBlock:(void (^)(NSProgress*progress))progressBlock
                     successBlock:(void (^)(id responseObject))successBlock
                     failureBlock:(void (^)(BaseResponseData *error))failureBlock{
    [self downloadFileWithServerString:[NetWorkURL sharedInstance].environmentModel.apiUrl uriString:uriString fileDownloadPath:fileDownloadPath progressBlock:progressBlock successBlock:successBlock failureBlock:failureBlock];
}
/**
 文件下载(不支持断点跟离线)
 需要支持断点跟离线的可参考   https://www.jianshu.com/p/01390c7a4957
 
 @param serverString  服务器地址
 @param uriString     uri地址
 @param fileDownloadPath 文件下载到本地指定路径,不传默认下载到 Documents/FileDownload
 @param progressBlock 文件下载进度
 @param successBlock 下载成功
 @param failureBlock 下载失败
 */
- (void)downloadFileWithServerString:(NSString *)serverString
                           uriString:(NSString *)uriString
                    fileDownloadPath:(NSString *)fileDownloadPath
                       progressBlock:(void (^)(NSProgress*progress))progressBlock
                        successBlock:(void (^)(id responseObject))successBlock
                        failureBlock:(void (^)(BaseResponseData *error))failureBlock{
    
    NSString * urlString = [serverString stringByAppendingString:uriString];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 1. 创建会话管理者
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    // 2. 创建下载路径和请求对象
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    /*
     用以下方法可设置超时时间
     [[NSURLRequest alloc] initWithURL:fileURL cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:timeout];
     */
    
    /* 下载到沙盒下FileDownload文件夹中 */
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/FileDownload"];
    NSString *filePath = [path stringByAppendingPathComponent:urlString.lastPathComponent];
    
    // 3.创建下载任务
    /**
     * 第一个参数 - request：请求对象
     * 第二个参数 - progress：下载进度block
     *      其中： downloadProgress.completedUnitCount：已经完成的大小
     *            downloadProgress.totalUnitCount：文件的总大小
     * 第三个参数 - destination：自动完成文件剪切操作
     *      其中： 返回值:该文件应该被剪切到哪里
     *            targetPath：临时路径 tmp NSURL
     *            response：响应头
     * 第四个参数 - completionHandler：下载完成回调
     *      其中： filePath：真实路径 == 第三个参数的返回值
     *            error:错误信息
     */
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress);
        }
        BFDEBUG(@"当前下载进度:%.2f%%",100.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        if (fileDownloadPath&&fileDownloadPath.length>0) {
            /* 设定下载到的位置 */
            return [NSURL fileURLWithPath:fileDownloadPath];
        } else {
            /* 设定下载到的位置 */
            return [NSURL fileURLWithPath:filePath];
        }
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            BaseResponseData *result = [[BaseResponseData alloc]init];
            result.code = [NSString stringWithFormat:@"%ld",(long)error.code];;
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:error.code Info:@""];

            //token是否失效
            [self tokenIsInvalid:result.code];
            if (failureBlock) {
                failureBlock(result);
            }
            
        } else {
            if (successBlock) {
                successBlock(response);
            }
            BFDEBUG(@"文件下载路径: %@", filePath);
        }
    }];
    
    // 4. 开启下载任务
    [downloadTask resume];
}

#pragma mark - 构建通用参数

- (NSMutableDictionary *)buildCommonParameters:(NSDictionary *)parametersDic {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parametersDic];

//    [dic setValue:[self getNowTimeTimestamp] forKey:@"timestamp"];

    return dic;
}
-(NSString *)getNowTimeTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}
/**
 * Head信息
 */
-(NSDictionary *)buildHeaderDicParameters:(NSDictionary *)parametersDic{
    NSMutableDictionary *headerDic = [[NSMutableDictionary alloc]init];
    //解决乱码问题
//    [headerDic setValue:@"application/x-www-form-urlencoded; charset=utf-8" forKey:@"Content-Type"];
    [headerDic setValue:[DataLibrery shareInstance].os_version forKey:@"os_version"];
//    [headerDic setValue:[DataLibrery shareInstance].curLanguageModel.serverLang forKey:@"os_language"];
    NSString *token = [DataLibrery shareInstance].loginToken;
    if (![token isNotBlank]) {
        token = @"";
    }
    [headerDic setValue:token forKey:@"token"];
    
//    [headerDic setValue:[self getSignWithCommonParameters:parametersDic] forKey:@"sign"];

    return headerDic;
}

- (NSString *)getSignWithCommonParameters:(NSDictionary *)parametersDic {
    NSMutableDictionary *mdic=[[NSMutableDictionary alloc]initWithDictionary:parametersDic];
    NSArray *keyArray = [mdic allKeys];
    NSArray *sortArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortString in sortArray) {
        [valueArray addObject:[mdic objectForKey:sortString]];
    }
    NSMutableArray *signArray = [NSMutableArray array];
    for (int i = 0; i < sortArray.count; i++) {
        NSString *keyValueStr = [NSString stringWithFormat:@"%@=%@",sortArray[i],valueArray[i]];
        [signArray addObject:keyValueStr];
    }
    NSString *sign = [signArray componentsJoinedByString:@"&"];
//    NSString *lowerCaseString2 = sign.lowercaseString;
    NSString *lowerCaseString2 = sign;
    lowerCaseString2 = [NSString stringWithFormat:@"%@&key=%@",lowerCaseString2,AppSecret];
//    NSLogDebug(@"签名前%@",lowerCaseString2);
    
    lowerCaseString2=[lowerCaseString2 md5String];
//    NSLogDebug(@"签名后%@",lowerCaseString2);
    return lowerCaseString2;
}


#pragma mark - 私有方法

- (AFSecurityPolicy*)customSecurityPolicy {
    //先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"jjnh" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
    /*
     AFSSLPinningModeNone: 代表客户端无条件地信任服务器端返回的证书。
     AFSSLPinningModePublicKey: 代表客户端会将服务器端返回的证书与本地保存的证书中，PublicKey的部分进行校验；如果正确，才继续进行。
     AFSSLPinningModeCertificate: 代表客户端会将服务器端返回的证书和本地保存的证书中的所有内容，包括PublicKey和证书部分，全部进行校验；如果正确，才继续进行。
     */
    //使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES;
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    [securityPolicy setPinnedCertificates:certSet];
    
    return securityPolicy;
}

/**
 * token 是否失效
 */
-(BOOL)tokenIsInvalid:(NSString *)code{
    //token失效
    if([code isEqualToString:BFLongInt_To_String(Server_Code_4003)]){
        if ([DataLibrery shareInstance].loginToken.length==0 && [DataLibrery shareInstance].loginUserId.length==0) {
            
        }else{
//            [[PZCManager sharedInstance]loginChangeNOAction];
        }
//        [PZCLoginRegisterViewModel saveInfo:nil];
//        //未登录
//        [[NSNotificationCenter defaultCenter] postNotificationName:GNotice_LoginChange object:@NO];
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 懒加载

- (AFSecurityPolicy *)securityPolicy {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//#if DEBUG
        //绕过https证书验证。
        _securityPolicy = [AFSecurityPolicy defaultPolicy];
        // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
        // 如果是需要验证自建证书，需要设置为YES
        _securityPolicy.allowInvalidCertificates = YES;
        //validatesDomainName 是否需要验证域名，默认为YES;
        //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
        //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
        //如置为NO，建议自己添加对应域名的校验逻辑。
        _securityPolicy.validatesDomainName = NO;
//#else
//        //https ssl 验证。
//        _securityPolicy = [self customSecurityPolicy];
//
//#endif
    });
    return _securityPolicy;
}


@end
