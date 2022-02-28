

#import <Foundation/Foundation.h>


#define BFLocalizedString(KEY) [[NSBundle mainBundle] localizedStringForKey:KEY value:nil table:@"Localizable"]


NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (BFLanguage)

+ (void)bf_setLanguage:(NSString *)language;

+ (NSString *)bf_currentLanguage;

@end

NS_ASSUME_NONNULL_END
