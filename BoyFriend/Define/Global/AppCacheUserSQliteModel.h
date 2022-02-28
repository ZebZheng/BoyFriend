//
//  AppCacheUserSQliteModel.h
//  Demon
//
//  Created by apple on 2021/2/7.
//  Copyright © 2021 BoyFriend. All rights reserved.
//  APP缓存本地的信息(跟用户挂钩)

#import "BaseUserSQliteModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppCacheUserSQliteModel : BaseUserSQliteModel

//获取缓存信息
+(AppCacheUserSQliteModel *)getAppCacheUserSQliteModelFromDB;

@end

NS_ASSUME_NONNULL_END
