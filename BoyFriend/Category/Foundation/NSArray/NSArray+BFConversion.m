/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "NSArray+BFConversion.h"

@implementation NSArray (BFConversion)
- (NSString *)bf_toString {
    return [self bf_toStringBy:@","];
}
- (NSString *)bf_toStringBy:(NSString *)string {
    return [self componentsJoinedByString:string];
}
@end
