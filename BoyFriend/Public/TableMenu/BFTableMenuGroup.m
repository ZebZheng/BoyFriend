
#import "BFTableMenuGroup.h"

@implementation BFTableMenuGroup


+ (BFTableMenuGroup *) createGroupWithHeaderTitle:(NSString *)headerTitle
                                    FooterTitle:(NSString *)footerTitle
                                          Items:(NSMutableArray *)items{
    BFTableMenuGroup *group= [[BFTableMenuGroup alloc] init];
    group.headerTitle = headerTitle;
    group.footerTitle = footerTitle;
    group.items = items;
    return group;
}

@end
