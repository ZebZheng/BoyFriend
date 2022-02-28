//
//  LoginPageViewController.m
//  Demon
//
//  Created by PZ-IMAC-2 on 2021/11/5.
//  Copyright © 2021 BoyFriend. All rights reserved.
//

#import "LoginPageViewController.h"

#import "BRStringPickerView.h"

#import "NetWorkURL.h"


@interface LoginPageViewController ()

/**** 状态 ****/
@property (nonatomic,strong) UILabel *switchStatus;
/**** 切换次数 ****/
@property (nonatomic) NSInteger switchNum;


@end

@implementation LoginPageViewController

#pragma mark - Lifecycle
-(instancetype)init{
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
-(void)initializeView{
    self.view.backgroundColor = UIColor.whiteColor;
    //正式和测试库的切换按钮
    if (ISEnable_Switch_Environment) {
        [self addSwitchoverBtn];
    }

}
/**** 数据初始化 ****/
-(void)initializeViewData{
    
}
/**** 事件绑定 ****/
-(void)bindControlEvent{
    
}
#pragma mark - UI


#pragma mark - IBActions/Event Response


#pragma mark - Data


#pragma mark - logical processing（逻辑处理）


#pragma mark - Notification


#pragma mark - Protocol conformance


#pragma mark - Getter Setter



#pragma mark - 环境切换相关
- (void)addSwitchoverBtn{
    @weakify(self);
    self.switchNum=0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self);
        self.switchNum ++;
        if (self.switchNum>5) {
            self.switchNum=0;
            [self switchAction];
        }
    }];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
    self.switchStatus = [BFUICreator createLabelWithText:@"" color:[UIColor redColor] font:BFPFRFontWithSizes(16)];
    [self.view addSubview:self.switchStatus];
    [self.switchStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(BFRatio(-10));
        make.bottomMargin.mas_equalTo(-BFRatio(10));
    }];
    self.switchStatus.text=[NetWorkURL sharedInstance].environmentModel.environmentString;
}

- (void)switchAction {
    @weakify(self);
    // 自定义单列字符串
    NSMutableArray * mArray = [[NSMutableArray alloc]init];
    for (NetWorkEnvironment * model in [NetWorkEnvironment sharedInstance].environmentArray) {
        [mArray addObject:model.environmentString];
    }    
    BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]init];

    stringPickerView.title = @"环境切换";
    stringPickerView.dataSourceArr = mArray;
    stringPickerView.selectValue = [NetWorkURL sharedInstance].environmentModel.environmentString;
    stringPickerView.isAutoSelect = NO;
    stringPickerView.resultModelBlock = ^(BRResultModel * _Nullable resultModel) {
        @strongify(self);
        [self selectWithSelectValue:resultModel];
    };
    // 设置自定义样式
    BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
    customStyle.language = [DataLibrery shareInstance].curLanguageModel.localLang;
    customStyle.cancelBtnTitle = @"取消";
    customStyle.doneBtnTitle = @"确定";
    stringPickerView.pickerStyle = customStyle;

    [stringPickerView show];
}

- (void)selectWithSelectValue:(BRResultModel *)selectModel {
    NetWorkEnvironment * model = [[NetWorkEnvironment sharedInstance].environmentArray objectAtIndex:selectModel.index];
    
    [NetWorkURL sharedInstance].environmentModel = model;
    
    [BFUserDefaults setInteger:model.environmentType forKey:@"APIType"];
    [BFUserDefaults synchronize];
    self.switchStatus.text=model.environmentString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
