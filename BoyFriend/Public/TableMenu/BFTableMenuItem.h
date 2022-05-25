
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define     BFCreateTableMenuItem(IconPath, Title) [BFTableMenuItem createMenuWithIconPath:IconPath title:Title]


@interface BFTableMenuItem : NSObject

/// 位置
@property(nonatomic, assign) NSInteger indexInteger;

///  左侧图标路径
@property (nonatomic, strong) NSString *iconPath;

///  标题
@property (nonatomic, strong) NSString *title;

///  副标题
@property (nonatomic, strong) NSString *subTitle;

///  副图片URL
@property (nonatomic, strong) NSString *rightIconURL;

///  是否显示红点
@property (nonatomic, assign) BOOL showRightRedPoint;

///  副标题PlaceHold
@property (nonatomic, strong) NSString *subPlaceTitle;

///  是否是必填选项 是 显示红色*
@property (nonatomic, assign) BOOL isNotNull;

/// 是否隐藏箭头  默认NO;
@property (nonatomic, assign) BOOL hiddenArrows;


/// 是否隐藏开关  默认YES;
@property (nonatomic, assign) BOOL hiddenSwitch;
/// 开关是否打开  默认NO;
@property (nonatomic, assign) BOOL isOnSwitch;

/// model
@property (nonatomic, strong) id model;

+ (BFTableMenuItem *) createMenuWithIconPath:(NSString *)iconPath title:(NSString *)title;


@end

NS_ASSUME_NONNULL_END
