//
//  BFMineViewModel.h
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/24.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTableViewModel.h"
#import "BFTableMenuCell.h"
#import "BFTableMenuItem.h"



NS_ASSUME_NONNULL_BEGIN

@interface BFMineSettingViewModel : BaseTableViewModel


/// 点击回调
@property (nonatomic,copy) void (^didSelectRowBlock)(BFTableMenuItem * infoModel);

///初始化数据
- (void)initializeMineData;

@end

NS_ASSUME_NONNULL_END
