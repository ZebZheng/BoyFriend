//
//  BFListViewController.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/11.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFListViewController.h"
#import "BFListView.h"
#import "BFListViewModel.h"


@interface BFListViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong) BFListView *productView;
@property (nonatomic,strong) SDCycleScrollView * sdCycleScrollView;
@property (nonatomic,strong) SDCycleScrollView * sdTitleScrollView;

@property (nonatomic,strong) BFListViewModel *productViewModel;

@end

@implementation BFListViewController
#pragma mark - Lifecycle
-(instancetype)init{
    if (self=[super init]) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /** 解决viewWillAppear时出现时轮播图卡在一半的问题，在控制器viewWillAppear时调用此方法 */
    [self.sdCycleScrollView adjustWhenControllerViewWillAppera];
    [self.sdTitleScrollView adjustWhenControllerViewWillAppera];

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
//    self.view.backgroundColor = BFRandomColor;
    self.sdCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    self.sdCycleScrollView.backgroundColor = BFRGB_BgColor;
    self.sdCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.sdCycleScrollView.pageControlRightOffset = -BFRatio(30);
    [self.view addSubview:self.sdCycleScrollView];
    [self.sdCycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(BFRatio(220));
    }];
    
    
    self.sdTitleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, BFRatio(300), BFScreen_Width, BFRatio(40)) delegate:self placeholderImage:nil];
    self.sdTitleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sdTitleScrollView.onlyDisplayText = YES;
    [self.view addSubview:self.sdTitleScrollView];

}
/**** 数据初始化 ****/
-(void)initializeViewData{
    NSArray *imagesURLStrings = @[
                           @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                           @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                           @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                           ];
    NSArray *titles = @[@"标题1",
                        @"标题2",
                        @"标题3",
                        ];
    self.sdCycleScrollView.imageURLStringsGroup = imagesURLStrings;
    self.sdCycleScrollView.titlesGroup = titles;
    
    self.sdTitleScrollView.titlesGroup =[titles copy];
    [self.sdTitleScrollView disableScrollGesture];

}
/**** 事件绑定 ****/
-(void)bindControlEvent{
    
}


#pragma mark - function


#pragma mark - logical processing（逻辑处理）


#pragma mark - Data


#pragma mark - Event Response / IBActions


#pragma mark - Protocol / delegat
- (UIView *)listView {
    return self.view;
}
#pragma mark -  SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}


#pragma mark - Notification


#pragma mark - Setter


#pragma mark - Getter
- (BFListView *)productView {
    if (!_productView) {
        _productView = [BFListView.alloc init];
    }
    return _productView;
}
- (BFListViewModel *)productViewModel {
    if (!_productViewModel) {
        _productViewModel = BFListViewModel.alloc.init;
    }
    return _productViewModel;
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
