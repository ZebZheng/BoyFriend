//
//  BFFriendCircleCell.h
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/18.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BFFriendCircleListModel.h"
#import "BFFriendCircleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BFFriendCircleCell : BaseTableViewCell

@property (nonatomic, copy) void (^moreButtonClickedBlock)(void);

@property (nonatomic,copy) void (^tapImageViewBlock)(NSArray *resourceArray , NSInteger tag );

@end

NS_ASSUME_NONNULL_END
