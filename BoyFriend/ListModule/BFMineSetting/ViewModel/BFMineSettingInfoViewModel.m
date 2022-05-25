//
//  BFMineSettingInfoViewModel.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/25.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFMineSettingInfoViewModel.h"

@implementation BFMineSettingInfoViewModel

///我的展示数据
- (NSMutableArray *)settingTableItemArray {
    
    BFTableMenuItem * item1 = BFCreateTableMenuItem(@"me_mywallet",@"有图标");
    item1.indexInteger = 1;
    item1.rightIconURL = @"me_mywallet";
    
    BFTableMenuItem * item2 = BFCreateTableMenuItem(@"",@"显示红点");
    item2.indexInteger = 2;
    item2.showRightRedPoint = YES;
    item2.hiddenArrows = YES;

    BFTableMenuItem * item3 = BFCreateTableMenuItem(@"",@"副标题");
    item3.indexInteger = 3;
    item3.subTitle = @"副标题";

    BFTableMenuItem * item4 = BFCreateTableMenuItem(@"",@"副标题PlaceHold");
    item4.indexInteger = 4;
    item4.subPlaceTitle = @"副标题PlaceHold";

    BFTableMenuItem * item5 = BFCreateTableMenuItem(@"",@"隐藏箭头");
    item5.indexInteger = 5;
    item5.hiddenArrows = YES;
    item5.subTitle = @"副标题";

    BFTableMenuItem * item6 = BFCreateTableMenuItem(@"",@"显示开关 - 打开");
    item6.indexInteger = 6;
    item6.hiddenSwitch = NO;
    item6.isOnSwitch = YES;
    item6.hiddenArrows = YES;

    BFTableMenuItem * item7 = BFCreateTableMenuItem(@"",@"显示开关 - 关闭");
    item7.indexInteger = 7;
    item7.hiddenSwitch = NO;
    item7.hiddenArrows = YES;

    BFTableMenuItem * item8 = BFCreateTableMenuItem(@"",@"必填项");
    item8.indexInteger = 8;
    item8.isNotNull = YES;
    
    return [NSMutableArray arrayWithArray:@[@[item1],@[item2],@[item3],@[item4],@[item5],@[item6],@[item7],@[item8]]];
}

-(void)initializeSettingData {
    self.dataSource = [self settingTableItemArray];
}



//MARK: - UITableViewDelegate, UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BFRatio(45);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFTableMenuItem * infoModel = [[self.dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    BFTableMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:[BFTableMenuCell bf_reuseIdentifier]];
    if(cell==nil){
        cell=[[BFTableMenuCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:[BFTableMenuCell bf_reuseIdentifier]];
        cell.titleLabel.font = BFPFMFontWithSizes(14);

    }
    cell.menuItem = infoModel;
    return cell;
}




@end
