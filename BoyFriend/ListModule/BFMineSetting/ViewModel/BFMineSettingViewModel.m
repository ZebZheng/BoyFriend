//
//  BFMineViewModel.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/24.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFMineSettingViewModel.h"

@interface BFMineSettingViewModel ()


@end

@implementation BFMineSettingViewModel

///我的展示数据
- (NSMutableArray *)meTableItemArray {
    
    BFTableMenuItem * item1 = BFCreateTableMenuItem(@"me_mywallet",@"我的钱包");
    item1.indexInteger = 1;
    
    BFTableMenuItem * item2 = BFCreateTableMenuItem(@"me_mygift",@"我的礼物");
    item2.indexInteger = 2;

    BFTableMenuItem * item3 = BFCreateTableMenuItem(@"me_invitefriend",@"我的邀请");
    item3.indexInteger = 3;

    BFTableMenuItem * item4 = BFCreateTableMenuItem(@"me_myorder",@"我的订单");
    item4.indexInteger = 4;

    BFTableMenuItem * item5 = BFCreateTableMenuItem(@"me_address",@"我的地址");
    item5.indexInteger = 5;

    BFTableMenuItem * item6 = BFCreateTableMenuItem(@"me_customer",@"我的客服");
    item6.indexInteger = 6;

    BFTableMenuItem * item7 = BFCreateTableMenuItem(@"me_feedback",@"意见反馈");
    item7.indexInteger = 7;

    BFTableMenuItem * item8 = BFCreateTableMenuItem(@"me_aboutus",@"关于我们");
    item8.indexInteger = 8;

    BFTableMenuItem * item9 = BFCreateTableMenuItem(@"me_setting",@"设置");
    item9.indexInteger = 9;

    
    return [NSMutableArray arrayWithArray:@[@[item1],@[item2],@[item3],@[item4],@[item5],@[item6],@[item7],@[item8],@[item9]]];
}

-(void)initializeMineData {
    self.dataSource = [self meTableItemArray];
}


#pragma mark - 协议
//MARK: - UITableViewDelegate, UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BFRatio(45);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFTableMenuItem * infoModel = [[self.dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    BFTableMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:[BFTableMenuCell bf_reuseIdentifier]];
    if(cell==nil){
        cell=[[BFTableMenuCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:[BFTableMenuCell bf_reuseIdentifier]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BFRGB_BgColor;
        cell.hiddenSeparator = YES;
        cell.hiddenArrows = YES;
        cell.titleLabel.font = BFPFMFontWithSizes(14);
        
        [cell.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(BFRatio(13));
            make.right.mas_equalTo(-BFRatio(13));
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        [cell.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(BFRatio(13));
            make.centerY.mas_equalTo(cell.contentView);
            make.size.mas_equalTo(CGSizeMake(BFRatio(20), BFRatio(20)));
        }];
        cell.radius = BFRatio(7);
    
    }
    cell.menuItem = infoModel;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * v= [[UIView alloc]init];
    v.backgroundColor = BFRGB_BgColor;
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return BFRatio(13);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BFTableMenuItem * infoModel = [[self.dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    if (self.didSelectRowBlock) {
        self.didSelectRowBlock(infoModel);
    }
}


@end
