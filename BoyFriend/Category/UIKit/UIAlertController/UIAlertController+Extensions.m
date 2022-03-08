/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "UIAlertController+Extensions.h"

@implementation UIAlertController (Extensions)

+ (UIViewController *)findAppreciatedRootVC {
    UIViewController *rootVC = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    if ([rootVC presentedViewController] != nil) {
        rootVC = rootVC.presentedViewController;
    }
    return rootVC;
}

+ (void)presentAlertController:(UIAlertController *)alertController {
    UIViewController *rootVC = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    if ([rootVC presentedViewController] != nil) {
        rootVC = [UIAlertController findAppreciatedRootVC];
    }
    [rootVC presentViewController:alertController animated:YES completion:nil];
}


+ (void)bf_presentActionControllerWithTitle:(NSString *)title
                            actionTitles:(NSArray<NSString *> *)actionTitles
                           completeBlock:(void (^)(NSString *selectTitleString, NSUInteger index))completed {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:obj
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                BFBlock_Safe_Calls(completed, obj, idx);
                                                            }];
        [alertController addAction:alertAction];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    [alertController addAction:cancelAction];
    [[self findAppreciatedRootVC] presentViewController:alertController animated:YES completion:nil];
}

+ (void)bf_presentAlertControllerWithTitle:(NSString *)title
                                message:(NSString *)message
                              doneTitle:(NSString *)doneTitle
                            cancelTitle:(NSString *)cancelTitle
                          completeBlock:(void (^)(BOOL))completeBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:doneTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        BFBlock_Safe_Calls(completeBlock, NO);
    }];
    
    if (cancelTitle.length > 0) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            BFBlock_Safe_Calls(completeBlock, YES);
        }];
        [alertController addAction:cancelAction];
    }
    
    [alertController addAction:doneAction];
    
    [self presentAlertController:alertController];
}


@end
