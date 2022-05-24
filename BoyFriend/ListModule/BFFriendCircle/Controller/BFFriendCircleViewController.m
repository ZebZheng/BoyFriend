//
//  BFFriendCircleViewController.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/18.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFFriendCircleViewController.h"
#import "BFFriendCircleView.h"
#import "BFFriendCircleViewModel.h"

@interface BFFriendCircleViewController ()

@property (nonatomic,strong) BFFriendCircleView * productView;
@property (nonatomic,strong) BFFriendCircleViewModel * productViewModel;

@end

@implementation BFFriendCircleViewController
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
    
}

#pragma mark - init
/**** 视图初始化 ****/
-(void)initializeView {
    self.tableView.estimatedRowHeight = 100;
}

/**** 数据初始化 ****/
-(void)initializeViewData {
    [self bindControlEventViewModel:self.productViewModel];
    [self refreshHeaderAction];
}

/**** 事件绑定 ****/
-(void)bindControlEvent {
    
}

#pragma mark - function


#pragma mark - logical processing（逻辑处理）


#pragma mark - Data


#pragma mark - Event Response / IBActions


#pragma mark - Protocol / delegat


#pragma mark - Notification


#pragma mark - Setter


#pragma mark - Getter
- (BFFriendCircleView *)productView {
    if (!_productView) {
        _productView = [BFFriendCircleView.alloc init];
    }
    return _productView;
}
- (BFFriendCircleViewModel *)productViewModel {
    if (!_productViewModel) {
        _productViewModel = [BFFriendCircleViewModel.alloc init];
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
