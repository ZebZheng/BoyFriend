/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */
#ifndef BFSystemMacro_h
#define BFSystemMacro_h

// 系统版本
// iPhone5 iPhone5s iPhoneSE
#ifndef IS_iPhone_55sSE
    #define IS_iPhone_55sSE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

// iPhone6 7 8
#ifndef IS_iPhone_6789
    #define IS_iPhone_6789 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
#endif

// iPhone6plus  iPhone7plus iPhone8plus
#ifndef IS_iPhone678_Plus
    #define IS_iPhone678_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#endif

// iPhoneX
#ifndef IS_iPhoneX
    #define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

#pragma mark ---- iOS 版本 定义 --------
//操作系统版本
#ifndef BFSYSTEMVERSION
#define BFSYSTEMVERSION   [UIDevice currentDevice].systemVersion
#endif

//大于多少版本
#ifndef iOS7OrLater
#define iOS7OrLater ([BFSYSTEMVERSION floatValue] >= 7.0)
#endif
#ifndef iOS8OrLater
#define iOS8OrLater ([BFSYSTEMVERSION floatValue] >= 8.0)
#endif
#ifndef iOS9OrLater
#define iOS9OrLater ([BFSYSTEMVERSION floatValue] >= 9.0)
#endif
#ifndef iOS10OrLater
#define iOS10OrLater ([BFSYSTEMVERSION floatValue] >= 10.0)
#endif
#ifndef iOS11OrLater
#define iOS11OrLater ([BFSYSTEMVERSION floatValue] >= 11.0)
#endif
#ifndef iOS12OrLater
#define iOS12OrLater ([BFSYSTEMVERSION floatValue] >= 12.0)
#endif
#ifndef iOS13OrLater
#define iOS13OrLater ([BFSYSTEMVERSION floatValue] >= 13.0)
#endif
#ifndef iOS14OrLater
#define iOS14OrLater ([BFSYSTEMVERSION floatValue] >= 14.0)
#endif
#ifndef iOS15OrLater
#define iOS15OrLater ([BFSYSTEMVERSION floatValue] >= 15.0)
#endif

// 系统版本的判断  < > =
#ifndef BFSYSTEM_VERSION_EQUAL_TO
#define BFSYSTEM_VERSION_EQUAL_TO(v)                  ([BFSYSTEMVERSION compare:v options:NSNumericSearch] == NSOrderedSame)
#endif
#ifndef BFSYSTEM_VERSION_GREATER_THAN
#define BFSYSTEM_VERSION_GREATER_THAN(v)              ([BFSYSTEMVERSION compare:v options:NSNumericSearch] == NSOrderedDescending)
#endif
#ifndef BFSYSTEM_VERSION_GREATER_THAN_OR_EQUAL
#define BFSYSTEM_VERSION_GREATER_THAN_OR_EQUAL(v)  ([BFSYSTEMVERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#endif
#ifndef BFSYSTEM_VERSION_LESS_THAN
#define BFSYSTEM_VERSION_LESS_THAN(v)                 ([BFSYSTEMVERSION compare:v options:NSNumericSearch] == NSOrderedAscending)
#endif
#ifndef BFSYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO
#define BFSYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([BFSYSTEMVERSION compare:v options:NSNumericSearch] != NSOrderedDescending)
#endif

//  iOS 支持
#ifndef BFSUPPORT_IPHONE_OS_VERSION
#define BFSUPPORT_IPHONE_OS_VERSION(version) ( __IPHONE_OS_VERSION_MIN_REQUIRED <= version && __IPHONE_OS_VERSION_MAX_ALLOkED >= version)
#endif

// 设置Debug模式下打印log,release模式下不打印
#ifdef DEBUG
#define BFDEBUG(FORMAT, ...) fprintf(stderr, "🐲[DEBUG](SEL:)%s(Line:)%d\n(Content:)%s\n\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__]UTF8String]);
#else
#define BFDEBUG(FORMAT, ...) nil
#endif


#endif /* BFSystemMacro_h */
