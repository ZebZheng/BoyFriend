//
//  BaseCollectionViewModel.m
//  Demon
//
//  Created by IMAC-2 on 2022/2/25.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BaseCollectionViewModel.h"


@interface BaseCollectionViewModel ()

@property (nonatomic ,assign)BOOL isLoading;//判断是否在加载

@end

@implementation BaseCollectionViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isLoading = YES;
    }
    return self;
}


#pragma mark - 请求

//下拉刷新数据
-(void)refreshHeaderAction{
    self.isLoading = YES;
    [self refreshData];
}
//下拉 请求接口(子类在这边请求数据,请求到结果需要调dataSetWithPageNow)
-(void)refreshData{
    self.endRefreshing = YES;
}
//判断是否是最后一页,是最后一页显示最后一页的数据(当前页   总页数)
-(void)dataSetWithPageNow:(NSInteger )pageNow Count:(NSInteger)count{
    self.pageNow=pageNow;
    self.count=count;
    self.endRefreshing = YES;
    BFBlock_Safe_Calls(self.requestSuccessBlock,pageNow,count);
    self.isLoading = NO;
}
//上提刷新数据
-(void)refreshFootAction{
    if (self.pageNow==self.count) {
        self.endRefreshing = YES;
        return;
    }
    self.isLoading = YES;
    [self getMoreData];
}
//上提 请求接口(子类在这边请求数据,请求到结果需要调dataSetWithPageNow)
-(void)getMoreData{
    self.endRefreshing = YES;
}



#pragma mark - 代理
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count;
}
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    return cell;
}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}
//对头视图或者尾视图进行设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if (kind == UICollectionElementKindSectionHeader) {
//
//    }
    return nil;
}
//定义每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width)/2 - 2, (([UIScreen mainScreen].bounds.size.width)/2 - 2)*1.6);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0.0,0,0.0,0);
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0f;
}
//每个section中不同的item之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0f;
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isLoading == YES) {
        return;
    }
    if (self.isAutoRequestMore == NO) {
        return;
    }
    if (self.pageNow >= self.count) {
        return;
    }
    NSInteger ysygs = indexPath.section  * self.dataSource.count + indexPath.row;
    NSInteger zgs = 0;
    if ([self.dataSource.firstObject isKindOfClass:[NSArray class]]) {
        NSMutableArray * arr = self.dataSource.firstObject;
        zgs = self.dataSource.count * arr.count;
    }else{
        zgs = self.dataSource.count;
    }
    // 80%出现后，需要去加载数据
    if (ysygs > zgs * 0.8) {
        self.isLoading = YES;
        [self getMoreData];
    }
    
}

#pragma mark - 懒加载
-(NSMutableArray *)dataSource{
    if (_dataSource==nil) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}

@end
