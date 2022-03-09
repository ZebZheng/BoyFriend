//
//  BaseUserSQliteModel.h
//  Demon
//
//  Created by apple on 2021/2/7.
//  Copyright © 2021 BoyFriend. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseUserSQliteModel : BaseModel


// 用户id (主键  继承BaseUserSQliteModel )
@property (nonatomic, copy) NSString *loginUserId;

+ (void)tearDown;


@end

NS_ASSUME_NONNULL_END
