//
//  BFHomeSectionViewController.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/11.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFHomeSectionViewController.h"
#import "WMPlayer.h"
@interface BFHomeSectionViewController ()
@property(nonatomic, strong) WMPlayer * wmPlayer;
@end

@implementation BFHomeSectionViewController

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


#pragma mark - Notification


#pragma mark - Setter


#pragma mark - Getter



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
