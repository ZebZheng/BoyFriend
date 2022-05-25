
#import "BaseTableViewCell.h"
#import "BFTableMenuItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface BFTableMenuCell : BaseTableViewCell

@property (nonatomic, strong) BFTableMenuItem *menuItem;

/// 背景
@property (nonatomic,strong) UIView *bgView;

/// 左边图片
@property (nonatomic, strong) UIImageView *iconImageView;
/// 左边标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 右边图片
@property (nonatomic, strong) UIImageView *rightImageView;
/// 右边标题
@property (nonatomic, strong) UILabel *midLabel;
/// 红点未读
@property (nonatomic, strong) UIView *redPointView;
/// 线
@property (nonatomic, strong) UIView *separator;
/// 切换按钮
@property (nonatomic, strong) UISwitch *switchButton;

/// 是否隐藏箭头  默认NO;
@property (nonatomic, assign) BOOL hiddenArrows;
/// 是否隐藏分隔符, 默认NO
@property (nonatomic, assign) BOOL hiddenSeparator;
/// 是否隐藏切换按钮, 默认 YES
@property (nonatomic, assign) BOOL hiddenSwitch;

/// bgView圆角半径(如有外部设置位置请在设置后使用)
@property(nonatomic, assign) CGFloat radius;

/// Switch切换
@property (nonatomic,copy) void (^switchBlock)(UISwitch * switchButton);


@end

NS_ASSUME_NONNULL_END
