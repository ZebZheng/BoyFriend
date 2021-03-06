//
//  AdvertiseHelper.h
//  Demon  处理事件在AdvertiseView里面有个BFNotification_Advertise_Key通知，可以在首页进行获取通知，然后进行处理，比如进行跳转功能
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAd) name:BFNotification_Advertise_Key object:nil];
//
//  Created by BoyFriend on 16/6/14.
//  Copyright © 2016年 BoyFriend. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdvertiseView.h"

@interface AdvertiseHelper : NSObject

+ (instancetype)sharedInstance;

+(void)showAdvertiserView:(NSArray *)imageArray;

@end
