/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/


#import "UIImageView+BFAdd.h"
#import <objc/runtime.h>

typedef void(^ImageClickBlock)(void);

static const char ImageClickBlockKey;

@implementation UIImageView (BFAdd)

@dynamic bf_imageName;
- (void)addTouchUpInside:(void (^)(void))block {
    if (block) {
        objc_setAssociatedObject(self, &ImageClickBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [UITapGestureRecognizer.alloc initWithTarget:self action:@selector(touchupInside)];
    [self addGestureRecognizer:tap];
}
- (void)touchupInside {
    ImageClickBlock block = objc_getAssociatedObject(self, &ImageClickBlockKey);
    block();
}

- (void)setBf_imageName:(NSString *)imageName {
    objc_setAssociatedObject(self, &@selector(bf_imageName), imageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.image = [UIImage imageNamed:imageName];
}

- (NSString *)bf_imageName {
    return objc_getAssociatedObject(self, &@selector(bf_imageName));
}

- (void)setBf_base64Image:(NSString *)base64Image {
    objc_setAssociatedObject(self, @selector(bf_base64Image), base64Image, OBJC_ASSOCIATION_COPY_NONATOMIC);
    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:base64Image options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *photo = [UIImage imageWithData:imageData];
    self.image = photo;
}

- (NSString *)bf_base64Image {
    return objc_getAssociatedObject(self, &@selector(bf_base64Image));
}

@end
