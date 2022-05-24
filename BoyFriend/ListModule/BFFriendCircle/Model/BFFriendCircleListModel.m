//
//  BFFriendCircleListModel.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/18.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFFriendCircleListModel.h"

@implementation BFFriendCircleListModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"records" : [BFFriendCircleInfoModel class]};
}

@end

@implementation BFFriendCircleInfoModel

@end

