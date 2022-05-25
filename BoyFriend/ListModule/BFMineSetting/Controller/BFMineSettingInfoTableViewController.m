//
//  BFMineSettingInfoTableViewController.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/25.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFMineSettingInfoTableViewController.h"
#import "BFMineSettingInfoViewModel.h"

@interface BFMineSettingInfoTableViewController ()

@property (nonatomic,strong) BFMineSettingInfoViewModel * productViewModel;

/**
 * 退出
 */
@property (nonatomic,strong) UIButton *logoutButton;

@end

@implementation BFMineSettingInfoTableViewController
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
    self.bf_navigationBarLineHidden = YES;
    self.view.backgroundColor = BFRGB_BgColor;
    self.tableView.backgroundColor = BFRGB_BgColor;
    self.navigationItem.title = @"设置";
    UIView * foot = [UIView.alloc initWithFrame:CGRectMake(0, 0, BFScreen_Width, BFRatio(130))];
    foot.backgroundColor = BFRGB_BgColor;
    [foot addSubview:self.logoutButton];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(foot);
        make.center.mas_equalTo(foot);
        make.height.mas_equalTo(BFRatio(50));
    }];
    self.tableView.tableFooterView = foot;
}

/**** 数据初始化 ****/
-(void)initializeViewData {
    [self bindControlEventViewModel:self.productViewModel];
    [self.productViewModel initializeSettingData];
    self.productViewModel.reloadTableView = YES;
}

/**** 事件绑定 ****/
-(void)bindControlEvent {
    
}

#pragma mark - function

///退出登录
- (void)handleLogoutEvent {
    
}
#pragma mark - logical processing（逻辑处理）


#pragma mark - Data


#pragma mark - Event Response / IBActions


#pragma mark - Protocol / delegat


#pragma mark - Notification


#pragma mark - Setter


#pragma mark - Getter
- (BFMineSettingInfoViewModel *)productViewModel {
    if (!_productViewModel) {
        _productViewModel = [BFMineSettingInfoViewModel.alloc init];
    }
    return _productViewModel;
}
- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [BFUICreator createButtonWithTitle:@"注销登录" image:nil target:self action:@selector(handleLogoutEvent)];
        _logoutButton.titleLabel.font = BFPFRFontWithSizes(16);
        _logoutButton.backgroundColor = UIColor.whiteColor;
        _logoutButton.bf_titleColor = BFTheme_Color;
    }
    return _logoutButton;
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
