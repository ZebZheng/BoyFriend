/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (BFSafe)
-(id)bf_objectWithIndex:(NSUInteger)index;

- (NSString*)bf_stringWithIndex:(NSUInteger)index;

- (NSNumber*)bf_numberWithIndex:(NSUInteger)index;

- (NSDecimalNumber *)bf_decimalNumberWithIndex:(NSUInteger)index;

- (NSArray*)bf_arrayWithIndex:(NSUInteger)index;

- (NSDictionary*)bf_dictionaryWithIndex:(NSUInteger)index;

- (NSInteger)bf_integerWithIndex:(NSUInteger)index;

- (NSUInteger)bf_unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)bf_boolWithIndex:(NSUInteger)index;

- (int16_t)bf_int16WithIndex:(NSUInteger)index;

- (int32_t)bf_int32WithIndex:(NSUInteger)index;

- (int64_t)bf_int64WithIndex:(NSUInteger)index;

- (char)bf_charWithIndex:(NSUInteger)index;

- (short)bf_shortWithIndex:(NSUInteger)index;

- (float)bf_floatWithIndex:(NSUInteger)index;

- (double)bf_doubleWithIndex:(NSUInteger)index;

- (NSDate *)bf_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;
//CG
- (CGFloat)bf_CGFloatWithIndex:(NSUInteger)index;

- (CGPoint)bf_pointWithIndex:(NSUInteger)index;

- (CGSize)bf_sizeWithIndex:(NSUInteger)index;

- (CGRect)bf_rectWithIndex:(NSUInteger)index;

@end


#pragma --mark NSMutableArray setter

@interface NSMutableArray(BFSafe)

- (void)bf_addObj:(id)i;

- (void)bf_addString:(NSString*)i;

- (void)bf_addBool:(BOOL)i;

- (void)bf_addInt:(int)i;

- (void)bf_addInteger:(NSInteger)i;

- (void)bf_addUnsignedInteger:(NSUInteger)i;

- (void)bf_addCGFloat:(CGFloat)f;

- (void)bf_addChar:(char)c;

- (void)bf_addFloat:(float)i;

- (void)bf_addPoint:(CGPoint)o;

- (void)bf_addSize:(CGSize)o;

- (void)bf_addRect:(CGRect)o;


@end
