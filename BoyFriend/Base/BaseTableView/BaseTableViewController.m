//
//  BaseTableViewController.m
//  Demon
//
//  Created by apple on 2019/1/30.
//  Copyright © 2019年 BoyFriend. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

#pragma mark - Lifecycle
-(instancetype)init{
    if (self=[super init]) {
        self.tableViewStyle = UITableViewStylePlain;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeViewB];
    [self initializeViewDataB];
    [self bindControlEventB];
}

#pragma mark - init
/**** 视图初始化 ****/
-(void)initializeViewB{
    self.view.backgroundColor = BFRGB_BgColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    if (@available(iOS 15.0, *)) {
#ifdef __IPHONE_15_0
        self.tableView.sectionHeaderTopPadding = 0;
#endif

    }
}
/**** 数据初始化 ****/
-(void)initializeViewDataB{
    
}
/**** 事件绑定 ****/
-(void)bindControlEventB{
    @weakify(self);
    [RACObserve(self.tableViewModel, endRefreshing) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    [RACObserve(self.tableViewModel, reloadTableView) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    [self.tableViewModel setRequestSuccessBlock:^(NSInteger pageNow, NSInteger count) {
        @strongify(self);
        if (pageNow == count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer resetNoMoreData];
        }
    }];
}
#pragma mark - UI


#pragma mark - IBActions/Event Response


#pragma mark - Data
//下拉刷新事件
-(void)refreshHeaderAction{
    [self.tableViewModel refreshHeaderAction];
}

//上提刷新事件
-(void)refreshFootAction{
    [self.tableViewModel refreshFootAction];
}

#pragma mark - logical processing（逻辑处理）


#pragma mark - Notification


#pragma mark - Protocol conformance
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableViewModel numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableViewModel tableView:tableView numberOfRowsInSection:section];
}

//- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return [self.tableViewModel tableView:tableView heightForHeaderInSection:section];
//}
//
//- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return [self.tableViewModel tableView:tableView heightForFooterInSection:section];
//}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return [self.tableViewModel tableView:tableView viewForFooterInSection:section];
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return [self.tableViewModel tableView:tableView viewForHeaderInSection:section];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.tableViewModel tableView:tableView cellForRowAtIndexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableViewModel tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

#pragma mark - Getter Setter
- (BaseTableView *)tableView {
    if (!_tableView) {
        CGRect tableViewFrame = self.view.bounds;
        _tableView = [[BaseTableView alloc] initWithFrame:tableViewFrame style:self.tableViewStyle];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets=NO;
        }

        _tableView.delegate = self;
        _tableView.dataSource = self;
        @weakify(self);
        [_tableView setRefreshHeaderBlock:^{
            @strongify(self);
            [self refreshHeaderAction];
        }];
        [_tableView setRefreshFooterBlock:^{
            @strongify(self);
            [self refreshFootAction];
        }];

    }
    return _tableView;
}

- (void)setIsUseRefreshHeader:(BOOL)isUseRefreshHeader{
    _isUseRefreshHeader = isUseRefreshHeader;
    self.tableView.isUseRefreshHeader = isUseRefreshHeader;
}
- (void)setIsUseRefreshFooter:(BOOL)isUseRefreshFooter{
    _isUseRefreshFooter = isUseRefreshFooter;
    self.tableView.isUseRefreshFooter = isUseRefreshFooter;
}
- (void)setIsAutoRequestMore:(BOOL)isAutoRequestMore{
    _isAutoRequestMore = isAutoRequestMore;
    self.tableViewModel.isAutoRequestMore = isAutoRequestMore;
}

-(BaseTableViewModel *)tableViewModel{
    if (!_tableViewModel) {
        _tableViewModel=[[BaseTableViewModel alloc]init];
    }
    return _tableViewModel;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
