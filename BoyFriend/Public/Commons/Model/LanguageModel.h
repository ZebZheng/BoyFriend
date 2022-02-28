//
//  LanguageModel.h
//
//
//  Created by apple on 2021/10/25.
//  Copyright © 2021 apple. All rights reserved.
//

/*
 切换语言 操作
 
 直接把最新的 LanguageModel 存到数据库
 执行下   [[DataLibrery shareInstance] setHttpHeadData];
 
 */


#import "BaseSQliteModel.h"

NS_ASSUME_NONNULL_BEGIN
/**
 *  当前语言环境
 */
typedef NS_ENUM(NSInteger, LanguageType) {
    LanguageTypeEnglish,  //英文
    LanguageTypeChinese,  //中文
    LanguageTypeJapanese,  //日本
};

@interface LanguageModel : BaseSQliteModel

/**
 * 主键
 */
@property (nonatomic, copy) NSString * zid;




@property (nonatomic,assign) LanguageType languageType;//当前语言环境

@property (nonatomic,copy) NSString *serverLang; // 服务器需要的多语言 eg:ja-JP en_US zh_CN

@property (nonatomic,copy) NSString *localLang; // 本地多语言设置 需要的 eg:ja en zh-Hans

@property (nonatomic,copy) NSString *showLanguageLang; // 显示出来给用户看的 eg:日本語 English 简体中文


//获取多语言缓存信息
+(LanguageModel *)getLanguageModelFromDB;

///多语言支持类型
+ (NSMutableArray *)settingsLanguageInfoTableItemArray ;

///多语言支持类型
+ (LanguageModel *)getLanguageModelWithType:(LanguageType)language ;


@end

NS_ASSUME_NONNULL_END


