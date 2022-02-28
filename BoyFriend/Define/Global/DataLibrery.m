//
//  DataLibrery.m
//  Demon
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018年 BoyFriend. All rights reserved.
//

#import "DataLibrery.h"
#import "CommonViewModel.h"
#import "NSBundle+BFLanguage.h"

@interface DataLibrery ()

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, copy , readwrite) NSString *loginUserId;
@property (nonatomic, copy , readwrite) NSString *loginToken;


@end

@implementation DataLibrery

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static DataLibrery * instance;
    dispatch_once(&onceToken, ^{
        instance = [[DataLibrery alloc] init];
    });
    return instance;
}


//判断是否是 iPhone X 以上设置
-(BOOL)iSiPhoneX_Series{
    if (@available(iOS 11.0, *)) {
        // 利用safeAreaInsets.bottom > 0.0来判断是否是iPhone X以上设备。
        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
        if (window.safeAreaInsets.bottom > 0.0) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

//获取部分http请求head值
-(void)setHttpHeadData{
    self.os_version=BFApi_ApiVersion;
    self.device_system=[NSString stringWithFormat:@"iOS %@",BFSYSTEMVERSION];
    self.device_model=[UIDevice bf_platformString];
 
    /*
     https://www.cnblogs.com/lobtao/articles/11365639.html
     中文简体           zh-Hans-CN
     中文繁体           zh-Hant-US
     中文繁体（台湾）     zh-Hant-TW
     中文繁体（香港）     zh-Hant-HK
     中文繁体（澳门）     zh-Hant-MO
     日本               ja-JP
     英文               en-CN
     */

    NSString *languageName = BFCurrentLanguage;
    
    LanguageModel * languageModel =[LanguageModel getLanguageModelFromDB];

    if (languageModel != nil) {
        languageName = languageModel.localLang;
    }
    
    if ([languageName hasPrefix:@"zh-Hans"]) {
        self.curLanguageModel = [LanguageModel getLanguageModelWithType:LanguageTypeChinese];
    }
    else if ([languageName hasPrefix:@"ja"]){
        self.curLanguageModel = [LanguageModel getLanguageModelWithType:LanguageTypeJapanese];

    }
    else{
        self.curLanguageModel = [LanguageModel getLanguageModelWithType:LanguageTypeEnglish];
    }
    
    [NSBundle bf_setLanguage:self.curLanguageModel.localLang];

}


/**
 * 设置缓存token ID
 */
-(void)setCacheToken:(NSString *)token UserId:(NSString *)userId{
    self.loginToken = token;
    self.loginUserId = userId;
}

#pragma mark- 计时器相关
//开启定时器
-(void)startTimer{
     if (!self.timer) {
          self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                        target:self
                                                      selector:@selector(timerLoop)
                                                      userInfo:nil
                                                       repeats:YES];
          [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
     }
}
//停止定时器
-(void)stopTimer{
     if (self.timer) {
          [self.timer invalidate];
          self.timer = nil;
     }
}
//计时
-(void)timerLoop{
    if (self.timerLoopBlock) {
        self.timerLoopBlock();
    }
}




@end
