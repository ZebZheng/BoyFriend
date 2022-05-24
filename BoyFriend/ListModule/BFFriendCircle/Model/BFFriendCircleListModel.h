//
//  BFFriendCircleListModel.h
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/18.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BFFriendCircleInfoModel;
@interface BFFriendCircleListModel : BaseModel

@property (nonatomic,assign) NSInteger pages; // 总页数
@property (nonatomic,assign) NSInteger current; // 当前页

@property (nonatomic,copy) NSString *total; // 总条数
@property (nonatomic,copy) NSString *size; // 每页个数

@property (nonatomic,strong) NSArray <BFFriendCircleInfoModel *> *records;

@end


@interface BFFriendCircleInfoModel : BaseModel

///// <#注释#>
//@property(nonatomic, copy) <#type#> *<#name#>;

@end


NS_ASSUME_NONNULL_END
