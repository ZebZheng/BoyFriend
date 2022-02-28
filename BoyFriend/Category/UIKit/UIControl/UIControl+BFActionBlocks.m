//
//  UIControl+BFActionBlocks.m
//  Created by BF on 2021
//

#import "UIControl+BFActionBlocks.h"
#import <objc/runtime.h>

static const void *UIControlActionBlockArray = &UIControlActionBlockArray;

@implementation BFUIControlActionBlockWrapper

- (void)bf_invokeBlock:(id)sender {
    if (self.bf_actionBlock) {
        self.bf_actionBlock(sender);
    }
}
@end


@implementation UIControl (BFActionBlocks)
-(void)bf_handleControlEvents:(UIControlEvents)controlEvents withBlock:(BFUIControlActionBlock)actionBlock {
    NSMutableArray *actionBlocksArray = [self actionBlocksArray];
    
    BFUIControlActionBlockWrapper *blockActionWrapper = [[BFUIControlActionBlockWrapper alloc] init];
    blockActionWrapper.bf_actionBlock = actionBlock;
    blockActionWrapper.bf_controlEvents = controlEvents;
    [actionBlocksArray addObject:blockActionWrapper];
    
    [self addTarget:blockActionWrapper action:@selector(bf_invokeBlock:) forControlEvents:controlEvents];
}


- (void)bf_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents {
    NSMutableArray *actionBlocksArray = [self actionBlocksArray];
    NSMutableArray *wrappersToRemove = [NSMutableArray arrayWithCapacity:[actionBlocksArray count]];
    
    [actionBlocksArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BFUIControlActionBlockWrapper *wrapperTmp = obj;
        if (wrapperTmp.bf_controlEvents == controlEvents) {
            [wrappersToRemove addObject:wrapperTmp];
            [self removeTarget:wrapperTmp action:@selector(bf_invokeBlock:) forControlEvents:controlEvents];
        }
    }];
    
    [actionBlocksArray removeObjectsInArray:wrappersToRemove];
}


- (NSMutableArray *)actionBlocksArray {
    NSMutableArray *actionBlocksArray = objc_getAssociatedObject(self, UIControlActionBlockArray);
    if (!actionBlocksArray) {
        actionBlocksArray = [NSMutableArray array];
        objc_setAssociatedObject(self, UIControlActionBlockArray, actionBlocksArray, OBJC_ASSOCIATION_RETAIN);
    }
    return actionBlocksArray;
}
@end

