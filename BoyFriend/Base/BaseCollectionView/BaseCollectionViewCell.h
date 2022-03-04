//
//  BaseCollectionViewCell.h
//  Demon
//
//  Created by apple on 2020/2/15.
//  Copyright © 2020 BoyFriend. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewCell : UICollectionViewCell

- (void)bf_initSubviews;

- (void)bf_makeContraints;

- (void)bf_setupWithData:(id)data;

+(NSString *)bf_reuseIdentifier;


@end

NS_ASSUME_NONNULL_END
