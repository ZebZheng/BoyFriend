//
//  BFConstantMacros.h
//  Demon
//
//  Created by BoyFriend on 2018/5/26.
//  Copyright © 2018年 BoyFriend. All rights reserved.
//

#import "DataLibrery.h"

#ifndef BFConstantMacros_h
#define BFConstantMacros_h

//请求公用Code
#define BFApi_ClientType @"10"
//请求公用heade版本
#define BFApi_ApiVersion [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]
//请求公用 页数大小
#define BFApi_ListPageSize @"20"
//请求超时的时间
#define BFApi_RequestTimeoutInterval 30

//页面左右边距通用常量
#define LeftMargin_Constant     (BFRatio(15))
#define RightMargin_Constant    (BFRatio(15))

// 遮罩透明度
#define Mask_View_Alpha     (0.2)
// 导航栏 items 间距
#define View_Navbar_Items_Fixed_Space    20



// 全局 是否启用切换库功能 (YES: 允许， NO：不允许) -允许 登录页面点击 6下 可以切换库
#define ISEnable_Switch_Environment     (YES)



#pragma mark - 全局的状态提示语 UniformTip
/*
 *  全局的状态提示语 UniformTip
 */
// 网络异常，请检查网络
#define UniformTip_No_Network           (@"网络异常，请检查网络")

// 服务器无法到达
#define UniformTip_No_Reach_Service     (@"服务器开小差了，请稍后重试")





#endif /* Constant_h */
