//
//  UIControl+BFActionBlocks.h
//  Created by BF on 2021
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^BFUIControlActionBlock)(id weakSender);


@interface BFUIControlActionBlockWrapper : NSObject

@property (nonatomic, copy) BFUIControlActionBlock bf_actionBlock;
@property (nonatomic, assign) UIControlEvents bf_controlEvents;
- (void)bf_invokeBlock:(id)sender;

@end

@interface UIControl (BFActionBlocks)

- (void)bf_handleControlEvents:(UIControlEvents)controlEvents withBlock:(BFUIControlActionBlock)actionBlock;
- (void)bf_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
