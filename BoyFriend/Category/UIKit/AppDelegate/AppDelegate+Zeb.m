//
//  AppDelegate+Zeb.m
//  Demon
//
//  Created by apple on 2019/1/23.
//  Copyright © 2019年 BoyFriend. All rights reserved.
//

#import "AppDelegate+Zeb.h"

#ifdef DEBUG
#import "FLEXManager.h"
#import "JPFPSStatus.h"

#endif
@implementation AppDelegate (Zeb)

- (void)zebApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
#ifdef DEBUG
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFLEX)];
    gesture.numberOfTapsRequired = 2;
    gesture.numberOfTouchesRequired = 2;
    [self.window addGestureRecognizer:gesture];
    //FPS
    [[JPFPSStatus sharedInstance] open];
    
#endif
}

#pragma mark - FLEX

#ifdef DEBUG
- (void)showFLEX {
    [[FLEXManager sharedManager] showExplorer];
}
#endif



@end
