//
//  UIImage+Tint.h
//  MZBlog
//
//  Created by hanqing on 14-8-28.
//  Copyright (c) 2014年 Liu Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;
- (UIImage *) greyscale;
- (UIImage *) convertToGreyscale;
@end
