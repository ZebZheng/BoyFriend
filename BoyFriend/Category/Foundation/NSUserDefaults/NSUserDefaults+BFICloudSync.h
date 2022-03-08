/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/


#import <Foundation/Foundation.h>


@interface NSUserDefaults (BFICloudSync)

//iCloud 同步数据
-(void)bf_setValue:(id)value  forKey:(NSString *)key iCloudSync:(BOOL)sync;
-(void)bf_setObject:(id)value forKey:(NSString *)key iCloudSync:(BOOL)sync;

-(id)bf_valueForKey:(NSString *)key  iCloudSync:(BOOL)sync;
-(id)bf_objectForKey:(NSString *)key iCloudSync:(BOOL)sync;

-(BOOL)bf_synchronizeAlsoiCloudSync:(BOOL)sync;
- (void)bf_removeValueForKey:(NSString *)key iCloudSync:(BOOL)sync;

@end
