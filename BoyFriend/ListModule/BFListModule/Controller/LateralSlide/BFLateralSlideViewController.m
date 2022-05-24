//
//  BFLateralSlideViewController.m
//  BoyFriend
//
//  Created by 祎 on 2022/5/24.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFLateralSlideViewController.h"
#import "WMPlayer.h"

@interface BFLateralSlideViewController ()

@property(nonatomic, strong) WMPlayer * wmPlayer;

@end

@implementation BFLateralSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self bf_navTitle:@"抽屉"];
    
    WMPlayerModel *playerModel = [WMPlayerModel new];
    playerModel.title = @"测试网络播放";
    playerModel.videoURL = [NSURL URLWithString:@"https://media.w3.org/2010/05/sintel/trailer.mp4"];
    self.wmPlayer = [[WMPlayer alloc]initPlayerModel:playerModel];
    [self.view addSubview:self.wmPlayer];
    [self.wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.top.mas_equalTo(100);
        make.width.mas_equalTo(BFRatio(200));
        make.height.mas_equalTo(self.wmPlayer.mas_width).multipliedBy(9.0/16);
    }];
    [self.wmPlayer play];
}
///视频切换
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.wmPlayer resetWMPlayer];
    WMPlayerModel *playerModel = [WMPlayerModel new];
    playerModel.title = @"网络播放";
    playerModel.videoURL = [NSURL URLWithString:@"https://www.w3school.com.cn/example/html5/mov_bbb.mp4"];
    self.wmPlayer.playerModel = playerModel;
    [self.wmPlayer play];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
