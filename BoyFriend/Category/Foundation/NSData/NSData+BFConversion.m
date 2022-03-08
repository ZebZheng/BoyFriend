/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "NSData+BFConversion.h"

@implementation NSData (BFConversion)
///转成字符串
- (NSString *)bf_toString {
    return [[NSString alloc]initWithData:self encoding:NSUTF8StringEncoding];
}
@end
