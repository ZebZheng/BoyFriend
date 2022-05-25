//
//  BFMineViewController.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/24.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFMineSettingViewController.h"
#import "BFMineSettingView.h"
#import "BFMineSettingViewModel.h"
#import "BFMineSettingInfoTableViewController.h"
#import "UIViewController+BFLateralSlide.h"

@interface BFMineSettingViewController ()

@property (nonatomic,strong) BFMineSettingView * productView;
@property (nonatomic,strong) BFMineSettingViewModel * productViewModel;

/// 导航栏视图
@property (nonatomic,strong) CommonsView *navView;

@end

@implementation BFMineSettingViewController
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
    self.view.backgroundColor = BFRGB_BgColor;
    self.tableView.backgroundColor = BFRGB_BgColor;
    self.bf_prefersNavigationBarHidden = YES;
    self.tableView.tableHeaderView = self.productView;
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.navView.button];
    self.navView.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.navView.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.navView.navBackButton);
        make.size.mas_equalTo(CGSizeMake(BFNavBarHeight, BFNavBarHeight));
        make.right.mas_equalTo(-BFRatio(10));
    }];
}

/**** 数据初始化 ****/
-(void)initializeViewData {
    [self bindControlEventViewModel:self.productViewModel];
    [self.productViewModel initializeMineData];
    self.productViewModel.reloadTableView = YES;
    self.navView.navBackButton.hidden = self.isLateralSlide;

}

/**** 事件绑定 ****/
-(void)bindControlEvent {
    @weakify(self);
    [self.productViewModel setDidSelectRowBlock:^(BFTableMenuItem * _Nonnull infoModel) {
        @strongify(self);
        switch (infoModel.indexInteger) {
            case 9://设置
                [self settingAction:infoModel];
                break;
                
            default:
                [self settingAction:infoModel];
                break;
        }
    }];
}

#pragma mark - function

///设置
- (void)settingAction:(BFTableMenuItem *)model {
    BFMineSettingInfoTableViewController * vc  =[[BFMineSettingInfoTableViewController alloc] init];
    if (self.isLateralSlide) {
        [self bfl_pushViewController:vc];
    } else {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - logical processing（逻辑处理）


#pragma mark - Data


#pragma mark - Event Response / IBActions


#pragma mark - Protocol / delegat
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 导航栏渐变
    CGFloat offsetY = scrollView.contentOffset.y;

    CGFloat h = BFStatusHeight + BFNavBarHeight;
    if (offsetY > 0.0f && offsetY <= h) {
        self.navView.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:offsetY / h];
        [self.navView.navBackButton setImage:[UIImage imageNamed:@"nav_back_black"] forState:UIControlStateNormal];
        [self.navView.button setImage:[UIImage imageNamed:@"me_edit_black"] forState:UIControlStateNormal];
    } else if (offsetY > h) {
        self.navView.backgroundColor = [UIColor whiteColor];
        [self.navView.navBackButton setImage:[UIImage imageNamed:@"nav_back_black"] forState:UIControlStateNormal];
        [self.navView.button setImage:[UIImage imageNamed:@"me_edit_black"] forState:UIControlStateNormal];
    } else if (offsetY <= 0) {
        self.navView.backgroundColor = UIColor.clearColor;
        [self.navView.navBackButton setImage:[UIImage imageNamed:@"nav_back_white"] forState:UIControlStateNormal];
        [self.navView.button setImage:[UIImage imageNamed:@"me_edit_white"] forState:UIControlStateNormal];
    }
}

#pragma mark - Notification


#pragma mark - Setter


#pragma mark - Getter
- (BFMineSettingView *)productView {
    if (!_productView) {
        _productView = [BFMineSettingView.alloc initWithFrame:CGRectMake(0, 0, BFScreen_Width, BFRatio(250))];
        [_productView bf_setupWithData:nil];
    }
    return _productView;
}
- (BFMineSettingViewModel *)productViewModel {
    if (!_productViewModel) {
        _productViewModel = [BFMineSettingViewModel.alloc init];
    }
    return _productViewModel;
}

-(CommonsView *)navView{
    if (!_navView) {
        _navView=[[CommonsView alloc]initNavViewWithTitle:@"" BackgroundColor:UIColor.clearColor isWhite:YES];
        [_navView.navBackButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        _navView.button.adjustsImageWhenHighlighted = NO;
        [_navView.button setTitle:@"" forState:UIControlStateNormal];
        [_navView.button setImage:BFImageName(@"me_edit") forState:UIControlStateNormal];
//        [_navView.button addTarget:self action:@selector(userInfoVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navView;
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
