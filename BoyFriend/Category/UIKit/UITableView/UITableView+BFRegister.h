//
//  UITableView+BFRegister.h
//  BoyFriend
//
//  Created by 祎 on 2022/3/15.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (BFRegister)

//MARK: - 标识
+ (NSString *)bf_reuseIdentifier;

@end

@interface UITableView (BFRegister)

/**
 快速注册cell 根据传入的cellName自动判断是注册的xib还是Class
 @param cell cell的class 或者cell字符串
 */
- (void)bf_registerCell:(id)cell;

/**
 快速获取cell 可以不用注册 内部自动判断是否注册 未注册自动注册
 @param cell cell的class 或者cell字符串 (推荐用class类型)
 @param indexPath 对应的NSIndexPath
 @return cell
 */
- (id)bf_dequeueReusableCell:(id)cell forIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
