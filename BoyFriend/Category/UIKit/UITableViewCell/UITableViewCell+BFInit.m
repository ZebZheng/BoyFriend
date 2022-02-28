/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "UITableViewCell+BFInit.h"

@implementation UITableViewCell (BFInit)
///标识
+ (NSString *)bf_reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
