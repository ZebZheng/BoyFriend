/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "UIFont+BFFont.h"

@implementation UIFont (BFFont)

+(void)load {
    //获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    //获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    //然后交换类方法
    method_exchangeImplementations(newMethod, method);
    
    
    //获取替换后的类方法
    Method newMethod1 = class_getClassMethod([self class], @selector(adjustBoldFont:));
    //获取替换前的类方法
    Method method1 = class_getClassMethod([self class], @selector(boldSystemFontOfSize:));
    //然后交换类方法
    method_exchangeImplementations(newMethod1, method1);
    
    
    //获取替换后的类方法
    Method newMethod2 = class_getClassMethod([self class], @selector(adjustfontWithName:size:));
    //获取替换前的类方法
    Method method2 = class_getClassMethod([self class], @selector(fontWithName:size:));
    //然后交换类方法
    method_exchangeImplementations(newMethod2, method2);
    
}

+(UIFont *)adjustFont:(CGFloat)fontSize {
    UIFont *newFont=nil;
    newFont = [UIFont adjustFont:fontSize * [UIScreen mainScreen].bounds.size.width/BFYourUIScreen];
    return newFont;
}



+(UIFont *)adjustBoldFont:(CGFloat)fontSize {
    UIFont *newFont=nil;
    newFont = [UIFont adjustBoldFont:fontSize * [UIScreen mainScreen].bounds.size.width/BFYourUIScreen];
    return newFont;
}


+(UIFont *)adjustfontWithName:(NSString *)name size:(CGFloat)fontSize {
    UIFont *newFont=nil;
    newFont = [UIFont adjustfontWithName:name size:fontSize * [UIScreen mainScreen].bounds.size.width/BFYourUIScreen];
    return newFont;
}

@end
