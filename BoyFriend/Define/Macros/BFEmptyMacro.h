/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#ifndef BFEmptyMacro_h
#define BFEmptyMacro_h
#import "NSString+BFAdd.h"
/**
 字符串判空
 */
#ifndef BFStringIsEmpty
#define BFStringIsEmpty(string)         ([NSString bf_judgeEmpty:(string)])
#endif

#ifndef BFStringNotEmpty
#define BFStringNotEmpty(string)        (!BFStringIsEmpty(string))
#endif
/**
 数组判空
 @param array 数组
 @return 是否为空
 */
#ifndef BFArrayIsEmpty
#define BFArrayIsEmpty(array)            (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0 ? YES : NO)
#endif

#ifndef BFArrayNotEmpty
#define BFArrayNotEmpty(array)           (!BFArrayIsEmpty(array))
#endif
/**
 字典判空
 @param dictionary 字典
 @return 是否为空
 */
#ifndef BFDictionaryIsEmpty
#define BFDictionaryIsEmpty(dictionary)      (dictionary == nil || [dictionary isKindOfClass:[NSNull class]] || dictionary.allKeys.count == 0? YES : NO)
#endif
#ifndef BFDictionaryNotEmpty
#define BFDictionaryNotEmpty(dictionary)     (!BFDictionaryIsEmpty(dictionary))
#endif
/**
 对象判空

 @param object 对象
 @return 是否为空
 */
#ifndef BFObjectIsEmpty
#define BFObjectIsEmpty(object)  (object == nil||[object isKindOfClass:[NSNull class]]||([object respondsToSelector:@selector(length)] && [(NSData *)object length] == 0)|| ([object respondsToSelector:@selector(count)] && [(NSArray *)object count] == 0)?YES:NO)
#endif
#ifndef BFObjectNotEmpty
#define BFObjectNotEmpty(object)       (!BFObjectIsEmpty(object))
#endif

#endif /* BFEmptyMacro_h */
