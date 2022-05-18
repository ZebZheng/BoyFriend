//
//  BFLinkageTCModel.h
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/29.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BFSubCategoryModel;
@interface BFLinkageTCModel : BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray <BFSubCategoryModel *>*subcategories;

@end


@interface BFSubCategoryModel : BaseModel

@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *name;

@end


NS_ASSUME_NONNULL_END
