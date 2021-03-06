//
//  BaseTableViewController.h
//  Demon
//
//  Created by apple on 2019/1/30.
//  Copyright © 2019年 BoyFriend. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableView.h"
#import "BaseTableViewModel.h"

@interface BaseTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

/**
 *  初始化init的时候设置tableView的样式才有效
    (默认UITableViewStyleGrouped)
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@property (nonatomic, strong) BaseTableView *tableView;

@property (nonatomic, strong) BaseTableViewModel *tableViewModel;

/**** 是否使用下拉刷新功能 ****/
@property (nonatomic) BOOL isUseRefreshHeader;
/**** 是否使用上提刷新功能 ****/
@property (nonatomic) BOOL isUseRefreshFooter;
/**** 是否自动预加载下一页功能 ****/
@property (nonatomic) BOOL isAutoRequestMore;
/****是否需要分页请求 ****/
@property(nonatomic, assign) BOOL isNeedPaging;

/// 绑定事件  给tableViewModel 赋值
-(void)bindControlEventViewModel:(BaseTableViewModel *)tableViewModel;

///下拉刷新事件
-(void)refreshHeaderAction;






@end
