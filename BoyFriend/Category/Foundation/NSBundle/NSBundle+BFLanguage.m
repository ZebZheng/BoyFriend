

#import "NSBundle+BFLanguage.h"
#import <objc/runtime.h>

static NSString *const BFLanguageKey = @"AppLanguagesKey";

@interface BundleEx : NSBundle

@end

@implementation BundleEx

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    
    // 当前语言
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:BFLanguageKey];
    
    // 设置默认语言
    currentLanguage = currentLanguage ? currentLanguage : @"en";
    
    // 每次需要从语言包查询语言键值对的时候，都按照当前语言取出当前语言包
    NSBundle *currentLanguageBundle = [BundleEx cl_mainBundle];
    
    // 下面return中普通 bundle 在调用 localizedStringForKey: 方法时不会循环调用，虽然我们重写了 mainBundle 单例的 localizedStringForKey: 方法，但是我们只修改了 mainBundle 单例的isa指针指向，
    // 也就是说只有 mainBundle 单例在调用 localizedStringForKey: 方法时会走本方法，而其它普通 bundle 不会。
    return currentLanguageBundle ? [currentLanguageBundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}

+ (NSBundle *)cl_mainBundle {
    if ([NSBundle bf_currentLanguage].length) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSBundle bf_currentLanguage] ofType:@"lproj"];
        if (path.length) {
            return [NSBundle bundleWithPath:path];
        }
    }
    return nil;
}



@end


@implementation NSBundle (BFLanguage)


+ (void)load {
    static dispatch_once_t onceToken;
    
    // 保证只修改一次 mainBundle 单例的isa指针指向
    dispatch_once(&onceToken, ^{
        // 让 mainBundle 单例的isa指针指向 BundleEx 类
        object_setClass([NSBundle mainBundle], [BundleEx class]);
    });
}

+ (void)bf_setLanguage:(NSString *)language {
    // 将当前手动设置的语言存起来
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:BFLanguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSString *)bf_currentLanguage {
    // 当前语言
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:BFLanguageKey];
    // 设置默认语言
    currentLanguage = currentLanguage ? currentLanguage : @"en";
    
    return currentLanguage;
}
@end
