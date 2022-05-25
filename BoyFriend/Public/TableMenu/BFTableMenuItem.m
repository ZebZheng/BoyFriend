
#import "BFTableMenuItem.h"

@implementation BFTableMenuItem

- (instancetype)init{
    self = [super init];
    if (self) {
        self.hiddenSwitch = YES;
    }
    return self;
}

+ (BFTableMenuItem *) createMenuWithIconPath:(NSString *)iconPath title:(NSString *)title{
    BFTableMenuItem *item = [[BFTableMenuItem alloc] init];
    item.iconPath = iconPath;
    item.title = title;
    return item;
}

@end
