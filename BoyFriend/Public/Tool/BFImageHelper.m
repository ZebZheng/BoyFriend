/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#import "BFImageHelper.h"
#import "NSDictionary+BFConvent.h"
#import <ImageIO/ImageIO.h>

@interface BFImageHelper () <UIImagePickerControllerDelegate>

/// 成功回调
@property (nonatomic,copy) void (^successBlock)(void);
/// 失败回调
@property (nonatomic,copy) void (^errorBlock)(NSError * error);


@end

@implementation BFImageHelper

BFSINGLETON_M

///git转图片组
- (NSArray *)imagesWithGif:(NSString *)gifName type:(NSString *)type {
    // 1 获取gif数据
    NSString *gifPath = [[NSBundle mainBundle] pathForResource:gifName ofType:type];
    NSData *data = [NSData dataWithContentsOfFile:gifPath];
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef) data, nil);
    // 2 获取gif有多少帧
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    for (size_t i = 0; i < count; i++) {
        CGImageRef imageref = CGImageSourceCreateImageAtIndex(source, i, NULL);
        // 3 将单帧数据转化为UIImage
        UIImage *image = [UIImage imageWithCGImage:imageref scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        [tmpArray addObject: image];
        CGImageRelease(imageref);
    }
    CFRelease(source);
    return tmpArray;
}
///保存到相册
- (void)bf_savedPhotosAlbum:(UIImage *)img successful:(void(^)(void))successBlock error:(void(^)(NSString *error))errorBlock {
    //参数1:图片对象
    //参数2:成功方法绑定的target
    //参数3:成功后调用方法
    //参数4:需要传递信息(成功后调用方法的参数)
    UIImageWriteToSavedPhotosAlbum(img, _instance, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [self setSuccessBlock:^{
        successBlock();
    }];
    [self setErrorBlock:^(NSError *error) {
        errorBlock([error.userInfo bf_toJson]);
    }];
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        BFBlock_Safe_Calls(self.errorBlock,error);
    } else {
        BFBlock_Safe_Calls(self.successBlock);
    }
}

@end
