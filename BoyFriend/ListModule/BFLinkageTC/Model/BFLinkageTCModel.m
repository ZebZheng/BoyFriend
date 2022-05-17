//
//  BFLinkageTCModel.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/29.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFLinkageTCModel.h"

@implementation BFLinkageTCModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"subcategories" : [BFSubCategoryModel class]};
}

@end

@implementation BFSubCategoryModel

@end
