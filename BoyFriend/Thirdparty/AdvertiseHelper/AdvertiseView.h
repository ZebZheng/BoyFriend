//
//  AdvertiseView.h
//  Demon 启动广告视图
//
//  Created by BoyFriend on 16/6/14.
//  Copyright © 2016年 BoyFriend. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kAdSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kAdSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kAdMain_Screen_Bounds [[UIScreen mainScreen] bounds]
#define kAdUserDefaults [NSUserDefaults standardUserDefaults]

static NSString *const adImageName = @"adImageName";

@interface AdvertiseView : UIView

/** 显示广告页面方法*/
- (void)show;

/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;

@end
