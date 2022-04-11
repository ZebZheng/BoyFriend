/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import "NSArray+BFSafe.h"

@implementation NSArray (BFSafe)
- (id)bf_objectWithIndex:(NSUInteger)index{
    if (index <self.count) {
        return self[index];
    } else {
        return nil;
    }
}

- (NSString*)bf_stringWithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    return nil;
}


- (NSNumber*)bf_numberWithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (NSDecimalNumber *)bf_decimalNumberWithIndex:(NSUInteger)index{
    id value = [self bf_objectWithIndex:index];
    
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber*)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (NSArray*)bf_arrayWithIndex:(NSUInteger)index
{
    id value = [self bf_objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary*)bf_dictionaryWithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSInteger)bf_integerWithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}
- (NSUInteger)bf_unsignedIntegerWithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    return 0;
}
- (BOOL)bf_boolWithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}

- (int16_t)bf_int16WithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int32_t)bf_int32WithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}
- (int64_t)bf_int64WithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (char)bf_charWithIndex:(NSUInteger)index {
    
    id value = [self bf_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value charValue];
    }
    return 0;
}

- (short)bf_shortWithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (float)bf_floatWithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    return 0;
}

- (double)bf_doubleWithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value doubleValue];
    }
    return 0;
}

- (NSDate *)bf_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self bf_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

//CG
- (CGFloat)bf_CGFloatWithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];
    
    CGFloat f = [value doubleValue];
    
    return f;
}

- (CGPoint)bf_pointWithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];

    CGPoint point = CGPointFromString(value);
    
    return point;
}

- (CGSize)bf_sizeWithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];

    CGSize size = CGSizeFromString(value);
    
    return size;
}
- (CGRect)bf_rectWithIndex:(NSUInteger)index {
    id value = [self bf_objectWithIndex:index];
    
    CGRect rect = CGRectFromString(value);
    
    return rect;
}
@end


#pragma --mark NSMutableArray setter
@implementation NSMutableArray (BFSafe)

- (void)bf_addObj:(id)i {
    if (i != nil) {
        [self addObject:i];
    }
}

- (void)bf_addString:(NSString*)i {
    if (i != nil) {
        [self addObject:i];
    }
}

-(void)bf_addBool:(BOOL)i {
    [self addObject:@(i)];
}

-(void)bf_addInt:(int)i {
    [self addObject:@(i)];
}

-(void)bf_addInteger:(NSInteger)i {
    [self addObject:@(i)];
}

-(void)bf_addUnsignedInteger:(NSUInteger)i {
    [self addObject:@(i)];
}

-(void)bf_addCGFloat:(CGFloat)f {
   [self addObject:@(f)];
}

-(void)bf_addChar:(char)c {
    [self addObject:@(c)];
}

-(void)bf_addFloat:(float)i {
    [self addObject:@(i)];
}

-(void)bf_addPoint:(CGPoint)o {
    [self addObject:NSStringFromCGPoint(o)];
}

-(void)bf_addSize:(CGSize)o {
   [self addObject:NSStringFromCGSize(o)];
}

-(void)bf_addRect:(CGRect)o {
    [self addObject:NSStringFromCGRect(o)];
}


@end

