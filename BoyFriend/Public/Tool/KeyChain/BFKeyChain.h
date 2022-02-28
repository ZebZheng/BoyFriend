//
//  BFKeyChain.h
//  WanShoes
//
//  Created by BoyFriend on 2017/5/17.
//  Copyright © 2017年 WXYS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEVICE_ONLY_KEY             (@"DEVICE_ONLY_KEY")    //设备唯一标识key

@interface BFKeyChain : NSObject

/**
*  存储字符串到 KeyChain
*
*  @param string  content
*  @param key     key
*/
+ (void)keyChainSave:(NSString *)string key:(NSString *)key;

/**
 *  从 KeyChain 中读取存储的字符串
 *
 *  @param key key
 *
 *  @return content
 */
+ (NSString *)keyChainLoadWithKey:(NSString *)key;

/**
 *  从 KeyChain 中删除某个key与value
 */
+ (void)keyChainDeleteWithKey:(NSString *)key;

/**
 *  删除整个 KeyChain 信息
 */
+ (void)keyChainDelete;

@end
