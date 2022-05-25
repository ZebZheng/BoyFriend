
#import "BFTableMenuCell.h"

#define     REDPOINT_WIDTH      BFRatio(6)//红点宽度

@interface  BFTableMenuCell()

/// 右箭头
@property (nonatomic,strong) UIImageView *imgVArrows;
/// 必填标识
@property (nonatomic,strong) UILabel *redlabel;


@end

@implementation BFTableMenuCell

- (void)bf_initSubviews{
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.iconImageView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.redlabel];
    [self.bgView addSubview:self.midLabel];
    [self.bgView addSubview:self.rightImageView];
    [self.bgView addSubview:self.redPointView];
    [self.bgView addSubview:self.imgVArrows];
    [self.bgView addSubview:self.separator];
    [self.bgView addSubview:self.switchButton];
}
- (void)bf_makeContraints{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LeftMargin_Constant);
        make.centerY.mas_equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(BFRatio(15.0f), BFRatio(15.0f)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImageView);
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(BFRatio(11.0f));
        make.right.mas_lessThanOrEqualTo(self.bgView).mas_offset(8.0f);
    }];
    [self.redlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel).offset(-BFRatio(5));
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(BFRatio(1));
    }];
    [self.imgVArrows mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.mas_equalTo(-RightMargin_Constant);
        make.size.mas_equalTo(CGSizeMake(BFRatio(9), BFRatio(15)));
    }];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.imgVArrows.mas_left).offset(-BFRatio(15));
        make.centerY.mas_equalTo(self.iconImageView);
        make.size.mas_equalTo(CGSizeMake(BFRatio(15), BFRatio(15)));
    }];
    [self.midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_greaterThanOrEqualTo(self.titleLabel.mas_right).mas_offset(15);
        make.right.mas_equalTo(self.rightImageView.mas_left).mas_offset(-5);
        make.centerY.mas_equalTo(self.iconImageView);
    }];
    [self.redPointView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.rightImageView.mas_right).mas_offset(1);
//        make.centerY.mas_equalTo(self.rightImageView.mas_top).mas_offset(1);
        make.width.and.height.mas_equalTo(REDPOINT_WIDTH);
        make.centerY.mas_equalTo(self.bgView);
//        make.left.mas_equalTo(self.midLabel.mas_right).offset(2);
        make.centerX.mas_equalTo(self.rightImageView);
    }];

    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(BFRatio(0.3));
    }];
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.mas_equalTo(-RightMargin_Constant);
    }];
}


- (void)setMenuItem:(BFTableMenuItem *)menuItem{
    _menuItem = menuItem;
    self.redlabel.hidden = !menuItem.isNotNull;
    self.hiddenArrows = menuItem.hiddenArrows;
    self.hiddenSwitch = menuItem.hiddenSwitch;
    self.switchButton.on = menuItem.isOnSwitch;
    if ([menuItem.iconPath isNotBlank]) {
        if ([menuItem.iconPath hasPrefix:@"http"]) {
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:menuItem.iconPath]];
        } else {
            self.iconImageView.image=BFImageName(menuItem.iconPath);
        }
    }
    if ([menuItem.rightIconURL isNotBlank]) {
        if ([menuItem.rightIconURL hasPrefix:@"http"]) {
            [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:menuItem.rightIconURL]];
        } else {
            self.rightImageView.image=BFImageName(menuItem.rightIconURL);
        }
    }
    [self.titleLabel setText:menuItem.title];
    if (menuItem.subTitle.length==0 &&menuItem.subPlaceTitle.length>0) {
        [self.midLabel setText:menuItem.subPlaceTitle];
        [self.midLabel setTextColor:BFRGB(204, 204, 204)];
    }else{
        [self.midLabel setText:menuItem.subTitle];
        [self.midLabel setTextColor:BFRGB(132, 132, 132)];
    }
    [self.redPointView setHidden:!menuItem.showRightRedPoint];

    if ([menuItem.iconPath isNotBlank]) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.iconImageView);
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(BFRatio(11.0f));
            make.right.mas_lessThanOrEqualTo(self.bgView).mas_offset(8.0f);
        }];
    } else {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.iconImageView);
            make.left.mas_equalTo(self.iconImageView.mas_left);
            make.right.mas_lessThanOrEqualTo(self.bgView).mas_offset(8.0f);
        }];
    }

    if ([menuItem.rightIconURL isNotBlank]) {
        [self.midLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_greaterThanOrEqualTo(self.titleLabel.mas_right).mas_offset(15);
            make.right.mas_equalTo(self.rightImageView.mas_left).mas_offset(-5);
            make.centerY.mas_equalTo(self.iconImageView);
        }];

    }else {
        [self.midLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_greaterThanOrEqualTo(self.titleLabel.mas_right).mas_offset(15);
            make.right.mas_equalTo(self.rightImageView.mas_right);
            make.centerY.mas_equalTo(self.iconImageView);
        }];
    }
}

