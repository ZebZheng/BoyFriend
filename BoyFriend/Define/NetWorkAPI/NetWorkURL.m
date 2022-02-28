//
//  NetWorkURL.m
//  Demon
//
//  Created by BoyFriend on 16/2/16.
//  Copyright © 2016年 BoyFriend. All rights reserved.
//

#import "NetWorkURL.h"

@interface NetWorkURL ()

@end

@implementation NetWorkURL

+ (NetWorkURL *)sharedInstance{
    static NetWorkURL *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetWorkURL alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSInteger apiType = [[BFUserDefaults objectForKey:@"APIType"] integerValue];
        NetWorkEnvironment * model = [[NetWorkEnvironment sharedInstance] getNetWorkEnvironmentModelWithType:apiType];
        _environmentModel = model;
        [BFUserDefaults setInteger:model.environmentType forKey:@"APIType"];

    }
    return self;
}



//获取图片完整路径
- (NSString *)getImageFullUrl:(NSString *)string {
    //判断路径
    if ([string hasPrefix:@"http"]) {
        return string;
    }else{
        //判断路径
        if (![string hasPrefix:@"/"]) {
            string = [NSString stringWithFormat:@"/%@",string];
        }
        return [self.environmentModel.lookImageUrl stringByAppendingString:string];
    }
}

/**
 * 获取错误信息
 */
- (NSString *)getServerErrorWithCode:(NSInteger )code Info:(NSString *)info {
    NSString * str = info;
    switch (code) {
        case 0:
            str = @"成功";
            break;
        case Server_Code_Minus1:
            str = @"服务端请求异常";
            break;
        case Server_Code_Minus1009:
            str = @"网络异常，请检查网络";
            break;
        case Server_Code_4003:
            str = @"";//token 失效先不弹提示语
            break;
        default:
//            str = info;
            break;
    }
    return str;
}


@end
