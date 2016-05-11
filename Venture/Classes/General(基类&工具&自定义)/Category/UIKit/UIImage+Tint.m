//
//  UIImage+Tint.m
//  MZBlog
//
//  Created by hanqing on 14-8-28.
//  Copyright (c) 2014年 Liu Yang. All rights reserved.
//

#import "UIImage+Tint.h"

void filterGreyscale(UInt8 *pixelBuf, UInt32 offset, void *context)
{
	int r = offset;
	int g = offset+1;
	int b = offset+2;
	
	int red = pixelBuf[r];
	int green = pixelBuf[g];
	int blue = pixelBuf[b];
	
	uint32_t gray = 0.3 * red + 0.59 * green + 0.11 * blue;
	
	pixelBuf[r] = gray;
	pixelBuf[g] = gray;
	pixelBuf[b] = gray;
}

@implementation UIImage (Tint)

- (UIImage *) convertToGreyscale{
    UIImage *i = self;
    int kRed = 1;
    int kGreen = 2;
    int kBlue = 4;
    int colors = kGreen;
    int m_width = i.size.width;
    int m_height = i.size.height;
    uint32_t *rgbImage = (uint32_t *) malloc(m_width * m_height * sizeof(uint32_t));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImage, m_width, m_height, 8, (int)m_width * 4, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, m_width, m_height), [i CGImage]);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    // now convert to grayscale
    uint8_t *m_imageData = (uint8_t *) malloc(m_width * m_height);
    for(int y = 0; y < m_height; y++) {
        for(int x = 0; x < m_width; x++) {
            uint32_t rgbPixel=rgbImage[y*m_width+x];
            uint32_t sum=0,count=0;
            if (colors & kRed) {sum += (rgbPixel>>24)&255; count++;}
            if (colors & kGreen) {sum += (rgbPixel>>16)&255; count++;}
            if (colors & kBlue) {sum += (rgbPixel>>8)&255; count++;}
            m_imageData[y*m_width+x]=sum/count;
        }
    }
    free(rgbImage);
    // convert from a gray scale image back into a UIImage
    uint8_t *result = (uint8_t *) calloc(m_width * m_height *sizeof(uint32_t), 1);
    // process the image back to rgb
    for(int i = 0; i < m_height * m_width; i++) {
        result[i*4]=0;
        int val=m_imageData[i];
        result[i*4+1]=val;
        result[i*4+2]=val;
        result[i*4+3]=val;
    }
    // create a UIImage
    colorSpace = CGColorSpaceCreateDeviceRGB();
    context = CGBitmapContextCreate(result, m_width, m_height, 8, m_width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    // make sure the data will be released by giving it to an autoreleased NSData
    [NSData dataWithBytesNoCopy:result length:m_width * m_height];
    return resultUIImage;
}

- (UIImage *)greyscale{
	CGImageRef inImage = self.CGImage;
    size_t width = CGImageGetWidth(inImage);
    size_t height = CGImageGetHeight(inImage);
    size_t bits = CGImageGetBitsPerComponent(inImage);
    size_t bitsPerRow = CGImageGetBytesPerRow(inImage);
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(inImage);
    int alphaInfo = CGImageGetAlphaInfo(inImage);
    
    if (alphaInfo != kCGImageAlphaPremultipliedLast &&
        alphaInfo != kCGImageAlphaNoneSkipLast) {
        if (alphaInfo == kCGImageAlphaNone ||
            alphaInfo == kCGImageAlphaNoneSkipFirst) {
            alphaInfo = kCGImageAlphaNoneSkipLast;
        }else {
            alphaInfo = kCGImageAlphaPremultipliedLast;
        }
        CGContextRef context = CGBitmapContextCreate(NULL,
                                                     width,
                                                     height,
                                                     bits,
                                                     bitsPerRow,
                                                     colorSpace,
                                                     alphaInfo);
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), inImage);
        inImage = CGBitmapContextCreateImage(context);
        CGContextRelease(context);
    }else {
        CGImageRetain(inImage);
    }
    
	CFDataRef m_DataRef = CGDataProviderCopyData(CGImageGetDataProvider(inImage));
	int length = CFDataGetLength(m_DataRef);
	CFMutableDataRef m_DataRefEdit = CFDataCreateMutableCopy(NULL,length,m_DataRef);
	CFRelease(m_DataRef);
    UInt8 * m_PixelBuf = (UInt8 *) CFDataGetMutableBytePtr(m_DataRefEdit);
    
	for (int i=0; i<length; i+=4)
	{
		filterGreyscale(m_PixelBuf,i,NULL);
	}
    CGImageRelease(inImage);
	
	CGContextRef ctx = CGBitmapContextCreate(m_PixelBuf,
											 width,
											 height,
											 bits,
											 bitsPerRow,
											 colorSpace,
											 alphaInfo
											 );
	
	CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
	CGContextRelease(ctx);
	UIImage *finalImage = [UIImage imageWithCGImage:imageRef
                                              scale:self.scale
                                        orientation:self.imageOrientation];
	CGImageRelease(imageRef);
    CFRelease(m_DataRefEdit);
	return finalImage;
	
}
- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
