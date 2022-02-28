//
//  BaseTableViewModel.h
//  Demon
//
//  Created by IMAC-2 on 2022/2/24.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewModel : BaseViewModel

///  是否自动预加载下一页功能
@property (nonatomic,assign) BOOL isAutoRequestMore;
///  页面数据
@property (nonatomic,strong) NSMutableArray *dataSource;
///  当前页数
@property (nonatomic,assign) NSInteger  pageNow;
///  总页数
@property (nonatomic,assign) NSInteger  count;


/// 结束刷新
@property (nonatomic,assign) BOOL endRefreshing;
/// 刷新列表
@property (nonatomic,assign) BOOL reloadTableView;
/// 请求成功 pageNow:当前页 count:总页
@property (nonatomic,copy) void (^requestSuccessBlock)(NSInteger pageNow, NSInteger count);




/// 下拉刷新事件
-(void)refreshHeaderAction;
/// 上提刷新事件
-(void)refreshFootAction;

/// 判断是否是最后一页,是最后一页显示最后一页的数据
-(void)dataSetWithPageNow:(NSInteger )pageNow Count:(NSInteger)count;


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section ;

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;



@end

NS_ASSUME_NONNULL_END
