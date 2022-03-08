/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

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
