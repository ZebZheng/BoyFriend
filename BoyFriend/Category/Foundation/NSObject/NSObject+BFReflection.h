//
//  NSObject+Reflection.h
//  NSObject-Reflection
//
//  Created by Jakey on 15/12/22.
//  Copyright © 2015年 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BFReflection)
//类名
- (NSString *)bf_className;
+ (NSString *)bf_className;
//父类名称
- (NSString *)bf_superClassName;
+ (NSString *)bf_superClassName;

//实例属性字典
-(NSDictionary *)bf_propertyDictionary;

//属性名称列表
- (NSArray*)bf_propertyKeys;
+ (NSArray *)bf_propertyKeys;

//属性详细信息列表
- (NSArray *)bf_propertiesInfo;
+ (NSArray *)bf_propertiesInfo;

//格式化后的属性列表
+ (NSArray *)bf_propertiesWithCodeFormat;

//方法列表
-(NSArray*)bf_methodList;
+(NSArray*)bf_methodList;

-(NSArray*)bf_methodListInfo;

//创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)bf_registedClassList;
//实例变量
+ (NSArray *)bf_instanceVariable;

//协议列表
-(NSDictionary *)bf_protocolList;
+ (NSDictionary *)bf_protocolList;


- (BOOL)bf_hasPropertyForKey:(NSString*)key;
- (BOOL)bf_hasIvarForKey:(NSString*)key;

@end
