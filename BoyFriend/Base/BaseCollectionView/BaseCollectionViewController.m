//
//  BaseCollectionViewController.m
//  Demon
//
//  Created by apple on 2020/2/15.
//  Copyright © 2020 BoyFriend. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController

#pragma mark - Lifecycle
-(instancetype)init {
    if (self=[super init]) {
        self.scrollDirection=UICollectionViewScrollDirectionVertical;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeViewB];
    [self initializeViewDataB];
}

#pragma mark - init
/**** 视图初始化 ****/
-(void)initializeViewB {
    self.view.backgroundColor = BFRGB_BgColor;
    [self.view addSubview:self.collectionView];
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    } else {
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view.mas_bottomMargin);
        }];
    }

    
}
/**** 数据初始化 ****/
-(void)initializeViewDataB {
    
}
/**** 事件绑定 ****/
#pragma mark - UI

- (void)bindControlEventViewModel:(BaseCollectionViewModel *)collectionViewModel {
    self.collectionViewModel = collectionViewModel;
    @weakify(self);
    [RACObserve(self.collectionViewModel, endRefreshing) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
    [RACObserve(self.collectionViewModel, reloadCollectionView) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            [self.collectionView reloadData];
        }
    }];
    [self.collectionViewModel setRequestSuccessBlock:^(NSInteger pageNow, NSInteger count) {
        @strongify(self);
        if (pageNow == count) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.collectionView.mj_footer resetNoMoreData];
        }
    }];
    [self.collectionViewModel setPlaceholderBlock:^(BOOL isShowPlaceHold, BFPlaceholderViewType placeholderViewType, BOOL isNeedReload) {
        @strongify(self);
        if (isShowPlaceHold) {
            [self.collectionView bf_showPlaceholderViewWithType:placeholderViewType reloadBlock:^{
                @strongify(self);
                if (isNeedReload) {
                    [self  refreshHeaderAction];
                }
            }];
        }else{
            [self.collectionView bf_removePlaceholderView];
        }
    }];
    self.collectionViewModel.isAutoRequestMore = self.isAutoRequestMore;
    self.collectionViewModel.isNeedPaging = self.isNeedPaging;
    self.collectionView.isUseRefreshHeader = self.isUseRefreshHeader;
    self.collectionView.isUseRefreshFooter = self.isUseRefreshFooter;
}

#pragma mark - IBActions/Event Response


#pragma mark - Data
//下拉刷新事件
-(void)refreshHeaderAction {
    [self.collectionViewModel refreshHeaderAction];
}

//上提刷新事件
-(void)refreshFootAction {
    [self.collectionViewModel refreshFootAction];
}

#pragma mark - logical processing（逻辑处理）


#pragma mark - Notification


#pragma mark - Protocol conformance
#pragma mark UICollectionViewDataSource
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.collectionViewModel numberOfSectionsInCollectionView:collectionView];
}
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.collectionViewModel collectionView:collectionView numberOfItemsInSection:section];
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.collectionViewModel collectionView:collectionView cellForItemAtIndexPath:indexPath];
}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return [self.collectionViewModel collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
}
//对头视图或者尾视图进行设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return [self.collectionViewModel collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
}
//定义每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.collectionViewModel collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return [self.collectionViewModel collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return [self.collectionViewModel collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
}
//每个section中不同的item之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return [self.collectionViewModel collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.collectionViewModel collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.collectionViewModel collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
    
}
#pragma mark - Getter Setter
- (BaseCollectionView *)collectionView {
    if (!_collectionView) {
        CGRect collectionFrame = self.view.bounds;
        
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:self.scrollDirection];//垂直滚动
        
        _collectionView = [[BaseCollectionView alloc] initWithFrame:collectionFrame collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        @weakify(self);
        [_collectionView setRefreshHeaderBlock:^{
            @strongify(self);
            [self refreshHeaderAction];
        }];
        [_collectionView setRefreshFooterBlock:^{
            @strongify(self);
            [self refreshFootAction];
        }];

    }
    return _collectionView;
}

-(BaseCollectionViewModel *)collectionViewModel{
    if (!_collectionViewModel) {
        _collectionViewModel=[[BaseCollectionViewModel alloc]init];
    }
    return _collectionViewModel;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
