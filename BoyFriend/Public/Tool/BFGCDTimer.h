/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFGCDTimer : NSObject
+ (NSString*)timerTask:(void(^)(void))task
            start:(NSTimeInterval) start
         interval:(NSTimeInterval) interval
          repeats:(BOOL) repeats
             async:(BOOL)async;

+(void)canelTimer:(NSString*) timerName;
@end

NS_ASSUME_NONNULL_END
