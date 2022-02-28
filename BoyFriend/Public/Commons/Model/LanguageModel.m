//
//  LanguageModel.m
//
//
//  Created by apple on 2021/10/25.
//  Copyright © 2021 apple. All rights reserved.
//

#import "LanguageModel.h"

@implementation LanguageModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.zid=@"zid";
    }
    return self;
}

//主键(查询的时候可通过这个参数值去查找)
+(NSString *)getPrimaryKey{
    return @"zid";
}




//获取多语言缓存信息
+(LanguageModel *)getLanguageModelFromDB{
    
    LanguageModel *sqlModel=[LanguageModel searchSingleWithWhere:nil orderBy:nil];

    return sqlModel;
}




///多语言支持类型
+ (NSMutableArray *)settingsLanguageInfoTableItemArray {
    LanguageModel * item = [LanguageModel.alloc init];
    item.languageType = LanguageTypeJapanese;
    item.serverLang = @"ja_jp";
    item.localLang = @"ja";
    item.showLanguageLang = @"日本語";
    LanguageModel * item1 = [LanguageModel.alloc init];
    item1.languageType = LanguageTypeChinese;
    item1.serverLang = @"zh_cn";
    item1.localLang = @"zh-Hans";
    item1.showLanguageLang = @"简体中文";
    
    LanguageModel * item2 = [LanguageModel.alloc init];
    item2.languageType = LanguageTypeEnglish;
    item2.serverLang = @"en_us";
    item2.localLang = @"en";
    item2.showLanguageLang = @"English";
    
    return [NSMutableArray arrayWithArray:@[item,item1,item2]];
}

///多语言支持类型
+ (LanguageModel *)getLanguageModelWithType:(LanguageType)language {
    NSMutableArray * array = [self settingsLanguageInfoTableItemArray];
    for (LanguageModel * languageModel  in array) {
        if (languageModel.languageType == language) {
            return languageModel;
        }
    }
    return nil;
}



@end
