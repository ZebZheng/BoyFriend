/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "NSArray+BFAdd.h"

@implementation NSArray (BFAdd)

- (NSArray *)bf_removeDuplicate {
    NSSet * set = [NSSet setWithArray:self];
    return [set allObjects];
}




@end
