//
//  BFSystemUtils.m
//  Demon
//
//  Created by BoyFriend on 2018/7/17.
//  Copyright © 2018年 BoyFriend. All rights reserved.
//

#import "BFSystemUtils.h"
#import <AVFoundation/AVFoundation.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "sys/utsname.h"

@interface BFSystemUtils ()

@end

@implementation BFSystemUtils

// 相册
+ (BOOL)isAllowPhotoLibrary {
    
    //判断是否有相册的权限
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusDenied || authStatus == PHAuthorizationStatusRestricted) {
        
        [self showPhotoLibraryAlertView];
        return NO;
    } else if (authStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
            });
        }];
        return NO;
    }
    return YES;
}

// 相册 Block
+ (void)isAllowPhotoLibraryCompleted:(void (^)(BOOL granted))completed {
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusNotDetermined) {
            } else if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
                
                [self showPhotoLibraryAlertView];
                
                BFBlock_Safe_Calls(completed, NO);
            } else if (status == PHAuthorizationStatusAuthorized) {
                BFBlock_Safe_Calls(completed, YES);
            }
        });
    }];
}

// 相机
+ (BOOL)isAllowCamera {
    
    //判断是否有相机的权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        //无权限
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self showAllowCameraAlertView];
        });
        return NO;
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
            });
        }];
        return NO;
    }
    return YES;
}

// 相机 Block
+ (void)isAllowCameraCompleted:(void (^)(BOOL granted))completed {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (granted) {
                BFBlock_Safe_Calls(completed, YES);
            } else {
                
                [self showAllowCameraAlertView];
                BFBlock_Safe_Calls(completed, NO);
            }
        });
    }];
}

// 麦克风
+ (BOOL)isAllowAudio {
    
    //判断是否有相机的权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        //无权限
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAllowAudioAlertView];
        });
        return NO;
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
            });
        }];
        return NO;
    }
    return YES;
}

// 定位
+ (BOOL)isAllowLocation {
    
    //判断定位
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        //无权限
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAllowLocationAlertView];
        });
        return NO;
    }
    return YES;
}

#pragma mark - Private

// 提示前往开启相册权限
+ (void)showPhotoLibraryAlertView {
    
    [UIAlertController bf_presentAlertControllerWithTitle:nil message:[NSString stringWithFormat:@"请在“设置-%@-照片”选项中允许访问你的相册",BFAppName] doneTitle:@"设置" cancelTitle:@"取消" completeBlock:^(BOOL isCancelled) {
        if (!isCancelled) {
            if (UIApplicationOpenSettingsURLString != NULL) {
                NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [BFTool openSafariWithUrl:appSettings];

            }
        }
    }];
}

// 提示前往开启相机权限
+ (void)showAllowCameraAlertView {
    
    if ([[[UIDevice currentDevice] systemVersion] integerValue] < 8.0) {
        
        [UIAlertController bf_presentAlertControllerWithTitle:@"无法打开照相机" message:[NSString stringWithFormat:@"请在“设置-隐私-相机”选项中允许《%@》访问你的相机",BFAppName] doneTitle:nil cancelTitle:@"确定" completeBlock:nil];
    } else {
        
        [UIAlertController bf_presentAlertControllerWithTitle:@"开启相机权限" message:[NSString stringWithFormat:@"在“设置-%@”中开启相机就可以开始使用本功能哦~",BFAppName] doneTitle:@"设置" cancelTitle:@"取消" completeBlock:^(BOOL isCancelled) {
            if (!isCancelled) {
                if (UIApplicationOpenSettingsURLString != NULL) {
                    NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    [BFTool openSafariWithUrl:appSettings];
                }
            }
        }];
    }
}

// 提示前往开启麦克风权限
+ (void)showAllowAudioAlertView {
    
    if ([[[UIDevice currentDevice] systemVersion] integerValue] < 8.0) {
        
        [UIAlertController bf_presentAlertControllerWithTitle:@"无法访问麦克风"message:[NSString stringWithFormat:@"请在“设置-隐私-麦克风”选项中允许《%@》访问你的麦克风",BFAppName] doneTitle:nil cancelTitle:@"确定" completeBlock:nil];
    } else {
        
        [UIAlertController bf_presentAlertControllerWithTitle:@"开启麦克风权限" message:[NSString stringWithFormat:@"在“设置-%@”中开启麦克风就可以开始使用本功能哦~",BFAppName] doneTitle:@"设置" cancelTitle:@"取消" completeBlock:^(BOOL isCancelled) {
            if (!isCancelled) {
                if (UIApplicationOpenSettingsURLString != NULL) {
                    NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    [BFTool openSafariWithUrl:appSettings];
                }
            }
        }];
    }
}

// 提示前往开启定位权限
+ (void)showAllowLocationAlertView {
    
    if ([[[UIDevice currentDevice] systemVersion] integerValue] < 8.0) {
        
        [UIAlertController bf_presentAlertControllerWithTitle:@"定位服务未开启" message:[NSString stringWithFormat:@"您尚未开启定位功能，无法准确获取定位消息。请在“设置-隐私-定位服务中”，找到“%@”并打开来获取最完整的服务",BFAppName] doneTitle:nil cancelTitle:@"确定" completeBlock:nil];
    } else {
        
        [UIAlertController bf_presentAlertControllerWithTitle:nil message:@"您尚未开启定位功能，无法准确获取定位消息。" doneTitle:@"去开启" cancelTitle:@"忽略" completeBlock:^(BOOL isCancelled) {
            if (!isCancelled) {
                if (UIApplicationOpenSettingsURLString != NULL) {
                    NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    [BFTool openSafariWithUrl:appSettings];
                }
            }
        }];
    }
}


//保存图片到系统相册
+(void)saveImageToSystemAlbum:(UIImage *)img{
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

}

+ (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [MBProgressHUD showTipMessageInWindow:@"保存失败"];
    }
    else {
        [MBProgressHUD showTipMessageInWindow:@"保存成功"];
    }
}
@end
