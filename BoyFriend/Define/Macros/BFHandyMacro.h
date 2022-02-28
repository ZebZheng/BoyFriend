/*
 Created by BF on 2021
 Copyright © 2021年 BF. All rights reserved.
 */

#ifndef BFHandyMacro_h
#define BFHandyMacro_h

/// url
#define BFURL_With_String(urlString)        [NSURL URLWithString:urlString]
/// int转字符串
#define BFInt_To_String(i)                  [NSString stringWithFormat:@"%d",i]
/// integer转字符串
#define BFInteger_To_String(i)              [NSString stringWithFormat:@"%zd",i]
/// longint转字符串
#define BFLongInt_To_String(i)              [NSString stringWithFormat:@"%zd",i]
/// double转字符串
#define BFDouble_To_String(i)               [NSString stringWithFormat:@"%f",i]
/// 字符串拼接
#define BFString_With_Format(str)           [NSString stringWithFormat:@"%@",str]
/// 图片
#define BFImageName(name)                   [UIImage bf_imageWithName:name]

/// 读取本地图片(找放在目录下的文件,放在asset找不到)  性能高
#define BFImageLocalNameType(file,type)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]

/// 定义UIImage对象(找放在目录下的文件,放在asset找不到)  性能高
#define BFImageLocalName(file)                   [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:nil]]



#pragma mark - 字体

#define BFSysFontWithSizes(s)     [UIFont systemFontOfSize:(s)]
#define BFSysFontBoldWithSizes(s) [UIFont boldSystemFontOfSize:(s)]


#define BFIconFontWithSizes(s)      BFIconFontNameAndSize(@"",s)
#define BFIconFontNameAndSizes(name,s)  (name.length>0?[UIFont fontWithName:name size:(s)]:[UIFont fontWithName:@"iconfont" size:(s)])


#define BFFontNameAndSizes(name,s) [UIFont fontWithName:name size:(s)]
#define BFPFRFontWithSizes(s)      [UIFont fontWithName:@"PingFangSC-Regular" size:(s)]
#define BFPFMFontWithSizes(s)      [UIFont fontWithName:@"PingFangSC-Medium" size:(s)]
#define BFPFTFontWithSizes(s)      [UIFont fontWithName:@"PingFangSC-Thin" size:(s)]
#define BFPFSBFontWithSizes(s)     [UIFont fontWithName:@"PingFangSC-Semibold" size:(s)]
#define BFPFLFontWithSizes(s)      [UIFont fontWithName:@"PingFangSC-Light" size:(s)]
#define BFPFSCFontWithSizes(s)     [UIFont fontWithName:@"PingFangSC" size:(s)]


/// 单例宏
#ifndef BFSINGLETON_H
#define BFSINGLETON_H \
+ (instancetype)standard;
#endif
#ifndef BFSINGLETON_M
#define BFSINGLETON_M  \
static id _instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
+ (instancetype)standard \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
    return _instance; \
}
#endif

/// push跳转
#ifndef  BFPushViewController
#define  BFPushViewController(VC)        [self.navigationController pushViewController:VC animated:YES];
#endif

/// pop跳转
#ifndef  BFPopViewController
#define  BFPopViewController       [self.navigationController popViewControllerAnimated:YES];
#endif

/**
 *  安全地调用 block
 */
#ifndef BFBlock_Safe_Calls
#define BFBlock_Safe_Calls(block, ...) block ? block(__VA_ARGS__) : nil
#endif
#ifndef BFBlock_Safe_Calls_Main_Queue
#define BFBlock_Safe_Calls_Main_Queue(block, ...) block ? dispatch_async(dispatch_get_main_queue(), ^{ block(__VA_ARGS__); }) : nil
#endif


#pragma mark - 通知相关的
/*
 *  接收通知
 */
#define BFBIND_MSG_WITH_OBSERVER(OBSERVER, STRID, SELECTOR, OBJ)   [[NSNotificationCenter defaultCenter] addObserver:OBSERVER  \
selector:SELECTOR      \
name:STRID         \
object:OBJ];

#define BFBIND_MSG_WITH_OBJ(STRID, SELECTOR, OBJ)     BFBIND_MSG_WITH_OBSERVER(self, STRID, SELECTOR, OBJ);
#define BFBIND_MSG(STRID, SELECTOR)    BFBIND_MSG_WITH_OBSERVER(self, STRID, SELECTOR, nil);

/*
 *  发送通知
 */
#define BFPOST_MSG_WITH_OBJ_DICT(aName, anObject, aUserInfo)     [[NSNotificationCenter defaultCenter] \
postNotificationName:aName \
object:anObject \
userInfo:aUserInfo]

#define BFPOST_MSG_WITH_OBJ(aName, anObject)      BFPOST_MSG_WITH_OBJ_DICT(aName, anObject, nil)
#define BFPOST_MSG(aName)      BFPOST_MSG_WITH_OBJ_DICT(aName, nil, nil)

/*
 *  删除通知
 */
#define BFREMOVE_MSG(STRID)       [[NSNotificationCenter defaultCenter] removeObserver:self name:STRID object:nil];
#define BFREMOVE_ALL_MSG()        [[NSNotificationCenter defaultCenter] removeObserver:self]


#pragma mark - 生成 commonInit 方法
/**
 * 生成 commonInit 方法 (## 是两个宏的拼接)
 */
#define commonInitSafe(className)                   [self className ## _commonInit]
#define commonInitImplementationSafe(className)     -(void) className##_commonInit


#pragma mark - G－C－D
//异步其他并发队列
#define BFGCD_global(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
//异步主队列
#define BFGCD_main(block) dispatch_async(dispatch_get_main_queue(),block)


#pragma mark - 强引用 弱引用
#define BFWeakSelf  __weak typeof(self) weak_self = self;

#define BFWeak_Object(obj, weakObj)       __weak typeof(obj) weakObj = obj;
#define BFStrong_Object(weakObj,strongObj)  __strong typeof(weakObj) strongObj = weakObj;



/// 国际化
#define BFLocalString(str)       NSLocalizedString(str, nil)

/// 拨打电话
#define BFMakeCall(phoneNumber)  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];

/// MD5加密
#define BFMD5SS(string1,string2) [[NSString stringWithFormat:@"%@%@",string1,string2] md5String]










#pragma mark - 宏相关判断语句
//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//发布版本还是测试版本 (注意 #if RELEASE 没有这种写法   #if DEBUG  DEBUG是在Xcode默认的工程中已经定义好的  路径Xcode工程->TAGGETS->Build Setting->PreProcessor Macros)
#if DEBUG

#else

#endif

//预编译条件指令判断(要判断有没有这个宏  还要判断宏的值 是真 是假)
#if DEBUG
 //代码段1
#elif DEBUG
 //代码段2
#else
 //代码段 n+1
#endif

// 如果定义了macro_name宏就编译代码段1(只管有没有定义这个宏  不管里面的值是真还是假)
#ifdef macro_name
    //代码段1
#else
    //代码段2
#endif


#endif /* BFHandyMacro_h */
