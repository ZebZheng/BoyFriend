//
//  BFJXCategoryViewController.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/27.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFJXCategoryViewController.h"
#import "BFJXCategoryView.h"
#import "BFJXCategoryViewModel.h"

@interface BFJXCategoryViewController ()

@property (nonatomic,strong) BFJXCategoryView *productView;
@property (nonatomic,strong) BFJXCategoryViewModel *productViewModel;

@end

@implementation BFJXCategoryViewController
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
    self.view.backgroundColor = BFRandomColor;

}
/**** 数据初始化 ****/
-(void)initializeViewData{
    
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

#pragma mark - Notification


#pragma mark - Setter


#pragma mark - Getter
- (BFJXCategoryView *)productView {
    if (!_productView) {
        _productView = [BFJXCategoryView.alloc init];
    }
    return _productView;
}
- (BFJXCategoryViewModel *)productViewModel {
    if (!_productViewModel) {
        _productViewModel = BFJXCategoryViewModel.alloc.init;
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
