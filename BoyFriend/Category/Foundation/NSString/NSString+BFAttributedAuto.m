//
//  NSString+BFAttributedAuto.m
//  BoyFriend
//
//  Created by 祎 on 2022/4/8.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "NSString+BFAttributedAuto.h"

@implementation NSString (BFAttributedAuto)

///适配图片
- (NSString *)bf_autoImage {
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                               "<head> \n"
                               "<style type=\"text/css\"> \n"
                               "body {font-size:15px;}\n"
                               "</style> \n"
                               "</head> \n"
                               "<body>"
                               "<script type='text/javascript'>"
                               "window.onload = function(){\n"
                               "var $img = document.getElementsByTagName('img');\n"
                               "for(var p in  $img){\n"
                                  " $img[p].style.width = '100%%';\n"
                                   "$img[p].style.height ='auto'\n"
                               "}\n"
                               "}"
                               "</script>%@"
                               "</body>"
                               "</html>",self];
    return htmls;
}

@end
