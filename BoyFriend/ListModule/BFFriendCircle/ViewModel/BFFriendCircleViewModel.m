//
//  BFFriendCircleViewModel.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/18.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFFriendCircleViewModel.h"
#import "BFFriendCircleCell.h"

@interface BFFriendCircleViewModel ()


@end

@implementation BFFriendCircleViewModel



//MARK: - 下拉
-(void)refreshData{
    @weakify(self);
    [self asyncGetListWithPage:1 successBlock:^(BaseResponseData *result) {
        @strongify(self);
        [self.dataSource removeAllObjects];
        if (self.isNeedPaging == NO) {
            NSArray * arrModel = result.extendModel;
            [self.dataSource addObject:arrModel];
            self.reloadTableView = YES;
            [self dataSetWithPageNow:1 Count:1];
        } else {
            BFFriendCircleListModel * listModel = result.extendModel;
            [self.dataSource addObject:listModel.records];
            self.reloadTableView = YES;
            [self dataSetWithPageNow:listModel.current Count:listModel.pages];
        }
        if (self.dataSource.count==0) {
            BFBlock_Safe_Calls(self.placeholderBlock,YES,BFPlaceholderViewTypeNoList,NO);
        }else{
            BFBlock_Safe_Calls(self.placeholderBlock,NO,BFPlaceholderViewTypeNoList,NO);
        }
        
    } failureBlock:^(BaseResponseData *result) {
        @strongify(self);
        self.endRefreshing = YES;
        [self showMessageInView:result.info];

        if ([result.code isEqualToString:BFInteger_To_String(Server_Code_Minus1009)]) {
            BFBlock_Safe_Calls(self.placeholderBlock,YES,BFPlaceholderViewTypeNoNet,YES);
        } else {
            BFBlock_Safe_Calls(self.placeholderBlock,NO,BFPlaceholderViewTypeNoList,NO);
        }
    }];
}

//MARK: - 上提
-(void)getMoreData {
    if (self.pageNow==self.count) {
        self.endRefreshing = YES;
        return;
    }
    @weakify(self);
    [self asyncGetListWithPage:self.pageNow + 1 successBlock:^(BaseResponseData *result) {
        @strongify(self);
        BFFriendCircleListModel * listModel = result.extendModel;
        if (self.dataSource.count>0) {
            NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.dataSource.firstObject];
            [tempArr addObjectsFromArray:listModel.records];
            [self.dataSource replaceObjectAtIndex:0 withObject:tempArr];
        } else {
            [self.dataSource addObject:listModel.records];
        }
        self.reloadTableView = YES;
        [self dataSetWithPageNow:listModel.current Count:listModel.pages];
        
    } failureBlock:^(BaseResponseData *result) {
        @strongify(self);
        self.endRefreshing = YES;
        [self showMessageInView:result.info];
    }];
}

/**
 *  获取列表数据
 */
