//
//  BFListModuleListModel.h
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/27.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BFListModuleInfoModel;
@interface BFListModuleListModel : BaseModel

@property (nonatomic,assign) NSInteger pages; // 总页数
@property (nonatomic,assign) NSInteger current; // 当前页

@property (nonatomic,copy) NSString *total; // 总条数
@property (nonatomic,copy) NSString *size; // 每页个数

@property (nonatomic,strong) NSArray <BFListModuleInfoModel *> *records;

@end


@interface BFListModuleInfoModel : BaseModel

/// 名称
@property(nonatomic, copy) NSString *name;
/// 位置
@property(nonatomic, assign) NSInteger indexInteger;

@end


NS_ASSUME_NONNULL_END
