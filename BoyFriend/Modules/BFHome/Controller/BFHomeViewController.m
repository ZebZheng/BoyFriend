//
//  BFHomeViewController.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/11.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFHomeViewController.h"
#import "BFHomeSectionViewController.h"
#import "BFHomeView.h"
#import "BFHomeViewModel.h"
#import "UIViewController+BFLateralSlide.h"

@interface BFHomeViewController ()

@property (nonatomic,strong) BFHomeView *productView;
@property (nonatomic,strong) BFHomeViewModel *productViewModel;

@end

@implementation BFHomeViewController
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
    self.navigationItem.title=@"首页";
    self.bf_navigationBarLineHidden=YES;

}
/**** 数据初始化 ****/
-(void)initializeViewData{
    
}
/**** 事件绑定 ****/
-(void)bindControlEvent{
    
}


#pragma mark - function
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    BFHomeSectionViewController * vc  =[[BFHomeSectionViewController alloc] init];
    [self bf_showDefaultDrawerViewController:vc];
}

#pragma mark - logical processing（逻辑处理）


#pragma mark - Data


#pragma mark - Event Response / IBActions


#pragma mark - Protocol / delegat


#pragma mark - Notification


#pragma mark - Setter


#pragma mark - Getter
- (BFHomeView *)productView {
    if (!_productView) {
        _productView = [BFHomeView.alloc init];
    }
    return _productView;
}
- (BFHomeViewModel *)productViewModel {
    if (!_productViewModel) {
        _productViewModel = BFHomeViewModel.alloc.init;
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
