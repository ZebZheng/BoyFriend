/*
  Created by BF on 2021
  Copyright © 2021年 BF. All rights reserved.
*/

#import <UIKit/UIKit.h>

/**
        UIImage (animatedGIF)
        
    This category adds class methods to `UIImage` to create an animated `UIImage` from an animated GIF.
*/
@interface UIImage (BFAnimatedGIF)

/*
        UIImage *animation = [UIImage bf_animatedImageWithAnimatedGIFData:theData];
    
    I interpret `theData` as a GIF.  I create an animated `UIImage` using the source images in the GIF.
    
    The GIF stores a separate duration for each frame, in units of centiseconds (hundredths of a second).  However, a `UIImage` only has a single, total `duration` property, which is a floating-point number.
    
    To handle this mismatch, I add each source image (from the GIF) to `animation` a varying number of times to match the ratios between the frame durations in the GIF.
    
    For example, suppose the GIF contains three frames.  Frame 0 has duration 3.  Frame 1 has duration 9.  Frame 2 has duration 15.  I divide each duration by the greatest common denominator of all the durations, which is 3, and add each frame the resulting number of times.  Thus `animation` will contain frame 0 3/3 = 1 time, then frame 1 9/3 = 3 times, then frame 2 15/3 = 5 times.  I set `animation.duration` to (3+9+15)/100 = 0.27 seconds.
*/
+ (UIImage *)bf_animatedImageWithAnimatedGIFData:(NSData *)theData;

/*
        UIImage *image = [UIImage bf_animatedImageWithAnimatedGIFURL:theURL];
    
    I interpret the contents of `theURL` as a GIF.  I create an animated `UIImage` using the source images in the GIF.
    
    I operate exactly like `+[UIImage bf_animatedImageWithAnimatedGIFData:]`, except that I read the data from `theURL`.  If `theURL` is not a `file:` URL, you probably want to call me on a background thread or GCD queue to avoid blocking the main thread.
*/
+ (UIImage *)bf_animatedImageWithAnimatedGIFURL:(NSURL *)theURL;

@end
