/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIResponder (BFConfigure)

//MARK: - 开启刷新(InjectionIII)
- (void)bf_openInjection;

//MARK: - 键盘收回管理
-(void)bf_configureBoardManager;
-(void)bf_configureBoardManager:(void(^_Nullable)(IQKeyboardManager *_Nullable))block;

@end
NS_ASSUME_NONNULL_END
