//
//  UITableView+BFRegister.m
//  BoyFriend
//
//  Created by 祎 on 2022/3/15.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "UITableView+BFRegister.h"

@implementation UITableViewCell (BFRegister)

///标识
+ (NSString *)bf_reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end


@implementation UITableView (BFRegister)

- (void)bf_registerCell:(id)cell {
    NSString *cellName = [self _getCellName:cell];
    NSString *reuseIdentifier = [NSString stringWithFormat:@"%@", cellName];
    if ([self bf_getNibPath:cellName]) {
        [self registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    } else {
        [self registerClass:NSClassFromString(cellName) forCellReuseIdentifier:reuseIdentifier];
    }
}

- (id)bf_dequeueReusableCell:(id)cell forIndexPath:(NSIndexPath *)indexPath {
    NSString *cellName = [self _getCellName:cell];
    NSString *reuseIdentifier = [NSString stringWithFormat:@"%@", cellName];
    UITableViewCell *newCell = [self dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (newCell == nil) {
        [self bf_registerCell:cell];
    }
    return [self dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
}

///获取cell名
- (NSString *)_getCellName:(id)cell {
    NSString *cellName;
    if ([cell isKindOfClass:[NSString class]]) {
        cellName = cell;
    } else {
        cellName = NSStringFromClass(cell);
    }
    return  cellName;
}

/// 通过判断nib是否存在来确认注册方式
- (BOOL)bf_getNibPath:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"nib"];
    // 路径不存在
    if (path == nil) {
        return NO;
    } else { // 路径存在
        return YES;
    }
}

@end
