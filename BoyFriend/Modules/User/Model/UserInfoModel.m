//
//  UserInfoModel.m
//  Demon
//
//  Created by Apple on 2021/11/5.
//  Copyright © 2021 BoyFriend. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel



+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"userId" : @"id",
             };
}

//主键(查询的时候可通过这个参数值去查找)
+(NSString *)getPrimaryKey
{
    return @"userId";
}



//获取用户信息
+(UserInfoModel *)getUserInfoFromDB{
    NSString * userId = [DataLibrery shareInstance].loginUserId;
    
    UserInfoModel *sqlModel=[UserInfoModel searchSingleWithWhere:[NSString stringWithFormat:@"userId = '%@'", userId] orderBy:nil];

    return sqlModel;
}





@end
