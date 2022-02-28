//
//  UIView+PlaceholderView.h
//  LLHBaseProject
//
//  Created by 123456 on 2017/11/17.
//  Copyright © 2017年 llh. All rights reserved.
//

/*调用
 [self.view showPlaceholderViewWithType:PlaceholderViewTypeNoNet reloadBlock:^{
        [MBProgressHUD showInfoMessage:@"重新加载按钮点击"];
 }];
 
 */

#import <UIKit/UIKit.h>
/** UIView的占位图类型 */
typedef NS_ENUM(NSInteger, BFPlaceholderViewType) {
    /** 404 且没有按钮 */
    BFPlaceholderViewType404NoButton,
    /** 暂无网络 */
    BFPlaceholderViewTypeNoNet,
    /** 列表为空 */
    BFPlaceholderViewTypeNoList
};
@interface UIView (BFPlaceholderView)

/**** 占位图 ******/
@property (nonatomic, strong) UIView *bf_placeholderView;
/**** 占位图上面的imageview ****/
@property (nonatomic,strong) UIImageView *bf_placeholderImageView;
/**** 占位图上面的描述 ****/
@property (nonatomic,strong) UILabel *bf_placeholderDescLabel;


#pragma mark - 展示占位图

/**
 展示UIView及其子类的占位图，大小和view一样（本质是在这个view上添加一个自定义view）
 
 @param type 占位图类型
 @param reloadBlock 重新加载回调的block
 */
- (void)bf_showPlaceholderViewWithType:(BFPlaceholderViewType)type reloadBlock:(void(^)(void))reloadBlock;

#pragma mark - 主动移除占位图
/**
 主动移除占位图
 占位图会在你点击“重新加载”按钮的时候自动移除，你也可以调用此方法主动移除
 */
- (void)bf_removePlaceholderView;
@end
