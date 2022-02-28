//
//  BFColorMacros.h
//  Demon
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 BoyFriend. All rights reserved.
//

#ifndef BFColorMacros_h
#define BFColorMacros_h


// 随机色
#define BFRandomColor BFRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// RGB颜色转换（16进制->10进制）
#define BFRGBHEX(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define BFRGBHEX_A(rgbValue,a)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
// 获取RGB颜色
#define BFRGB_A(r,g,b,a)           [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define BFRGB(r,g,b)              BFRGB_A(r,g,b,1.0f)


//app主题色
#define BFTheme_Color      BFRGBHEX(0x0080FF)
//APP大部分字体颜色
#define BFRGB_FontColor    BFRGBHEX(0x333333)
//默认背景颜色
#define BFRGB_BgColor      BFRGB(242, 242, 242)
//分割线颜色
#define BFRGB_Line         BFRGB(222, 223, 224)

//*************** 其他颜色 **************
#define BFRGB_0_131_255    BFRGB(0, 131, 255)





#endif /* BFColorMacros_h */
