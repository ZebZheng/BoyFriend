//
//  PhotoContainerView.m
//  BoyFriend
//
//  Created by IMAC-2 on 2022/5/23.
//  Copyright © 2022 BoyFriend. All rights reserved.
//

#import "PhotoContainerView.h"
#import "SDWebImageDownloader.h"

@interface PhotoContainerView ()

@property (nonatomic, strong) NSArray *imageViewsArray;

@end


@implementation PhotoContainerView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [temp copy];
}


- (void)setResourceArray:(NSArray *)resourceArray{
    _resourceArray = resourceArray;
    for (long i = _resourceArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_resourceArray.count == 0) {
        self.height = 0;
        return;
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:_resourceArray];
    __block CGFloat itemH = 0;
    if (_resourceArray.count == 1) {
        __block UIImage *image;
        if ([_resourceArray.firstObject isKindOfClass:UIImage.class]) {
            image = _resourceArray.firstObject;
        }else if ([_resourceArray.firstObject hasPrefix:@"http"]){
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
            [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:_resourceArray.firstObject] completed:^(UIImage * _Nullable imaget, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                if (error == nil) {
                    image = imaget;
                }
                dispatch_semaphore_signal(semaphore);
            }];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

        }else{
            image = [UIImage imageNamed:_resourceArray.firstObject];
        }
        if (image.size.width>image.size.height) {//横图
            itemW = 200;
        }
        if (image.size.width) {
            itemH = image.size.height / image.size.width * itemW;
        }

    } else {
        itemH = itemW;
    }
    long perRowItemCount = [self perRowItemCountForPicPathArray:_resourceArray];
    CGFloat margin = 5;
    [_resourceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;
        if ([obj isKindOfClass:UIImage.class]) {
            imageView.image = obj;
        }else if ([obj hasPrefix:@"http"]){
            [imageView sd_setImageWithURL:[NSURL URLWithString:obj]];
        }else{
            imageView.image = [UIImage imageNamed:obj];
        }
        
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
    }];
    
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_resourceArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    self.width = w;
    self.height = h;

}


#pragma mark - private actions

- (void)tapImageView:(UITapGestureRecognizer *)tap{
    UIView *imageView = tap.view;

    if (self.tapImageViewBlock) {
        self.tapImageViewBlock(self.resourceArray, imageView.tag);
    }
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array{
    if (array.count == 1) {
        return 120;
    } else {
        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
        return w;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array{
    if (array.count < 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}




@end
