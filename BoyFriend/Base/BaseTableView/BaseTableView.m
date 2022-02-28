//
//  BaseTableView.m
//  Demon
//
//  Created by IMAC-2 on 2022/2/24.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView ()


@property (nonatomic,strong) MJRefreshNormalHeader *refreshHeader;

@property (nonatomic,strong) MJRefreshBackNormalFooter *refreshFooter;

@property (nonatomic, strong) MJRefreshGifHeader *gifRefreshHeader;


@end

@implementation BaseTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        //解决UITableView在cell比较少的情况下不显示下面的分割线条
        self.tableFooterView = [[UIView alloc] init];
        [self setLayoutMargins:UIEdgeInsetsMake(0, BFRatio(15), 0, 0)];
        [self setSeparatorColor:BFRGB_Line];
        [self setSeparatorInset:UIEdgeInsetsMake(0, BFRatio(15), 0, 0)];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor whiteColor];
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
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
        _refreshFooter.stateLabel.hidden=YES;
    }
    return _refreshFooter;
}


@end
