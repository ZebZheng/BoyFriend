//
//  WKWebView+BFAdapter.m
//  BoyFriend
//
//  Created by 祎 on 2022/5/17.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "WKWebView+BFAdapter.h"

@implementation WKWebView (BFAdapter)

///创建一个用于适配字体大小的WKWebw
+ (WKWebView *)bf_createAutoFontWithFrame:(CGRect)frame {
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
            
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    
    WKWebView * webView = [[WKWebView alloc] initWithFrame:frame configuration:wkWebConfig];
    
    
    return webView;
}





@end
