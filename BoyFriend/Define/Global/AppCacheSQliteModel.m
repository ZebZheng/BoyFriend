//
//  AppCacheSQliteModel.m
//  Demon
//
//  Created by apple on 2021/2/7.
//  Copyright © 2021 BoyFriend. All rights reserved.
//

#import "AppCacheSQliteModel.h"

@implementation AppCacheSQliteModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.zid=@"zid";
    }
    return self;
}

//主键(查询的时候可通过这个参数值去查找)
+(NSString *)getPrimaryKey{
    return @"zid";
}

//获取APP缓存信息
+(AppCacheSQliteModel *)getAppCacheSQLInfoFromDB{
    
    AppCacheSQliteModel *sqlModel=[AppCacheSQliteModel searchSingleWithWhere:nil orderBy:nil];

    return sqlModel;
}


@end