- (void)asyncGetListWithPage:(NSInteger)page successBlock:(successCallback)successBlock failureBlock:(failCallback)failureBlock {
//    NSMutableDictionary * mDic = [NSMutableDictionary new];
//    Class class = nil;
//    if (self.isNeedPaging) {
//        [mDic setValue:[NSString stringWithFormat:@"%zd",page] forKey:@"page"];
//        [mDic setValue:BFApi_ListPageSize forKey:@"rows"];
//        class = [BFFriendCircleListModel class];
//    }else{
//        class = [BFFriendCircleInfoModel class];
//    }
//
//
//    [[NetWorkHelper sharedInstance] getWithUriString:<#uri#> parameters:mDic  successBlock:^(id responseObject) {
//        [self handleResponse:responseObject resp:class completion:^(BOOL success, BaseResponseData *respData) {
//            if (success) {
//                BFBlock_Safe_Calls(successBlock, respData);
//            } else {
//                BFBlock_Safe_Calls(failureBlock, respData);
//            }
//        }];
//    } failureBlock:^(BaseResponseData *error) {
//        BFBlock_Safe_Calls(failureBlock, error);
//    }];
    BaseResponseData * respData = [[BaseResponseData alloc]init];
    respData.extendModel = [self creatModelsWithCount:20];
    BFBlock_Safe_Calls(successBlock, respData);

    
}
- (NSArray *)creatModelsWithCount:(NSInteger)count{
    NSArray *iconImageNamesArray = @[
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2Fff%2F0b%2F6d%2Fff0b6d250839a43eadab5e759dc4338c.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655970229&t=3ecbd019ff336bfa376e34073b2b3917",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic%2Feb%2F24%2Fd5%2Feb24d54a0c4e1f174a7a4922aaa28454.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655970229&t=eef6dd99e7022ae6a7a857b647fb149d",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2F91%2F81%2Fd7%2F9181d7d8787f7e96f0017da5e61ad27d.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655970229&t=e11dd36c517221d456c1b14f5c01ad8b",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2F9e%2F32%2F9a%2F9e329acc0c79523b0204f6ed7ea1e45e.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655970229&t=338ea521987bff08b1a56f735fd8201b",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2F7e%2Fe3%2F63%2F7ee36374e1e2e7eb1ed7638ac3833f65.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655970229&t=35914d3ed8b340fef0bdce130d7f59a2",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2F46%2Fb9%2F9e%2F46b99ebabd3bee7cbbcefec89a66d731.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655970229&t=c8c57b89b8c237e44b9c488de68f903a",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic%2Fc9%2F63%2F77%2Fc963777ebd9c8ebf5583b39565cfa1d7.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655970229&t=71c7bcab616c3d856e71686869cec3e1",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2F99%2Fa7%2Fef%2F99a7ef12a7d254862af1956ace3af1b5.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655970229&t=909130a2fbd685f33a1f9702669e633a",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic%2F76%2Fe4%2F5b%2F76e45bdb73abcf3f6a7d875d3f63a93b.jpeg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655970229&t=2c2e3be81d0215da31f16813950e9719",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic%2Ffb%2F62%2Fc5%2Ffb62c55cb13f4f5f6702b02fbe59343b.jpeg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655970229&t=96521e0bfef0e5e19bf281d05fe1ab9c",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2F15%2Fc0%2F2a%2F15c02a241489ea30ba9f40dc8d094837.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655970229&t=7db6f33482e75937d599952cf75c448d",
                                     ];
    
    NSArray *namesArray = @[@"相见不如怀念ゝ",
                            @"温柔∝乡",
                            @"北方少年``",
                            @"杳然■ | 澜本■",
                            @"╰朕ざ有恃无恐",
                            @"十里笙歌",
                            @"笑著強裝",
                            @"蜜心Ω萝莉酱",
                            @"月上あ烟雨遥",
                            @"画未",
                            @"浅时光",
                            ];
    
    NSArray *textArray = @[@"如果必须失去，但愿是忧愁!如果必须遗忘，但愿是烦恼!",
                           @"每颗心都不是监狱，却都想关住悲伤，趁着我们还未老去，还是把它们都释放了吧。只要你脚还在地面上，就别把自己看的太轻;只要你还活在地球上，就别把自己看的太大。",
                           @"只有满怀自信的人，才能在任何地方都怀有自信沉浸在生活中，并实现自己的意志。——高尔基",
                           @"人生三大定义：性格决定命运，心态决定成败，成功取决于(源于)速度。发怒一分钟，不仅得不到任何快感，还失去了六十秒的幸福。世界上每个人都是被上帝咬过一口的苹果…有的人缺陷比较大，那是因为上帝特别便爱她的芬芳。没有准备请不要开始，没有能力请不要承诺。",
                           @"在产生矛盾发生冲突时，只要退一步考虑或站在对方立场上看待问题，那么双方就不会继续僵持，也不再会有对立面。世界上最远的距离不是树与树的距离，而是同根生长的树枝却无法在风中相依。",
                           @"受教育懂得焚毁遗嘱，做一个体面的人，为人所爱，受人敬重，而不是去做一个屡犯的偷表贼，受到法律对五种情状的加重处罚，解赴格雷伏刑场处死，受人憎恨和名誉扫地。——巴尔扎克",
                           @"志向是天才的幼苗，经过热爱劳动的双手培育，在肥田沃土里将成长为粗壮的大树。不热爱劳动，不进行自我教育，志向这棵幼苗也会连根枯死。确定个人志向，选好专业，这是幸福的源泉。——苏霍姆林斯基",
                           @"教育能开拓人的智力。——贺拉斯",
                           @"假如我有一枝马良的神笔，我要在月亮和木星中间画一座桥，这样他们就不用遥遥相望，他们可以天天在一起玩耍了。假如我有一只马良的神笔，我要画很多很多地板，这样人们就不用砍伐树木，保护森林资源，让世世代代的人享受。",
                           @"假如所有的小河都干涸了，地球上将看不到一点点的绿色，更别说花儿身上那五彩缤纷的颜色了！树木枯死了，叶子全部掉落了下来，有些甚至抓住树干，向上一握，就可以把这棵树连根拔起，小草枯黄了，死掉了，有些地方甚至连枯草的影子也看不见；什么梅花呀、菊花呀、桃花呀……全都看不见了，土地变成了沙漠。",
                           @"假如我是春雨，我将滋润万物；假如我是大海，我将容纳百川；假如我是阳光，我将普照大地。"
                            ];

    
    NSArray *picImageNamesArray = @[
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1114%2F021621112351%2F210216112351-5-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655969975&t=8fe3e9a6994b64c4e5fcf6be9a2cf4c5",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1114%2F1110200ZS0%2F2011100ZS0-1-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655969975&t=f2dadad3566bb0b9883e685aac7e9aa3",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F4k%2Fs%2F02%2F2109242306111155-0-lp.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655969975&t=451378bf5fdcd5b3625a67379ced1cee",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2Ftp06%2F200QQU3202Y7-0-lp.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655969975&t=fd671fd08c2c2823933f26463140e94b",
                                     @"http://t15.baidu.com/it/u=4007473826,3396966131&fm=224&app=112&f=JPEG?w=500&h=500",
                                     @"https://img2.baidu.com/it/u=2513024551,2896067572&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1114%2F0R620115Q8%2F200R6115Q8-6-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655969975&t=29af01fc1f2aa5e411bdfacecbeb418e",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1114%2F102920105033%2F201029105033-6-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655969975&t=8626c4fbf6e8ecb255a43bac1d8afb3c",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1113%2F061920114645%2F200619114645-6-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655969975&t=08f3e5ded5d5d92df089dfec9e78edb6",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1115%2F0ZR1095111%2F210ZP95111-7-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655969975&t=49fc0b65fee0080be851285bff873028",
                                     @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic.jj20.com%2Fup%2Fallimg%2F1112%2F012519160112%2F1Z125160112-4.jpg&refer=http%3A%2F%2Fpic.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1655969975&t=905e8caac47bb7072ea5649c636ba0b3"
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(11);
        int nameRandomIndex = arc4random_uniform(11);
        int contentRandomIndex = arc4random_uniform(11);
        
        BFFriendCircleModel *model = [BFFriendCircleModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        
        int random = arc4random_uniform(10);
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(11);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        [resArr addObject:model];
    }
    return [resArr copy];
}



#pragma mark - 协议
//MARK: - UITableViewDelegate, UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BFFriendCircleModel * infoModel = [[self.dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    BFFriendCircleCell * cell = [tableView dequeueReusableCellWithIdentifier:[BFFriendCircleCell bf_reuseIdentifier]];
    if(cell==nil){
        cell=[[BFFriendCircleCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:[BFFriendCircleCell bf_reuseIdentifier]];
    }
    [cell bf_setupWithData:infoModel];
    [cell setMoreButtonClickedBlock:^{
        infoModel.isOpening = !infoModel.isOpening;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    @weakify(self);
    [cell setTapImageViewBlock:^(NSArray * _Nonnull resourceArray, NSInteger tag) {
        @strongify(self);
        
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
