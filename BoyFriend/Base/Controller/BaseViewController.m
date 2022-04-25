//
//  BaseViewController.m
//  Demon
//
//  Created by BoyFriend on 16/1/5.
//  Copyright © 2016年 BoyFriend. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseHUDView.h"
#import "UIBarButtonItem+Action.h"
#import <CoreLocation/CoreLocation.h>      //添加定位服务头文件（不可缺少）


@interface BaseViewController ()<CLLocationManagerDelegate>
{//添加代理协议 CLLocationManagerDelegate
    CLLocationManager *_locationManager;//定位服务管理类
    CLGeocoder * _geocoder;//初始化地理编码器
}

@property (nonatomic, strong) BaseHUDView *hudView;

@end

@implementation BaseViewController

- (instancetype)init {
    
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
#if DEBUG
    BFBIND_MSG(@"INJECTION_BUNDLE_NOTIFICATION", @selector(injectionNotification:));
#endif
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.navigationController.childViewControllers.count==1) {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];

}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //自定义返回按钮
    [self initBackBarButtonItem];
    //导航栏按钮配置
    [self setLeftBarBtnItem];
    [self setRightBarBtnItem];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self bindControlEventA];

}

#pragma mark - Private methods


#pragma mark - 获取定位数据

/**
 * 开始定位
 */
-(void)startLocation{
    [self initializeLocationService];
    // 开始定位
    [_locationManager startUpdatingLocation];//开始定位之后会不断的执行代理方法更新位置会比较费电所以建议获取完位置即时关闭更新位置服务
}
/**
 * 关闭定位
 */
-(void)stopLocation{
    // 开始定位
    [_locationManager stopUpdatingLocation];
    _locationManager = nil;
    _geocoder = nil;
}

/**
 * 定位初始化
 */
- (void)initializeLocationService {
    // 初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestWhenInUseAuthorization];
    //[_locationManager requestAlwaysAuthorization];//iOS8必须，这两行必须有一行执行，否则无法获取位置信息，和定位
    // 设置代理
    _locationManager.delegate = self;
    // 设置定位精确度到米
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    _locationManager.distanceFilter = kCLDistanceFilterNone;

    //初始化地理编码器
    _geocoder = [[CLGeocoder alloc] init];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

//    NSLog(@"%lu",(unsigned long)locations.count);
    CLLocation * location = locations.lastObject;
    // 纬度
    CLLocationDegrees latitude = location.coordinate.latitude;
    // 经度
    CLLocationDegrees longitude = location.coordinate.longitude;
    NSString * latitudeStr = [NSString stringWithFormat:@"%f",latitude];
    NSString * longitudeStr = [NSString stringWithFormat:@"%f",longitude];

    if ([[DataLibrery shareInstance].latitude isEqualToString:latitudeStr] && [[DataLibrery shareInstance].longitude isEqualToString:longitudeStr]) {
        if ([self respondsToSelector:@selector(locationSuccess:)]) {
            [self locationSuccess:manager];
        }
    } else {
        [DataLibrery shareInstance].latitude = latitudeStr;
        [DataLibrery shareInstance].longitude = longitudeStr;
    //    BFDEBUG(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f", location.coordinate.longitude, location.coordinate.latitude,location.altitude,location.course,location.speed);

//        [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//            if (placemarks.count > 0) {
//                CLPlacemark *placemark = [placemarks objectAtIndex:0];
//                PZCAddressModel * model =  [PZCAddressModel mj_objectWithKeyValues: placemark.addressDictionary];
//                [DataLibrery shareInstance].addressModel = model;
//                //获取城市
//                NSString *city = placemark.locality;
//                if (!city) {
//                    //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
//                    city = placemark.administrativeArea;
//                }
//    //            // 位置名
//    //            BFDEBUG(@"name,%@",placemark.name);
//    //            // 街道
//    //            BFDEBUG(@"thoroughfare,%@",placemark.thoroughfare);
//    //            // 子街道
//    //            BFDEBUG(@"subThoroughfare,%@",placemark.subThoroughfare);
//    //            // 市
//    //            BFDEBUG(@"locality,%@",placemark.locality);
//    //            // 区
//    //            BFDEBUG(@"subLocality,%@",placemark.subLocality);
//    //            // 国家
//    //            BFDEBUG(@"country,%@",placemark.country);
//            }else if (error == nil && [placemarks count] == 0) {
//                BFDEBUG(@"No results were returned.");
//            } else if (error != nil){
//                BFDEBUG(@"An error occurred = %@", error);
//            }
//
            if ([self respondsToSelector:@selector(locationSuccess:)]) {
                [self locationSuccess:manager];
            }
//        }];


    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    if ([self respondsToSelector:@selector(locationFail:)]) {
        [self locationFail:manager];
    }
}

// 显示 HUD
- (void)showHUD {
    [self.view addSubview:self.hudView];
    //isTransparent 是否透明，NO 为白色遮罩， YES 透明
    self.hudView.isTransparent = NO;
    [self.view bringSubviewToFront:self.hudView];
}

// 移除 HUD
- (void)hideHUD {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hudView hideHUD];
        self.hudView = nil;
    });
}

