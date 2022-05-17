//
//  WKWebView+BFAdapter.h
//  BoyFriend
//
//  Created by 祎 on 2022/5/17.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (BFAdapter)

///创建一个用于适配字体大小的WKWeb
+ (WKWebView *)bf_createAutoFontWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
