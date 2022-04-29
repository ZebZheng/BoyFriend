//
//  BFJXCategorySegmentedViewController.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/11.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFJXCategorySegmentedViewController.h"
#import "BFJXCategoryViewController.h"

#import <JXCategoryView/JXCategoryView.h>

@interface BFJXCategorySegmentedViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, assign) NSInteger  categoryIndex;


@end

@implementation BFJXCategorySegmentedViewController

#pragma mark - Lifecycle
-(instancetype)init {
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
-(void)initializeView {
    self.view.backgroundColor = [UIColor whiteColor];
//    self.bf_prefersNavigationBarHidden = YES;
    self.bf_navigationBarLineHidden = YES;
    CGFloat categoryViewHeight = BFNavBarHeight;
    CGFloat listContainerViewY = self.isAddInNavigation? 0 : BFNavBarHeight;
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
//    self.listContainerView.frame = CGRectMake(0, BFNavBarHeight+BFStatusHeight, BFScreen_Width, BFScreen_Height-BFNavBarHeight-BFStatusHeight - BFTabBarHeight - BFBottomHeight);
    self.listContainerView.frame = CGRectMake(0, listContainerViewY, BFScreen_Width, BFScreen_Height-BFNavBarHeight-BFStatusHeight-listContainerViewY);
    self.listContainerView.backgroundColor = UIColor.whiteColor;
//    self.listContainerView.scrollView.scrollEnabled = NO;

    [self.view addSubview:self.listContainerView];

    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.listContainer = self.listContainerView;
    self.categoryView.frame = CGRectMake(0, 0, self.isAddInNavigation?SCREEN_WIDTH - 120:SCREEN_WIDTH , categoryViewHeight);
    self.categoryView.titles = @[@"列表1", @"列表2"];
    self.categoryView.delegate = self;
    self.categoryView.averageCellSpacingEnabled = self.averageWidthEnabled;
    self.categoryView.cellSpacing = BFRatio(30);
    self.categoryView.titleFont = BFPFSBFontWithSizes(15);
    self.categoryView.titleSelectedFont = BFPFSBFontWithSizes(17);
    self.categoryView.titleColor = BFRGB_FontColor;
    self.categoryView.titleSelectedColor = BFTheme_Color;
    self.categoryView.backgroundColor = UIColor.whiteColor;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorHeight = BFRatio(2);
    lineView.indicatorWidth = BFRatio(25);
    lineView.indicatorWidthIncrement = 0;
    lineView.indicatorColor = BFTheme_Color;
    self.categoryView.indicators = @[lineView];
    self.categoryView.separatorLineShowEnabled = YES;
    if (self.isAddInNavigation) {
        self.navigationItem.titleView = self.categoryView;
    } else {
        [self.view addSubview:self.categoryView];
    }

}
/**** 数据初始化 ****/
-(void)initializeViewData {
    
}
/**** 事件绑定 ****/
-(void)bindControlEvent {
    
}

#pragma mark - function


#pragma mark - logical processing（逻辑处理）


#pragma mark - Data


#pragma mark - Event Response / IBActions


#pragma mark - Protocol / delegat
#pragma mark - JXCategoryViewDelegate

// 点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    // 侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    self.categoryIndex = index;
//    [self viewChangeactionWithIndex:index];

}

// 滚动选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    self.categoryIndex = index;
//    [self viewChangeactionWithIndex:index];
}

/**
 * 样式切换
 */
-(void)viewChangeactionWithIndex:(NSInteger)index{
    if (index == 0) {
        self.view.backgroundColor = [UIColor blackColor];
        self.categoryView.backgroundColor = UIColor.blackColor;
        self.categoryView.titleColor = BFTheme_Color;
        self.categoryView.titleSelectedColor = UIColor.whiteColor;
        JXCategoryIndicatorLineView *lineView = (JXCategoryIndicatorLineView *)self.categoryView.indicators.firstObject;
        lineView.indicatorColor = UIColor.whiteColor;

    }else{
        self.view.backgroundColor = [UIColor whiteColor];
        self.categoryView.backgroundColor = UIColor.whiteColor;
        self.categoryView.titleColor = BFTheme_Color;
        self.categoryView.titleSelectedColor = UIColor.blackColor;
        JXCategoryIndicatorLineView *lineView = (JXCategoryIndicatorLineView *)self.categoryView.indicators.firstObject;
        lineView.indicatorColor = UIColor.blackColor;
    }
    [self.categoryView reloadDataWithoutListContainer];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0 ) {
        BFJXCategoryViewController * vc = [[BFJXCategoryViewController alloc]init];
        return vc;
    } else {
        BFJXCategoryViewController * vc = [[BFJXCategoryViewController alloc]init];
        return vc;
    }
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryView.titles.count;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.categoryIndex == 0) {
//        return UIStatusBarStyleLightContent;
        return UIStatusBarStyleDefault;
    }else{
        return UIStatusBarStyleDefault;
    }
}

#pragma mark - Notification


#pragma mark - Setter


#pragma mark - Getter



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
