//
//  BaseViewModel.h
//  Demon
//
//  Created by BoyFriend on 2017/8/23.
//  Copyright © 2017年 BoyFriend. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWorkURL.h"

@class BaseResponseData;

typedef void (^successCallback)(BaseResponseData *result);
typedef void (^failCallback)(BaseResponseData *result);

@interface BaseViewModel : UIView

/// 请求loading
@property (nonatomic,copy) void (^showLoadingBlock)(BOOL isWindow , NSString *message);

/// toast提示框
@property (nonatomic,copy) void (^showMessageBlock)(BOOL isWindow , NSString *message);

/// 隐藏MB提示框
@property (nonatomic,copy) void (^hideHUDBlock)(void);

#pragma mark - response handler（统一错误处理，统一返回值处理）
- (void)handleResponse:(id)responseObject
                  Resp:(Class)ObjType
            completion:(void (^)(BOOL success,BaseResponseData * respData))completion;

/// 消息展示
- (void)showLoading:(BOOL)isWindow Message:(NSString *)message;
- (void)showMessage:(BOOL)isWindow Message:(NSString *)message;
- (void)showMessageInView:(NSString *)message;
- (void)hideHUD;


@end

@interface HandleModel : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) id  data;

@end

@interface BaseResponseData : NSObject
@property (nonatomic,copy)      NSString                *code;
@property (nonatomic,copy)      NSString                *info;
@property (nonatomic,strong)    NSMutableDictionary     *dataDic;
@property (nonatomic,strong)    NSMutableArray          *dataArray;
@property (nonatomic,strong)    id                      extendModel;
@end
