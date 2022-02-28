//
//  UserInfoModel.h
//  Demon
//
//  Created by Apple on 2021/11/5.
//  Copyright © 2021 BoyFriend. All rights reserved.
//

#import "BaseUserSQliteModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : BaseUserSQliteModel


@property (nonatomic,copy) NSString *accessToken; //token
@property (nonatomic,copy) NSString *userId; // ID




//获取用户信息
+(UserInfoModel *)getUserInfoFromDB;




@end

NS_ASSUME_NONNULL_END
