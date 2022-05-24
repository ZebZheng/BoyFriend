//
//  PhotoContainerView.h
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/23.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoContainerView : BaseView


/// 资源图片数组(可以是 UIImage对象  名称  地址 )
@property(nonatomic, strong) NSArray *resourceArray;

/// 点击图片
@property (nonatomic,copy) void (^tapImageViewBlock)(NSArray *resourceArray , NSInteger tag );


@end

NS_ASSUME_NONNULL_END
