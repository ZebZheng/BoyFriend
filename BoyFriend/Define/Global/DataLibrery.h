//
//  DataLibrery.h
//  Demon
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018年 BoyFriend. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LanguageModel.h"

@interface DataLibrery : NSObject
+ (instancetype)shareInstance;

//====================  底部 Tabbar 对应的值  ====================
@property (nonatomic,assign) NSInteger homeVCCode;//首页
@property (nonatomic,assign) NSInteger listVCCode;//列表
@property (nonatomic,assign) NSInteger messageVCCode;//消息
@property (nonatomic,assign) NSInteger mineVCCode;//我的


//====================  用户缓存信息  ====================
// 用户id(登录者的ID,如果存储数据跟用户相关 需要赋值)
@property (nonatomic, copy , readonly) NSString *loginUserId;
@property (nonatomic, copy , readonly) NSString *loginToken;
@property (nonatomic, strong) LanguageModel * curLanguageModel;//当前语言环境

@property (nonatomic,copy) NSString *latitude;//纬度
@property (nonatomic,copy) NSString *longitude;//经度
//@property (nonatomic,strong) PZCAddressModel *addressModel; //地址信息


//====================  接口请求信息  ====================
/**
 * 接口版本号
 */
@property (nonatomic,copy) NSString *os_version;
/**
 * 登录设备操作系统版本
 */
@property (nonatomic,copy) NSString *device_system;
/**
 * 登录设备机型
 */
@property (nonatomic,copy) NSString *device_model;




//判断是否是 iPhone X 以上设置
-(BOOL)iSiPhoneX_Series;



//获取部分http请求head值
-(void)setHttpHeadData;

/**
 * 设置缓存token ID
 */
-(void)setCacheToken:(NSString *)token UserId:(NSString *)userId;


#pragma mark- 计时器相关
//开启定时器
-(void)startTimer;
//停止定时器
-(void)stopTimer;
//计时
@property (nonatomic,copy) void (^timerLoopBlock)(void);




@end
