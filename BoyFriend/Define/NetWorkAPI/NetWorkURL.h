//
//  NetWorkURL.h
//  Demon
//
//  Created by BoyFriend on 16/2/16.
//  Copyright © 2016年 BoyFriend. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkEnvironment.h"


/**
 *  服务端错误码
 */
typedef NS_ENUM(NSInteger, Server_Code) {
    Server_Code_0 =  0, //成功";
    Server_Code_Minus1 =  -1, //服务端请求异常";
    Server_Code_Minus1009 =  -1009, //网络错误
    Server_Code_4003 =  4003, //token失效";

};

@interface NetWorkURL : NSObject

+ (NetWorkURL *)sharedInstance;

///api环境
@property(nonatomic,strong)NetWorkEnvironment * environmentModel;



///获取图片完整路径
- (NSString *)getImageFullUrl:(NSString *)string ;

///获取错误信息
- (NSString *)getServerErrorWithCode:(NSInteger )code Info:(NSString *)info;



@end
