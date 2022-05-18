//
//  BFLinkageTTViewController.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/29.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFLinkageTTViewController.h"

#import "BFLinkageTTHeadView.h"
#import "BFLinkageTTLeftTableViewCell.h"
#import "BFLinkageTTRightTableViewCell.h"

#import "BFLinkageTTViewModel.h"

#import "BFLinkageTTModel.h"

static float kLeftTableViewWidth = 80.f;

@interface BFLinkageTTViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) BFLinkageTTViewModel *productViewModel;

@property (nonatomic, strong) NSMutableArray *categoryDataArray;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@end

@implementation BFLinkageTTViewController
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
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
}
/**** 数据初始化 ****/
-(void)initializeViewData{
    _selectIndex = 0;
    _isScrollDown = YES;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"meituan" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *foods = dict[@"data"][@"food_spu_tags"];
    
    for (NSDictionary *dict in foods){
        BFLinkageTTModel *model = [BFLinkageTTModel mj_objectWithKeyValues:dict];
        [self.categoryDataArray addObject:model];
    }
}
/**** 事件绑定 ****/
-(void)bindControlEvent{
    
}


#pragma mark - function


#pragma mark - logical processing（逻辑处理）

// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index{
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - Data


#pragma mark - Event Response / IBActions


#pragma mark - Protocol / delegat
#pragma mark - TableView DataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_leftTableView == tableView){
        return 1;
    }else{
        return self.categoryDataArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_leftTableView == tableView){
        return self.categoryDataArray.count;
    }else{
        BFLinkageTTModel *model = self.categoryDataArray[section];
        return [model.spus count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_leftTableView == tableView){
        BFLinkageTTLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BFLinkageTTLeftTableViewCell bf_reuseIdentifier] forIndexPath:indexPath];
        BFLinkageTTModel *model = self.categoryDataArray[indexPath.row];
        [cell bf_setupWithData:model.name];
        return cell;
    }else{
        BFLinkageTTRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BFLinkageTTRightTableViewCell bf_reuseIdentifier] forIndexPath:indexPath];
        BFLinkageTTModel *lmodel = self.categoryDataArray[indexPath.section];
        BFFoodModel *model = lmodel.spus[indexPath.row];
        [cell bf_setupWithData:model];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView)
    {
        return 20;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_rightTableView == tableView){
        BFLinkageTTHeadView *view = [[BFLinkageTTHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - kLeftTableViewWidth, 20)];
        BFLinkageTTModel *model = self.categoryDataArray[section];
        [view bf_setupWithData:model.name];
        return view;
    }
    return nil;
}

// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView)
        && !_isScrollDown
        && (_rightTableView.dragging || _rightTableView.decelerating)){
        [self selectRowAtIndexPath:section];
    }
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView)
        && _isScrollDown
        && (_rightTableView.dragging || _rightTableView.decelerating)){
        [self selectRowAtIndexPath:section + 1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (_leftTableView == tableView){
        _selectIndex = indexPath.row;
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }
}


#pragma mark - UISrcollViewDelegate
// 标记一下RightTableView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static CGFloat lastOffsetY = 0;

    UITableView *tableView = (UITableView *) scrollView;
    if (_rightTableView == tableView){
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

#pragma mark - Notification


#pragma mark - Setter


#pragma mark - Getter
- (BFLinkageTTViewModel *)productViewModel {
    if (!_productViewModel) {
        _productViewModel = BFLinkageTTViewModel.alloc.init;
    }
    return _productViewModel;
}

- (NSMutableArray *)categoryDataArray{
    if (!_categoryDataArray) {
        _categoryDataArray = [NSMutableArray array];
    }
    return _categoryDataArray;
}

- (UITableView *)leftTableView{
    if (!_leftTableView){
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, SCREEN_HEIGHT)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 55;
        _leftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        [_leftTableView registerClass:[BFLinkageTTLeftTableViewCell class] forCellReuseIdentifier:[BFLinkageTTLeftTableViewCell bf_reuseIdentifier]];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView{
    if (!_rightTableView){
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kLeftTableViewWidth, 0, SCREEN_WIDTH - kLeftTableViewWidth, SCREEN_HEIGHT)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 80;
        _rightTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView registerClass:[BFLinkageTTRightTableViewCell class] forCellReuseIdentifier:[BFLinkageTTRightTableViewCell bf_reuseIdentifier]];
    }
    return _rightTableView;
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
