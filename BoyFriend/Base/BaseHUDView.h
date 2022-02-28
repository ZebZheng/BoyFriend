//
//  BaseHUDView.h
//  Demon
//
//  Created by BoyFriend on 2018/8/28.
//  Copyright © 2018年 BoyFriend. All rights reserved.
//

#import "BaseView.h"

@interface BaseHUDView : BaseView

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) BOOL isTransparent;

- (void)hideHUD;

@end
