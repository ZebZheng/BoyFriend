/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIApplication (BFAdd)

//MARK: - "Documents" folder in this app's sanBFox.
@property (nonatomic, readonly) NSURL * bf_documentsURL;
@property (nonatomic, readonly) NSString * bf_documentsPath;

//MARK: - "Caches" folder in this app's sanBFox.
@property (nonatomic, readonly) NSURL * bf_cachesURL;
@property (nonatomic, readonly) NSString * bf_cachesPath;

//MARK: - "Library" folder in this app's sanBFox.
@property (nonatomic, readonly) NSURL * bf_libraryURL;
@property (nonatomic, readonly) NSString * bf_libraryPath;

//MARK: - Application's Display Name
@property (nullable, nonatomic, readonly) NSString * bf_appDisplayName;
//MARK: - Application's Bundle Name (show in SpringBoard).
@property (nullable, nonatomic, readonly) NSString * bf_appBundleName;

//MARK: - Application's Bundle ID.  e.g. "com.ibireme.MyApp"
@property (nullable, nonatomic, readonly) NSString * bf_appBundleID;

//MARK: - Application's Version.  e.g. "1.2.0"
@property (nullable, nonatomic, readonly) NSString * bf_appVersion;

//MARK: - Application's Build number. e.g. "123"
@property (nullable, nonatomic, readonly) NSString * bf_appBuildVersion;

@end
NS_ASSUME_NONNULL_END




