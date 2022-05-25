
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define     BFCreateTableMenuGroup(headerTitle, footerTitle,items) [BFTableMenuGroup createGroupWithHeaderTitle:headerTitle FooterTitle:footerTitle Items:[NSMutableArray arrayWithArray:items]]


@interface BFTableMenuGroup : NSObject

///  section头部标题
@property (nonatomic, strong) NSString *headerTitle;

///  section尾部说明
@property (nonatomic, strong) NSString *footerTitle;

///  setcion元素
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat footerHeight;


+ (BFTableMenuGroup *)createGroupWithHeaderTitle:(NSString *)headerTitle
                                     FooterTitle:(NSString *)footerTitle
                                           Items:(NSMutableArray *)items;

@end

NS_ASSUME_NONNULL_END
