//
//  BaseUserSQliteModel.m
//  Demon
//
//  Created by apple on 2021/2/7.
//  Copyright © 2021 BoyFriend. All rights reserved.
//

#import "BaseUserSQliteModel.h"

static dispatch_once_t onceToken;

@implementation BaseUserSQliteModel


//重载选择 使用的LKDBHelper
+(LKDBHelper *)getUsingLKDBHelper{
    static LKDBHelper* db;
    dispatch_once(&onceToken, ^{
        NSString *bid=[DataLibrery shareInstance].loginUserId;
        if ([BFStringTools isEmpty:bid]) {
            bid = @"noUserID";
        }
        NSString *dbpath =  [BFPathTools docPath];
        dbpath=[NSString stringWithFormat:@"%@/%@.db",dbpath,bid];
        db = [[LKDBHelper alloc]initWithDBPath:dbpath];
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

// 退出登录销毁单例
+ (void)tearDown {
    onceToken = 0l;
}


@end
