//
//  NetWorkEnvironment.h
//  DriftingBottle
//
//  Created by IMAC-2 on 2021/11/17.
//  Copyright © 2021 Apple. All rights reserved.
/// 环境切换

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkEnvironment : NSObject

/// 类型
@property (nonatomic,assign) NSInteger environmentType;

/// 环境说明(没有值会展示地址)
@property (nonatomic,copy) NSString *environmentString;

/// 主环境地址
@property (nonatomic,copy) NSString *apiUrl;

/// H5地址
@property (nonatomic,copy) NSString *h5Url;

/// 查看图片地址
@property (nonatomic,copy) NSString *lookImageUrl;





+ (NetWorkEnvironment *)sharedInstance;

/// 环境数组
@property (nonatomic,strong) NSArray *environmentArray;


/**
 * 环境数组
 */
-(NetWorkEnvironment *)getNetWorkEnvironmentModelWithType:(NSInteger)type;



@end

NS_ASSUME_NONNULL_END
