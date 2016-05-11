//
//  UIImage+Image.h
//  MicroBlog
//
//  Created by xujiajia on 15/11/5.
//  Copyright © 2015年 xujiajia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

+ (instancetype)imageWithOriginalName:(NSString *)imageName;
+ (instancetype)imageWithStrechableName:(NSString *)imageName;
+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end
