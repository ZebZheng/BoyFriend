//
//  BFTool.h
//  Demon
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 BoyFriend. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFTool : NSObject

#pragma mark 屏幕适配
//适配屏幕(size直接输入px)
+(float)smartSizeCalculate:(float)size;

#pragma mark 打开 Safari 系统浏览器
+ (void)openSafariWithUrl:(NSString *)urlString;

#pragma mark 旋转动画
//旋转动画 转圈圈
+(CABasicAnimation * )revolveAnimation;

#pragma mark 浏览头像(图片放大缩小)
//浏览头像(图片放大缩小)
+(void)showImage:(UIImageView*)avatarImageView;

#pragma mark 刷新tableview指定位置
//刷新tableview指定cell
+(void)reloadTableviewRowsWithSection:(NSInteger)section Row:(NSInteger)row tableview:(UITableView *)tableview;

//刷新tableview指定section
+(void)reloadTableviewSectionWithSection:(NSInteger)section tableview:(UITableView *)tableview;


#pragma mark 获取ViewController
//获取view的父视图控制器
+ (UIViewController *)getSuperViewController:(UIView *)view;

//获取当前屏幕的根视图控制器
+ (UIViewController *)getRootViewController;

//获取当前显示的viewcontroller
+ (UIViewController *)getCurrentViewController;

#pragma mark - 获取当前window
+ (UIWindow *)getCurrentWindow;


#pragma mark  图片压缩处理
// 动态压缩图片(根据图片最终大小来设置压缩比)
+ (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;
// 调整图片分辨率/尺寸（等比例缩放）
+ (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)source_image ;
// 二分法
+ (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize ;

#pragma mark - UUID

// 获取设备唯一标识 id
+ (NSString *)fetchDeviceOnlyKey;

// 一直变的UUID
+ (NSString *)UUIDString;


@end
