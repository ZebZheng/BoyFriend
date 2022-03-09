//
//  NSString+BFLoad.m
//  BoyFriend
//
//  Created by IMAC-1 on 2022/3/9.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "NSString+BFLoad.h"

@implementation NSString (BFLoad)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ///stringByAppendingString
        Method stringByString_originalMethod = class_getInstanceMethod(self, @selector(stringByAppendingString:));
        Method stringByString_swizzledMethod = class_getInstanceMethod(self, @selector(bf_stringByAppendingString:));
        method_exchangeImplementations(stringByString_originalMethod, stringByString_swizzledMethod);
        
        ///stringWithFormat
        Method stringWithFormat_originalMethod = class_getInstanceMethod(self, @selector(stringWithFormat:));
        Method stringWithFormat_swizzledMethod = class_getInstanceMethod(self, @selector(bf_stringWithFormat:));
        method_exchangeImplementations(stringWithFormat_originalMethod, stringWithFormat_swizzledMethod);
        
        
    });
}
///使用stringByAppendingString拼接时防止传空崩溃
- (NSString *)bf_stringByAppendingString:(NSString *)aString {
    NSString * aS = aString;
    if (aS == nil || aS == NULL || [aS isKindOfClass:[NSNull class]]) {
        aString = @"(null)";
    }
    return [NSString stringWithFormat:@"%@%@",self,aString];
}
///使用stringWithFormat拼接时防止传空崩溃
+ (instancetype)bf_stringWithFormat:(NSString *)format, ... {
    va_list arg;
    va_start (arg, format);
    NSString *hasNullStr = [[NSString alloc] initWithFormat:format arguments:arg];
    va_end (arg);
    hasNullStr = [hasNullStr stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    return hasNullStr;
}

@end