- (void)drawRect:(CGRect)rect {
    if (self.radius) {
        self.bgView.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageWithColor:UIColor.whiteColor size:self.bgView.size] bf_imageByRoundCornerRadius:self.radius]];
    }
}

#pragma mark - Private Methods

- (void)setHiddenArrows:(BOOL)hiddenArrows{
    _hiddenArrows = hiddenArrows;
    self.imgVArrows.hidden=hiddenArrows;
    if (hiddenArrows) {
        [self.rightImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.imgVArrows.mas_left).offset(BFRatio(9));
        }];
    } else {
        [self.rightImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.imgVArrows.mas_left).offset(-BFRatio(15));
        }];
    }
}

- (void)setHiddenSeparator:(BOOL)hiddenSeparator {
    _hiddenSeparator = hiddenSeparator;
    self.separator.hidden = hiddenSeparator;

}

- (void)setHiddenSwitch:(BOOL)hiddenSwitch{
    _hiddenSwitch = hiddenSwitch;
    self.switchButton.hidden = hiddenSwitch;
}


- (void)switchClick:(UISwitch *)switchButton{
    if (self.switchBlock) {
        self.switchBlock(switchButton);
    }
}
- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    [self sizeToFit];
}

#pragma mark - Getter
-(UIView *)bgView{
    if (!_bgView) {
        _bgView=[[UIView alloc]init];
    }
    return _bgView;
}
- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = BFPFRFontWithSizes(14.0f);
        _titleLabel.textColor=BFRGB(50, 50, 50);
    }
    return _titleLabel;
}

-(UILabel *)redlabel{
    if (!_redlabel) {
        _redlabel = [[UILabel alloc] init];
        _redlabel.font = BFPFRFontWithSizes(9.0f);
        _redlabel.textColor=UIColor.redColor;
        _redlabel.hidden = YES;
        _redlabel.text = @"*";
    }
    return _redlabel;
}
- (UILabel *)midLabel{
    if (_midLabel == nil) {
        _midLabel = [[UILabel alloc] init];
        [_midLabel setTextColor:BFRGB(132, 132, 132)];
        [_midLabel setFont:BFPFRFontWithSizes(12.0f)];
    }
    return _midLabel;
}

- (UIImageView *)rightImageView{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
    }
    return _rightImageView;
}

- (UIView *)redPointView{
    if (_redPointView == nil) {
        _redPointView = [[UIView alloc] init];
        [_redPointView setBackgroundColor:[UIColor redColor]];
        [_redPointView.layer setCornerRadius:REDPOINT_WIDTH / 2.0];
        [_redPointView.layer setMasksToBounds:YES];

        [_redPointView setHidden:YES];
    }
    return _redPointView;
}

-(UIImageView *)imgVArrows{
    if (!_imgVArrows) {
        _imgVArrows=[BFUICreator createImageViewWithName:@"cell_next_icon"];
    }
    return _imgVArrows;
}

-(UIView *)separator{
    if (!_separator) {
        _separator=[BFUICreator createViewWithBgColor:BFRGB_Line];
    }
    return _separator;
}

-(UISwitch *)switchButton{
    if (!_switchButton) {
        _switchButton=[[UISwitch alloc]init];
        _switchButton.hidden = YES;
        _switchButton.onTintColor = BFTheme_Color;
        [_switchButton addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];

    }
    return _switchButton;
}


@end
