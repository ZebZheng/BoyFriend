//
//  BFListModuleViewModel.h
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/27.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTableViewModel.h"
#import "BFListModuleListModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface BFListModuleViewModel : BaseTableViewModel


/// 点击回调
@property (nonatomic,copy) void (^didSelectRowBlock)(BFListModuleInfoModel * infoModel);


@end

NS_ASSUME_NONNULL_END
