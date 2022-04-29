//
//  BFListModuleViewModel.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/27.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFListModuleViewModel.h"
#import "BFListModuleCell.h"

@interface BFListModuleViewModel ()


@end

@implementation BFListModuleViewModel



//MARK: - 下拉
-(void)refreshData{
    BFListModuleInfoModel * model1 = [[BFListModuleInfoModel alloc]init];
    model1.name = @"轮播滚动视图";
    model1.indexInteger = 1;
    
    BFListModuleInfoModel * model2 = [[BFListModuleInfoModel alloc]init];
    model2.name = @"分段选择器-居左";
    model2.indexInteger = 2;
    
    BFListModuleInfoModel * model3 = [[BFListModuleInfoModel alloc]init];
    model3.name = @"分段选择器-居中";
    model3.indexInteger = 3;
    
    BFListModuleInfoModel * model4 = [[BFListModuleInfoModel alloc]init];
    model4.name = @"分段选择器-导航栏";
    model4.indexInteger = 4;
    
    BFListModuleInfoModel * model5 = [[BFListModuleInfoModel alloc]init];
    model5.name = @"二级联动-tableview-tableview";
    model5.indexInteger = 5;
    
    BFListModuleInfoModel * model6 = [[BFListModuleInfoModel alloc]init];
    model6.name = @"二级联动-tableview-collectionview";
    model6.indexInteger = 6;
    
    BFListModuleInfoModel * model7 = [[BFListModuleInfoModel alloc]init];
    model7.name = @"仿微信朋友圈";
    model7.indexInteger = 7;
    
    NSArray * arrModel = @[model1,model2,model3,model4,model5,model6,model7];
    [self.dataSource addObject:arrModel];
    self.reloadTableView = YES;
    [self dataSetWithPageNow:1 Count:1];
    
   
}


#pragma mark - 协议
//MARK: - UITableViewDelegate, UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFListModuleInfoModel * infoModel = [[self.dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    BFListModuleCell * cell = [tableView dequeueReusableCellWithIdentifier:[BFListModuleCell bf_reuseIdentifier]];
    if(cell==nil){
        cell=[[BFListModuleCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:[BFListModuleCell bf_reuseIdentifier]];
    }
    [cell bf_setupWithData:infoModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFListModuleInfoModel * infoModel = [[self.dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    BFBlock_Safe_Calls(self.didSelectRowBlock,infoModel);
}


@end
