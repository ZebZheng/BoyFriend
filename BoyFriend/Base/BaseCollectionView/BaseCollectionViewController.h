//
//  BaseCollectionViewController.h
//  Demon
//
//  Created by apple on 2020/2/15.
//  Copyright © 2020 BoyFriend. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseCollectionView.h"
#import "BaseCollectionViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>


/**
 *  初始化init的时候设置滚动方式才有效果  默认是垂直滚动
 *   (默认UICollectionViewScrollDirectionVertical)
 */
@property (nonatomic) UICollectionViewScrollDirection scrollDirection; // default is UICollectionViewScrollDirectionVertical

@property (nonatomic, strong) BaseCollectionView *collectionView;

@property (nonatomic, strong) BaseCollectionViewModel *collectionViewModel;


/**** 是否使用下拉刷新功能 ****/
@property (nonatomic) BOOL isUseRefreshHeader;
/**** 是否使用上提刷新功能 ****/
@property (nonatomic) BOOL isUseRefreshFooter;
/**** 是否自动预加载下一页功能 ****/
@property (nonatomic) BOOL isAutoRequestMore;


@end

NS_ASSUME_NONNULL_END
