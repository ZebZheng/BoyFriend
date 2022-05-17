//
//  BFLinkageTCViewController.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/29.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFLinkageTCViewController.h"

#import "BFLinkageTCCollectionViewHeaderView.h"
#import "BFLinkageTCLeftTableViewCell.h"
#import "BFLinkageTCRightCollectionViewCell.h"

#import "BFLinkageTCViewModel.h"

#import "BFCollectionViewFlowLayout.h"
#import "BFLinkageTCModel.h"


static float kLeftTableViewWidth = 80.f;
static float kCollectionViewMargin = 3.f;

@interface BFLinkageTCViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong) BFLinkageTCViewModel *productViewModel;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) BFCollectionViewFlowLayout *flowLayout;

@end

@implementation BFLinkageTCViewController

{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self=[super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeView];
    [self initializeViewData];
    [self bindControlEvent];
    
}

#pragma mark - init
/**** 视图初始化 ****/
-(void)initializeView{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
}
/**** 数据初始化 ****/
-(void)initializeViewData{
    _selectIndex = 0;
    _isScrollDown = YES;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"liwushuo" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *categories = dict[@"data"][@"categories"];
    for (NSDictionary *dict in categories){
        BFLinkageTCModel *model =
            [BFLinkageTCModel mj_objectWithKeyValues:dict];
        [self.dataSource addObject:model];
    }

    [self.tableView reloadData];
    [self.collectionView reloadData];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionNone];
}
/**** 事件绑定 ****/
-(void)bindControlEvent{
    
}


#pragma mark - function


#pragma mark - logical processing（逻辑处理）
// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

// 解决点击 TableView 后 CollectionView 的 Header 遮挡问题
- (void)scrollToTopOfSection:(NSInteger)section animated:(BOOL)animated{
    CGRect headerRect = [self frameForHeaderForSection:section];
    CGPoint topOfHeader = CGPointMake(0, headerRect.origin.y - _collectionView.contentInset.top);
    [self.collectionView setContentOffset:topOfHeader animated:animated];
}

- (CGRect)frameForHeaderForSection:(NSInteger)section{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    return attributes.frame;
}

#pragma mark - Data


#pragma mark - Event Response / IBActions


#pragma mark - Protocol / delegat
#pragma mark - UITableView DataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFLinkageTCLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BFLinkageTCLeftTableViewCell bf_reuseIdentifier] forIndexPath:indexPath];
    BFLinkageTCModel *model = self.dataSource[indexPath.row];
    [cell bf_setupWithData:model.name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.row;
    // 解决点击 TableView 后 CollectionView 的 Header 遮挡问题。
    [self scrollToTopOfSection:_selectIndex animated:YES];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop animated:YES];
}



#pragma mark - UICollectionView DataSource Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    BFLinkageTCModel *model = self.dataSource[section];
    return model.subcategories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BFLinkageTCRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BFLinkageTCRightCollectionViewCell bf_reuseIdentifier] forIndexPath:indexPath];
    BFLinkageTCModel *lmodel = self.dataSource[indexPath.section];
    BFSubCategoryModel *model = lmodel.subcategories[indexPath.row];
    [cell bf_setupWithData:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - kLeftTableViewWidth - 4 * kCollectionViewMargin) / 3,
                      (SCREEN_WIDTH - kLeftTableViewWidth - 4 * kCollectionViewMargin) / 3 + 30);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){ // header
        reuseIdentifier = [BFLinkageTCCollectionViewHeaderView bf_reuseIdentifier];
    }
    BFLinkageTCCollectionViewHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                        withReuseIdentifier:reuseIdentifier
                                                                               forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        BFLinkageTCModel *model = self.dataSource[indexPath.section];
        [view bf_setupWithData:model.name];
    }
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 30);
}

// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    // 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && (collectionView.dragging || collectionView.decelerating)){
        [self selectRowAtIndexPath:indexPath.section];
    }
}

// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath{
    // 当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (_isScrollDown && (collectionView.dragging || collectionView.decelerating)){
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}



#pragma mark - UIScrollView Delegate
// 标记一下CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static float lastOffsetY = 0;

    if (self.collectionView == scrollView){
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}


#pragma mark - Notification


#pragma mark - Setter


#pragma mark - Getter

- (BFLinkageTCViewModel *)productViewModel {
    if (!_productViewModel) {
        _productViewModel = BFLinkageTCViewModel.alloc.init;
    }
    return _productViewModel;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource){
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (UITableView *)tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 55;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[BFLinkageTCLeftTableViewCell class] forCellReuseIdentifier:[BFLinkageTCLeftTableViewCell bf_reuseIdentifier]];
    }
    return _tableView;
}

- (BFCollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout){
        _flowLayout = [[BFCollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumInteritemSpacing = 2;
        _flowLayout.minimumLineSpacing = 2;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView{
    if (!_collectionView){
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kCollectionViewMargin + kLeftTableViewWidth, kCollectionViewMargin, SCREEN_WIDTH - kLeftTableViewWidth - 2 * kCollectionViewMargin, SCREEN_HEIGHT - 2 * kCollectionViewMargin) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册cell
        [_collectionView registerClass:[BFLinkageTCRightCollectionViewCell class] forCellWithReuseIdentifier:[BFLinkageTCRightCollectionViewCell bf_reuseIdentifier]];
        //注册分区头标题
        [_collectionView registerClass:[BFLinkageTCCollectionViewHeaderView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:[BFLinkageTCCollectionViewHeaderView bf_reuseIdentifier]];
    }
    return _collectionView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
