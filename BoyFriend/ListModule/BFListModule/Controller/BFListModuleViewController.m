//
//  BFListModuleViewController.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/27.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFListModuleViewController.h"
#import "BFListModuleView.h"
#import "BFListModuleViewModel.h"


#import "BFSDCycleScrollViewViewController.h"
#import "BFJXCategorySegmentedViewController.h"
#import "BFLinkageTTViewController.h"
#import "BFLinkageTCViewController.h"
#import "BFFriendCircleViewController.h"
#import "BFMineSettingViewController.h"
#import "UIViewController+BFLateralSlide.h"

#import "BFLateralSlideViewController.h"
#import "UIViewController+BFLateralSlide.h"

@interface BFListModuleViewController ()

@property (nonatomic,strong) BFListModuleView * productView;
@property (nonatomic,strong) BFListModuleViewModel * productViewModel;

@end

@implementation BFListModuleViewController
#pragma mark - Lifecycle
-(instancetype)init {
    if (self=[super init]) {
        // 如果需要分页  建议 同步开启 上提  下拉 刷新
        self.isNeedPaging = NO;
//        self.isUseRefreshHeader = YES;
//        self.isUseRefreshFooter = YES;
//        self.isAutoRequestMore = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeView];
    [self initializeViewData];
    [self bindControlEvent];
    [self.view bf_addSubviews:nil];
}

#pragma mark - init
/**** 视图初始化 ****/
-(void)initializeView {
    self.bf_navigationBarLineHidden = YES;
    self.navigationItem.title = @"功能模块";
}

/**** 数据初始化 ****/
-(void)initializeViewData {
    [self bindControlEventViewModel:self.productViewModel];
    [self refreshHeaderAction];
}

/**** 事件绑定 ****/
-(void)bindControlEvent {
    @weakify(self);
    [self.productViewModel setDidSelectRowBlock:^(BFListModuleInfoModel * _Nonnull infoModel) {
        @strongify(self);
        switch (infoModel.indexInteger) {
            case 1://轮播滚动视图
                [self action1:infoModel];
                break;
            case 2://分段选址器-居左
                [self action2:infoModel];
                break;
            case 3://分段选址器-居中
                [self action3:infoModel];
                break;
            case 4://分段选择器-导航栏
                [self action4:infoModel];
                break;
            case 5://二级联动-tableview-tableview
                [self action5:infoModel];
                break;
            case 6://二级联动-tableview-collectionview
                [self action6:infoModel];
                break;
            case 7://仿微信朋友圈
                [self action7:infoModel];
                break;
            case 8://我的-设置
                [self action8:infoModel];
                break;
            case 9://抽屉效果
                [self action9:infoModel];
                break;
            default:
                break;
        }
    }];
}

#pragma mark - function

///轮播滚动视图
- (void)action1:(BFListModuleInfoModel *)infoModel {
    BFSDCycleScrollViewViewController * vc = [[BFSDCycleScrollViewViewController alloc]init];
    vc.title = infoModel.name;
    [self.navigationController pushViewController:vc animated:YES];
}

///分段选址器-居左
- (void)action2:(BFListModuleInfoModel *)infoModel {
    BFJXCategorySegmentedViewController * vc = [[BFJXCategorySegmentedViewController alloc]init];
    vc.title = infoModel.name;
    [self.navigationController pushViewController:vc animated:YES];
}

///分段选址器-居中
- (void)action3:(BFListModuleInfoModel *)infoModel {
    BFJXCategorySegmentedViewController * vc = [[BFJXCategorySegmentedViewController alloc]init];
    vc.title = infoModel.name;
    vc.averageWidthEnabled = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

///分段选择器-导航栏
- (void)action4:(BFListModuleInfoModel *)infoModel {
    BFJXCategorySegmentedViewController * vc = [[BFJXCategorySegmentedViewController alloc]init];
    vc.title = infoModel.name;
    vc.isAddInNavigation = YES;
    vc.averageWidthEnabled = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

///二级联动-tableview-tableview
- (void)action5:(BFListModuleInfoModel *)infoModel {
    BFLinkageTTViewController * vc = [[BFLinkageTTViewController alloc]init];
    vc.title = infoModel.name;
    [self.navigationController pushViewController:vc animated:YES];
}

///二级联动-tableview-collectionview
- (void)action6:(BFListModuleInfoModel *)infoModel {
    BFLinkageTCViewController * vc = [[BFLinkageTCViewController alloc]init];
    vc.title = infoModel.name;
    [self.navigationController pushViewController:vc animated:YES];
}

///仿微信朋友圈
- (void)action7:(BFListModuleInfoModel *)infoModel {
    BFFriendCircleViewController * vc = [[BFFriendCircleViewController alloc]init];
    vc.title = infoModel.name;
    [self.navigationController pushViewController:vc animated:YES];
}

///我的-设置
- (void)action8:(BFListModuleInfoModel *)infoModel {
    BFMineSettingViewController * vc = [[BFMineSettingViewController alloc]init];
    vc.title = infoModel.name;
    [self.navigationController pushViewController:vc animated:YES];
}
///抽屉效果
- (void)action9:(BFListModuleInfoModel *)infoModel {
    BFMineSettingViewController * vc = [[BFMineSettingViewController alloc]init];
    vc.isLateralSlide = YES;
    [self bfl_showDefaultDrawerViewController:vc];

}
#pragma mark - logical processing（逻辑处理）


#pragma mark - Data


#pragma mark - Event Response / IBActions


#pragma mark - Protocol / delegat


#pragma mark - Notification


#pragma mark - Setter


#pragma mark - Getter
- (BFListModuleView *)productView {
    if (!_productView) {
        _productView = [BFListModuleView.alloc init];
    }
    return _productView;
}
- (BFListModuleViewModel *)productViewModel {
    if (!_productViewModel) {
        _productViewModel = [BFListModuleViewModel.alloc init];
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
