//
//  BFHomeSectionViewController.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/4/11.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "BFHomeSectionViewController.h"

@interface BFHomeSectionViewController ()

@end

@implementation BFHomeSectionViewController

#pragma mark - Lifecycle
-(instancetype)init {
    if (self=[super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeView];
    [self initializeViewData];
    [self bindControlEvent];
    
}

#pragma mark - init
/**** 视图初始化 ****/
-(void)initializeView {
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
    [self.view addSubview:v];
    v.backgroundColor=[UIColor bf_gradientFromColor:[UIColor greenColor] toColor:[UIColor redColor] isHorizontal:YES Length:300];
    NSString *s=@"12.5";
    NSLog(@"%@,%lu",s,(unsigned long)s.length);
    s=[s bf_numberUppercaseString];
    NSLog(@"%@,%lu",s,(unsigned long)s.length);
    
    UIImage * image = [UIImage imageNamed:@"1234"];
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.center = v.center;
    imageView.size = CGSizeMake(100, 100);
    
    [v addSubview:imageView];
    imageView.image = [image bf_imageByRoundCornerRadius:100 corners:UIRectCornerAllCorners borderWidth:1 borderColor:UIColor.blueColor borderLineJoin:(kCGLineJoinRound)];
    
    
//    imageView.image = [image bf_cornerImageWithConrner:(UIRectCornerAllCorners) radius:30 rectSize:CGSizeMake(100, 100) fillColor:UIColor.whiteColor];
    
}
/**** 数据初始化 ****/
-(void)initializeViewData {
    
}
/**** 事件绑定 ****/
-(void)bindControlEvent {
    
}

#pragma mark - function


#pragma mark - logical processing（逻辑处理）


#pragma mark - Data


#pragma mark - Event Response / IBActions


#pragma mark - Protocol / delegat


#pragma mark - Notification


#pragma mark - Setter


#pragma mark - Getter



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
