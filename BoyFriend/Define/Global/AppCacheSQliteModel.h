//
//  AppCacheSQliteModel.h
//  Demon
//
//  Created by apple on 2021/2/7.
//  Copyright © 2021 BoyFriend. All rights reserved.
//  APP缓存本地的信息

#import "BaseSQliteModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppCacheSQliteModel : BaseSQliteModel


/**
 * 主键
 */
@property (nonatomic, copy) NSString * zid;

//==================== 用户信息相关 ====================
// 用户token
@property (nonatomic, copy) NSString *token;
// 用户id
@property (nonatomic, copy) NSString *loginUserId;



//获取APP缓存信息
+(AppCacheSQliteModel *)getAppCacheSQLInfoFromDB;

@end

NS_ASSUME_NONNULL_END
