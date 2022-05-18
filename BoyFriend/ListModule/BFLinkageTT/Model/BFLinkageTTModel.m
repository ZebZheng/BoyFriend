//
//  BFLinkageTTModel.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/29.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFLinkageTTModel.h"

@implementation BFLinkageTTModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"spus" : [BFFoodModel class]};
}

@end



@implementation BFFoodModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"foodId" : @"id",
    };
}

@end
