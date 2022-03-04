/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^BFCompletion)(NSString *time);
typedef void (^BFStopCompletion)(void);
@interface UIButton (BFCountDown)

//MARK: -倒计时按钮
/// @param timeout 结束时间
/// @param completion 进行中回调
/// @param stopCompletion 结束回调
-(void)bf_startTime:(NSInteger )timeout completion:(BFCompletion)completion stopCompletion:(BFStopCompletion)stopCompletion;

@end

NS_ASSUME_NONNULL_END
