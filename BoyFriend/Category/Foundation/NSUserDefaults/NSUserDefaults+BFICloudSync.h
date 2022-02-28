//
//  NSUserDefaults+iCloudSync.h
//
//  Created by Riccardo Paolillo on 09/05/13.
//  Copyright (c) 2013. All rights reserved.
//

//https://github.com/RiccardoPaolillo/NSUserDefault-iCloud
// A very simple iOS Category for synchronize NSUserDefaults with iCloud (NSUbiquitousKeyValueStore)

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
