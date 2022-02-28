//
//  BaseTableView.h
//  Demon
//
//  Created by IMAC-2 on 2022/2/24.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableView : UITableView


/**** 是否使用下拉刷新功能 ****/
@property (nonatomic) BOOL isUseRefreshHeader;
/**** 是否使用上提刷新功能 ****/
@property (nonatomic) BOOL isUseRefreshFooter;

/// 下拉刷新事件
@property (nonatomic,copy) void (^refreshHeaderBlock)(void);

/// 上提刷新事件
@property (nonatomic,copy) void (^refreshFooterBlock)(void);


@end

NS_ASSUME_NONNULL_END
