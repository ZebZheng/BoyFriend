//
//  UserViewModel.m
//  Demon
//
//  Created by Apple on 2021/11/5.
//  Copyright © 2021 BoyFriend. All rights reserved.
//

#import "UserViewModel.h"

@implementation UserViewModel

/**
 * 保存信息(登录成功 传model  退出登录  传nil)
 */
+(void)saveInfo:(UserInfoModel *)userInfo{
    NSString * userId = @"";
    NSString * token = @"";
    
    if (userInfo != nil) {
        userId = userInfo.userId;
        token = userInfo.accessToken;
    }else{
        //已经清空了 就不再重复执行
        if ([DataLibrery shareInstance].loginToken.length == 0) {
            return;
        }
    }
    [[DataLibrery shareInstance] setCacheToken:token UserId:userId];
    
    AppCacheSQliteModel * sqlitModel = [AppCacheSQliteModel getAppCacheSQLInfoFromDB];
    if (sqlitModel == nil) {
        sqlitModel = [[AppCacheSQliteModel alloc]init];
    }
    sqlitModel.token = token;
    sqlitModel.loginUserId = userId;
    [sqlitModel saveToDB];
    if (userInfo != nil) {
        //要放在后面 因为数据库的文件需要先知道缓存用户ID才能保存数据
        [userInfo saveToDB];
    }


}
@end
