//
//  BaseTableViewModel.m
//  Demon
//
//  Created by IMAC-2 on 2022/2/24.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BaseTableViewModel.h"


@interface BaseTableViewModel ()

@property (nonatomic ,assign)BOOL isLoading;//判断是否在加载

@end

@implementation BaseTableViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isLoading = YES;
    }
    return self;
}





#pragma mark - 请求
//下拉刷新数据
-(void)refreshHeaderAction{
    self.isLoading = YES;
    [self refreshData];
}
//下拉 请求接口(子类在这边请求数据,请求到结果需要调dataSetWithPageNow)
-(void)refreshData{
    self.endRefreshing = YES;
}
//判断是否是最后一页,是最后一页显示最后一页的数据(当前页   总页数)
-(void)dataSetWithPageNow:(NSInteger )pageNow Count:(NSInteger)count{
    self.pageNow=pageNow;
    self.count=count;
    self.endRefreshing = YES;
    BFBlock_Safe_Calls(self.requestSuccessBlock,pageNow,count);
    self.isLoading = NO;
}
//上提刷新数据
-(void)refreshFootAction{
    if (self.pageNow==self.count) {
        self.endRefreshing = YES;
        return;
    }
    self.isLoading = YES;

    [self getMoreData];
}
//上提 请求接口(子类在这边请求数据,请求到结果需要调dataSetWithPageNow)
-(void)getMoreData{
    self.endRefreshing = YES;
}


#pragma mark - 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.accessoryType    = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text   = self.dataSource[indexPath.section];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isLoading == YES) {
        return;
    }
    if (self.isAutoRequestMore == NO) {
        return;
    }
    if (self.pageNow >= self.count) {
        return;
    }
    NSInteger ysygs = indexPath.section  * self.dataSource.count + indexPath.row;
    NSInteger zgs = 0;
    if ([self.dataSource.firstObject isKindOfClass:[NSArray class]]) {
        NSMutableArray * arr = self.dataSource.firstObject;
        zgs = self.dataSource.count * arr.count;
    }else{
        zgs = self.dataSource.count;
    }
    // 80%出现后，需要去加载数据
    if (ysygs > zgs * 0.8) {
        self.isLoading = YES;
        [self getMoreData];
    }
    
}

#pragma mark - 懒加载
-(NSMutableArray *)dataSource{
    if (_dataSource==nil) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}



@end
