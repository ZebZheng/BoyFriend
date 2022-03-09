//
//  BaseTableViewCell.h
//  Demon
//
//  Created by BoyFriend on 2017/11/9.
//  Copyright © 2017年 BoyFriend. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

- (void)bf_initSubviews;

- (void)bf_makeContraints;

- (void)bf_setupWithData:(id)data;

@end
