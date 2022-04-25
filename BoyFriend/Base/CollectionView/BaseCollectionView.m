//
//  BaseCollectionView.m
//  Demon
//
//  Created by IMAC-2 on 2022/2/25.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BaseCollectionView.h"


@interface BaseCollectionView ()

@property (nonatomic,strong) MJRefreshNormalHeader *refreshHeader;

@property (nonatomic,strong) MJRefreshBackNormalFooter *refreshFooter;

@property (nonatomic,strong) MJRefreshGifHeader *gifRefreshHeader;

@end

@implementation BaseCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        self.alwaysBounceVertical = YES;//当不够一屏的话也能滑动
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
 
        
    }
    return self;
}

- (void)setIsUseRefreshHeader:(BOOL)isUseRefreshHeader{
    _isUseRefreshHeader = isUseRefreshHeader;
    if (isUseRefreshHeader) {
        self.mj_header = self.gifRefreshHeader;
    }

}

- (void)setIsUseRefreshFooter:(BOOL)isUseRefreshFooter{
    _isUseRefreshFooter = isUseRefreshFooter;
    if (isUseRefreshFooter) {
        self.mj_footer=self.refreshFooter;
    }
}

-(MJRefreshNormalHeader*)refreshHeader{
    if (_refreshHeader == nil) {
        @weakify(self)
        _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            BFBlock_Safe_Calls(self.refreshHeaderBlock);
        }];
    }
    return _refreshHeader;
}

- (MJRefreshGifHeader *)gifRefreshHeader {
    if (_gifRefreshHeader == nil) {
        @weakify(self)
        _gifRefreshHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            @strongify(self)
            BFBlock_Safe_Calls(self.refreshHeaderBlock);
        }];
        //        _gifRefreshHeader.backgroundColor = DEFAULT_BACKGROUND_COLOR;
        [_gifRefreshHeader setTitle:@"                   再下拉一点" forState:(MJRefreshStateIdle)];
        [_gifRefreshHeader setTitle:@"                   快松开，疼" forState:(MJRefreshStatePulling)];
        [_gifRefreshHeader setTitle:@"                   正在刷新中" forState:(MJRefreshStateRefreshing)];
        
        [_gifRefreshHeader setImages:@[BFImageName(@"RefreshStateIdle_icon")] duration:0.15 forState:MJRefreshStateIdle];
        [_gifRefreshHeader setImages:@[BFImageName(@"RefreshStatePulling_icon")] duration:0.15 forState:MJRefreshStatePulling];
        [_gifRefreshHeader setImages:@[BFImageName(@"RefreshStateRefreshing1_icon"), BFImageName(@"RefreshStateRefreshing2_icon"), BFImageName(@"RefreshStateRefreshing3_icon"), BFImageName(@"RefreshStateRefreshing4_icon"), BFImageName(@"RefreshStateRefreshing5_icon")] duration:0.5 forState:MJRefreshStateRefreshing];
        
        _gifRefreshHeader.labelLeftInset = -BFRatio(60);
        
        _gifRefreshHeader.lastUpdatedTimeLabel.hidden = YES;
    }
    return _gifRefreshHeader;
}

-(MJRefreshBackNormalFooter*)refreshFooter{
    if (_refreshFooter == nil) {
        @weakify(self)
        _refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            BFBlock_Safe_Calls(self.refreshFooterBlock);
        }];
        //隐藏提示语
//        _refreshFooter.stateLabel.hidden=YES;
    }
    return _refreshFooter;
}


@end
