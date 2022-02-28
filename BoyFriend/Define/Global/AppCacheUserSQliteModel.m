//
//  AppCacheUserSQliteModel.m
//  Demon
//
//  Created by apple on 2021/2/7.
//  Copyright © 2021 BoyFriend. All rights reserved.
//

#import "AppCacheUserSQliteModel.h"

@implementation AppCacheUserSQliteModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.loginUserId = [DataLibrery shareInstance].loginUserId;

    }
    return self;
}

//主键(查询的时候可通过这个参数值去查找,父类有该字段)
+(NSString *)getPrimaryKey{
    return @"loginUserId";
}
// 映射 父类到数据库
+ (BOOL)isContainParent {
    return YES;
}



//获取缓存信息
+(AppCacheUserSQliteModel *)getAppCacheUserSQliteModelFromDB{
    NSString * userId = [DataLibrery shareInstance].loginUserId;
    
    AppCacheUserSQliteModel *sqlModel=[AppCacheUserSQliteModel searchSingleWithWhere:[NSString stringWithFormat:@"loginUserId = '%@'", userId] orderBy:nil];

    return sqlModel;
}

@end
