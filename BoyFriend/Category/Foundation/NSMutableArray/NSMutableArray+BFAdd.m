/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/


#import "NSMutableArray+BFAdd.h"

@implementation NSMutableArray (BFAdd)

- (NSMutableArray *)bf_removeDuplicates {
    NSSet * set = [NSSet setWithArray:self];
    NSMutableArray * array = [NSMutableArray arrayWithArray:set.allObjects];
    return array;
}

@end
