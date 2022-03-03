//
//  HomeViewController.m
//  Demon
//
//  Created by apple on 2019/1/22.
//  Copyright © 2019年 BoyFriend. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeSectionViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
#pragma mark - UI


#pragma mark - IBActions/Event Response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    HomeSectionViewController * vc  =[[HomeSectionViewController alloc] init];
    BFPushViewController(vc);
}

#pragma mark - Data


#pragma mark - logical processing（逻辑处理）


#pragma mark - Notification


#pragma mark - Protocol conformance


#pragma mark - Getter Setter




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
