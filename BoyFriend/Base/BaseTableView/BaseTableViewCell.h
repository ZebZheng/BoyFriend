//
//  BaseTableViewCell.h
//  Demon
//
//  Created by BoyFriend on 2017/11/9.
//  Copyright © 2017年 BoyFriend. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

- (void)initSubviews;

- (void)makeContraints;

- (void)setupWithData:(id)data;

+(NSString *)reuseIdentifier;
@end
