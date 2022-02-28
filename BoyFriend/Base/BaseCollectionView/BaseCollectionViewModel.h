//
//  BaseCollectionViewModel.h
//  Demon
//
//  Created by IMAC-2 on 2022/2/25.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewModel : BaseViewModel

/**** 是否自动预加载下一页功能 ****/
@property (nonatomic) BOOL isAutoRequestMore;
/**** 页面数据 ****/
@property (nonatomic,strong) NSMutableArray *dataSource;
/**** 当前页数 ****/
@property (nonatomic,assign) NSInteger  pageNow;
/**** 总页数 ****/
@property (nonatomic,assign) NSInteger  count;


/// 结束刷新
@property (nonatomic,assign) BOOL endRefreshing;
/// 刷新列表
@property (nonatomic,assign) BOOL reloadCollectionView;
/// 请求成功 pageNow:当前页 count:总页
@property (nonatomic,copy) void (^requestSuccessBlock)(NSInteger pageNow, NSInteger count);




/// 下拉刷新事件
-(void)refreshHeaderAction;
/// 上提刷新事件
-(void)refreshFootAction;


//判断是否是最后一页,是最后一页显示最后一页的数据
-(void)dataSetWithPageNow:(NSInteger )pageNow Count:(NSInteger)count;




//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
//对头视图或者尾视图进行设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
//定义每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
//每个section中不同的item之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath;




@end

NS_ASSUME_NONNULL_END
