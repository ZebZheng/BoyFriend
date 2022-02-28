//
//  BaseViewController.h
//  Demon 基控制器
//
//  Created by BoyFriend on 16/1/5.
//  Copyright © 2016年 BoyFriend. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewModel.h"

@protocol  BaseViewNavigationBarDataSource<NSObject>

@optional
-(UIButton*)set_leftBarBtn;
-(UIButton*)set_rightBarBtn;

-(void)locationSuccess:(CLLocationManager *)manager;///定位成功
-(void)locationFail:(CLLocationManager *)manager;///定位失败

@end


@protocol BaseViewNavigationBarDelegate <NSObject>

@optional
-(void)leftBarBtnItem_click:(UIButton*)sender;
-(void)rightBarBtnItem_click:(UIButton*)sender;

@end

@interface BaseViewController : UIViewController<BaseViewNavigationBarDataSource, BaseViewNavigationBarDelegate,UITextFieldDelegate>

/// baseViewModel
@property (nonatomic,strong) BaseViewModel *bViewModel;





//默认可在代理里面实现单个按钮,多个可以重写该方法
-(void)setRightBarBtnItem;


//返回按钮 事件
-(void)backAction;


// 显示 HUD 
- (void)showHUD;

// 移除 HUD
- (void)hideHUD;


/**
 * 开始定位
 */
-(void)startLocation;
/**
 * 关闭定位
 */
-(void)stopLocation;


/**
 * 设置未读消息数
 */
-(void)setUnReadNum:(NSInteger)num obejctAtindex:(NSInteger)index;

@end
