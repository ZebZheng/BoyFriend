//
//  BFListModuleListModel.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/27.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFListModuleListModel.h"

@implementation BFListModuleListModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"records" : [BFListModuleInfoModel class]};
}

@end

@implementation BFListModuleInfoModel

@end

