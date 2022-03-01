//
//  NetWorkEnvironment.m
//  DriftingBottle
//
//  Created by IMAC-2 on 2021/11/17.
//  Copyright © 2021 Apple. All rights reserved.
//

#import "NetWorkEnvironment.h"

@interface NetWorkEnvironment ()

@end

@implementation NetWorkEnvironment

+ (NetWorkEnvironment *)sharedInstance{
    static NetWorkEnvironment *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetWorkEnvironment alloc] init];
    });
    return instance;
}

/**
 * 环境数组
 */
-(NetWorkEnvironment *)getNetWorkEnvironmentModelWithType:(NSInteger)type{
    NSArray * array = self.environmentArray;

    if(BFISEnable_Switch_Environment){
        for (NetWorkEnvironment * model in array) {
            if(model.environmentType == type){
                return model;
            }
        }
        return array.firstObject;
    }else{
        return array.firstObject;
    }

}

- (NSString *)environmentString{
    if (_environmentString.length>0) {
        return _environmentString;
    }else{
        return _apiUrl;
    }
}

- (NSArray *)environmentArray{
    if (_environmentArray == nil) {
        _environmentArray =[self getNetWorkEnvironmentArray];
        return _environmentArray;
    } else {
        return _environmentArray;
    }
}




/**
 * 环境数组
 */
-(NSArray *)getNetWorkEnvironmentArray{
    //这个为正式环境的  当开关关掉的时候 直接取这个的地址 位置需要放在第一个
    NetWorkEnvironment * model = [[NetWorkEnvironment alloc]init];
    model.environmentType = 0;
    model.environmentString = @"生产环境";
    model.apiUrl = @"http://192.168.1.81:180";
    model.h5Url = @"";
    model.lookImageUrl = @"";
    
    NetWorkEnvironment * model1 = [[NetWorkEnvironment alloc]init];
    model1.environmentType = 1;
    model1.environmentString = @"开发环境";
    model1.apiUrl = @"http://192.168.1.82:180";
    model1.h5Url = @"";
    model1.lookImageUrl = @"";
    
    NetWorkEnvironment * model2 = [[NetWorkEnvironment alloc]init];
    model2.environmentType = 2;
    model2.environmentString = @"";
    model2.apiUrl = @"http://192.168.1.83:180";
    model2.h5Url = @"";
    model2.lookImageUrl = @"";
    
    if(BFISEnable_Switch_Environment){
        return @[model,model1,model2];
    }else{
        return @[model];
    }
}




@end
