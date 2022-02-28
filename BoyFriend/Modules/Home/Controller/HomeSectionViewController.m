//
//  HomeSectionViewController.m
//  Demon
//
//  Created by apple on 2019/1/28.
//  Copyright © 2019年 BoyFriend. All rights reserved.
//

#import "HomeSectionViewController.h"

@interface HomeSectionViewController ()

@end

@implementation HomeSectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
    [self.view addSubview:v];
    v.backgroundColor=[UIColor bf_gradientFromColor:[UIColor greenColor] toColor:[UIColor redColor] isHorizontal:YES Length:300];
    NSString *s=@"12.5";
    NSLog(@"%@,%lu",s,(unsigned long)s.length);
    s=[s bf_numberUppercaseString];
    NSLog(@"%@,%lu",s,(unsigned long)s.length);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
