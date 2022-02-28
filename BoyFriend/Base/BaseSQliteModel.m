//
//  BaseSQliteModel.m
//  Demon
//
//  Created by apple on 2019/1/30.
//  Copyright © 2019年 BoyFriend. All rights reserved.
//

#import "BaseSQliteModel.h"

@implementation BaseSQliteModel
/* 可选的
 +(void)dbDidCreateTable:(LKDBHelper*)helper tableName:(NSString*)tableName;
 +(void)dbDidAlterTable:(LKDBHelper*)helper tableName:(NSString*)tableName addColumns:(NSArray*)columns;
 
 +(BOOL)dbWillInsert:(NSObject*)entity;
 +(void)dbDidInserted:(NSObject*)entity result:(BOOL)result;
 
 +(BOOL)dbWillUpdate:(NSObject*)entity;
 +(void)dbDidUpdated:(NSObject*)entity result:(BOOL)result;
 
 +(BOOL)dbWillDelete:(NSObject*)entity;
 +(void)dbDidDeleted:(NSObject*)entity result:(BOOL)result;
 
 ///data read finish
 +(void)dbDidSeleted:(NSObject*)entity;
 
 */
//重载选择 使用的LKDBHelper
+(LKDBHelper *)getUsingLKDBHelper{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *bid=BFAppBundleId;
        bid = [bid stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSString *dbpath =  [BFPathTools docPath];
        dbpath=[NSString stringWithFormat:@"%@/%@.db",dbpath,bid];
        //        NSString* dbpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Demon.db"];
        db = [[LKDBHelper alloc]initWithDBPath:dbpath];
        //        db = [[LKDBHelper alloc]init];
    });
    return db;
}


//将要插入数据库
+(BOOL)dbWillInsert:(NSObject *)entity{
    return YES;
}

////主键(查询的时候可通过这个参数值去查找)
//+(NSString *)getPrimaryKey
//{
//    return @"id";
//}

//表名
+(NSString *)getTableName{
    return NSStringFromClass([self class]);
}



+(int)getTableVersion{
    return 1;
}
@end