#pragma mark 事件

/**
 * 绑定事件
 */
-(void)bindControlEventA{
    [self.bViewModel setShowLoadingBlock:^(BOOL isWindow, NSString *message) {
        if (isWindow) {
            [MBProgressHUD showActivityMessageInWindow:message];
        } else {
            [MBProgressHUD showActivityMessageInView:message];
        }
    }];
    [self.bViewModel setShowMessageBlock:^(BOOL isWindow, NSString *message) {
        if (isWindow) {
            [MBProgressHUD showTipMessageInWindow:message];
        }else{
            [MBProgressHUD showTipMessageInView:message];
        }
    }];
    [self.bViewModel setHideHUDBlock:^{
        [MBProgressHUD hideHUD];
    }];
}
//自定义返回按钮
-(void)initBackBarButtonItem{
    NSArray *arr=self.navigationController.viewControllers;
    if (arr.count>1) {
        
        CommonsView *view = [CommonsView new];
        [view.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//        view.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view.backButton];
        [self.navigationItem setLeftBarButtonItems:@[item,[UIBarButtonItem fixItemSpace:View_Navbar_Items_Fixed_Space]]];

        self.navigationItem.backBarButtonItem = nil;
    }
}

//返回按钮 事件
-(void)backAction{
    if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


/**
 * 设置未读消息数
 */
-(void)setUnReadNum:(NSInteger)num obejctAtindex:(NSInteger)index{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:num];
        UITabBarItem * item=[self.tabBarController.tabBar.items objectAtIndex:index];
        if (num>0) {
            if (num>99) {
                item.badgeValue=@"99+";
            } else {
                item.badgeValue=[NSString stringWithFormat:@"%ld",num];
            }
        } else {
            item.badgeValue=nil;
        }
    });
}

#pragma mark -- 左右按钮
-(void)setLeftBarBtnItem{
    BOOL isleft =  [self respondsToSelector:@selector(set_leftBarBtn)];
    if (isleft) {
        UIButton *leftbutton = [self set_leftBarBtn];
        if (leftbutton == nil) {
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
            [self.navigationItem setLeftBarButtonItems:@[item]];
        } else {
            [leftbutton addTarget:self action:@selector(leftBarBtnItem_click:) forControlEvents:UIControlEventTouchUpInside];
//            leftbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
            [self.navigationItem setLeftBarButtonItems:@[item,[UIBarButtonItem fixItemSpace:View_Navbar_Items_Fixed_Space]]];
        }
    }
}

-(void)setRightBarBtnItem{
    BOOL isright = [self respondsToSelector:@selector(set_rightBarBtn)];
    if (isright) {
        UIButton *right_button = [self set_rightBarBtn];
        [right_button addTarget:self action:@selector(rightBarBtnItem_click:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:right_button];
        self.navigationItem.rightBarButtonItem = item;
    }
}


-(void)leftBarBtnItem_click:(id)sender{
    if ([self respondsToSelector:@selector(leftBarBtnItem_click:)]) {
        [self leftBarBtnItem_click:sender];
    }
}

-(void)rightBarBtnItem_click:(id)sender{
    if ([self respondsToSelector:@selector(rightBarBtnItem_click:)]) {
        [self rightBarBtnItem_click:sender];
    }
}

#pragma mark 通知
- (void)injectionNotification:(NSNotification *)notification {
    BFDEBUG(@"injectionNotification_notification: %@", notification);
    if (self.isViewLoaded && self.view.window) {
        [self viewDidLoad];
    }
}

#pragma mark 代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)dealloc{
    BFDEBUG(@"VC释放---:%@",[self class]);
    [[NSNotificationCenter defaultCenter]removeObserver:[self class]];
}

#pragma mark - Getter & Setter

- (BaseHUDView *)hudView {
    if (!_hudView) {
        _hudView = [[BaseHUDView alloc] initWithFrame:CGRectMake(0, self.bf_prefersNavigationBarHidden ? (BFStatusAndNavHeight) : 0, BFScreen_Width, BFScreen_Height)];
    }
    return _hudView;
}

-(BaseViewModel *)bViewModel{
    if (!_bViewModel) {
        _bViewModel=[[BaseViewModel alloc]init];
    }
    return _bViewModel;
}

@end
