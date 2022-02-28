//
//  UIDevice+BFUtils.m
//  AwesomeTips
//
//  Created by kangzubin on 2018/9/20.
//  Copyright © 2018 KANGZUBIN. All rights reserved.
//

#import "UIDevice+BFUtils.h"
#import <sys/sysctl.h>

@implementation UIDevice (BFUtils)

+ (NSString *)bf_platform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    if (machine == NULL) {
        return nil;
    }
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

// See also: https://www.theiphonewiki.com/wiki/Models
+ (NSString *)bf_platformString {
    NSString *platform = [self bf_platform];
    
    if (!platform) {
        return [UIDevice currentDevice].model; // e.g. @"iPhone", @"iPod touch"
    }
    
    // iPhone
    if ([platform isEqualToString:@"iPhone14,4"])  return  @"iPhone 13 mini";
    if ([platform isEqualToString:@"iPhone14,5"])  return  @"iPhone 13";
    if ([platform isEqualToString:@"iPhone14,2"])  return  @"iPhone 13 Pro";
    if ([platform isEqualToString:@"iPhone14,3"])  return  @"iPhone 13 Pro Max";
    if ([platform isEqualToString:@"iPhone13,1"])  return  @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"])  return  @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"])  return  @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"])  return  @"iPhone 12 Pro Max";
    if ([platform isEqualToString:@"iPhone12,8"])  return  @"iPhone SE2";
    if ([platform isEqualToString:@"iPhone12,1"])  return  @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"])  return  @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"])  return  @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhone X";         // GSM
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";    // GSM
    if ([platform isEqualToString:@"iPhone10,4"])   return @"iPhone 8";         // GSM
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhone X";         // Global
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";    // Global
    if ([platform isEqualToString:@"iPhone10,1"])   return @"iPhone 8";         // Global
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";    // GSM
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";         // GSM
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";    // Global
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";         // Global
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM Rev A)";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    
    // iPod touch
    if ([platform isEqualToString:@"iPod9,1"])      return @"iPod touch 7";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod touch 6";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod touch 5";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod touch 4";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod touch 3";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod touch 2";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod touch 1";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad6,11"])  return @"iPad 5";
    if ([platform isEqualToString:@"iPad6,12"])  return @"iPad 5";
    if ([platform isEqualToString:@"iPad7,5"])   return @"iPad 6";
    if ([platform isEqualToString:@"iPad7,6"])   return @"iPad 6";
    if ([platform isEqualToString:@"iPad7,11"])   return @"iPad 7";
    if ([platform isEqualToString:@"iPad7,12"])   return @"iPad 7";
    if ([platform isEqualToString:@"iPad11,6"])   return @"iPad 8";
    if ([platform isEqualToString:@"iPad11,7"])   return @"iPad 8";
    if ([platform isEqualToString:@"iPad12,1"])   return @"iPad 9";
    if ([platform isEqualToString:@"iPad12,2"])   return @"iPad 9";
    
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad11,3"])   return @"iPad Air 3";
    if ([platform isEqualToString:@"iPad11,4"])   return @"iPad Air 3";
    if ([platform isEqualToString:@"iPad13,1"])   return @"iPad Air 4";
    if ([platform isEqualToString:@"iPad13,2"])   return @"iPad Air 4";
    
    //iPad Pro
    if ([platform isEqualToString:@"iPad6,7"])   return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,8"])   return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad13,8"])   return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad13,9"])   return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad13,10"])   return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad13,11"])   return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,3"])   return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,4"])   return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad7,1"])   return @"iPad Pro 2 (12.9-inch)";
    if ([platform isEqualToString:@"iPad7,2"])   return @"iPad Pro 2 (12.9-inch)";
    if ([platform isEqualToString:@"iPad7,3"])   return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,4"])   return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad8,1"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,2"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,3"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,4"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad13,4"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad13,5"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad13,6"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad13,7"])   return @"iPad Pro (11-inch)";

    if ([platform isEqualToString:@"iPad8,5"])   return @"iPad Pro 3 (12.9-inch)";
    if ([platform isEqualToString:@"iPad8,6"])   return @"iPad Pro 3 (12.9-inch)";
    if ([platform isEqualToString:@"iPad8,7"])   return @"iPad Pro 3 (12.9-inch)";
    if ([platform isEqualToString:@"iPad8,8"])   return @"iPad Pro 3 (12.9-inch)";
    if ([platform isEqualToString:@"iPad8,9"])   return @"iPad Pro 2 (11-inch)";
    if ([platform isEqualToString:@"iPad8,10"])   return @"iPad Pro 2 (11-inch)";
    if ([platform isEqualToString:@"iPad8,11"])   return @"iPad Pro 4 (12.9-inch)";
    if ([platform isEqualToString:@"iPad8,12"])   return @"iPad Pro 4 (12.9-inch)";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad mini";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad11,1"])   return @"iPad mini 5";
    if ([platform isEqualToString:@"iPad11,2"])   return @"iPad mini 5";
    if ([platform isEqualToString:@"iPad14,1"])   return @"iPad mini 6";
    if ([platform isEqualToString:@"iPad14,2"])   return @"iPad mini 6";
    // Simulator
    if ([platform isEqualToString:@"i386"])         return [NSString stringWithFormat:@"%@ Simulator", [UIDevice currentDevice].model];
    if ([platform isEqualToString:@"x86_64"])       return [NSString stringWithFormat:@"%@ Simulator", [UIDevice currentDevice].model];
    
    // For new device, return the hardware string directly.
    return platform;
}

+ (NSString *)bf_deviceName {
    static NSString *deviceName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceName = [self bf_platformString];
        if (deviceName.length == 0) {
            deviceName = @"iPhone";
        }
    });
    return deviceName;
}

@end
