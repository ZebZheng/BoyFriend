//
//  BFLinkageTTModel.h
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/29.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BFFoodModel;
@interface BFLinkageTTModel : BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray<BFFoodModel *> *spus;

@end



@interface BFFoodModel : BaseModel


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *foodId;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, assign) NSInteger praise_content;
@property (nonatomic, assign) NSInteger month_saled;
@property (nonatomic, assign) float min_price;


@end



NS_ASSUME_NONNULL_END
