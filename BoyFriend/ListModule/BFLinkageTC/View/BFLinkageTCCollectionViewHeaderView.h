//
//  BFLinkageTCCollectionViewHeaderView.h
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/29.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BFLinkageTCCollectionViewHeaderView : UICollectionReusableView

@property (nonatomic, strong) UILabel *headTitleLabel;


//复用cell复用标识
+(NSString *)bf_reuseIdentifier;

- (void)bf_setupWithData:(id)data;

@end


NS_ASSUME_NONNULL_END
