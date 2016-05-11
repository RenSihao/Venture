//
//  AppMacro.h
//  Venture
//
//  Created by RenSihao on 16/5/10.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h


#pragma mark - 预编译函数

//不需要在主线程上使用 dispatch_get_main_queue
#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define IsEmpty(source) !(source&&source.length>0)
#define IsNull(source) [source isKindOfClass:[NSNull class]]

//点击列表后，还原列表状态为deselect状态
#define deselectRowWithTableView(tableView) double delayInSeconds = 1.0;dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));dispatch_after(popTime, dispatch_get_main_queue(), ^(void){[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];});

//随机颜色
#define kColorARC4Random [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

//Document文件夹路径
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//self弱引用
#define weakSelf(args)   __weak typeof(args) weakSelf = args

//self强引用
#define strongSelf(args) __strong typeof(args) strongSelf = args

//release项目不打印日志
#ifndef __OPTIMIZE__ //debug
#define NSLog(format, ...)  NSLog((@"FUNC:%s\n" "LINE:%d\n" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else //release
#define SHLog(format, ...)
#endif


#pragma mark - 枚举


#pragma mark - 适配机型和系统

#define WINDOW_3_5_INCH ([[UIScreen mainScreen] bounds].size.height == HEIGHT_3_5_INCH)
#define WINDOW_4_INCH   ([[UIScreen mainScreen] bounds].size.height == HEIGHT_4_INCH)
#define WINDOW_4_7_INCH ([[UIScreen mainScreen] bounds].size.height == HEIGHT_4_7_INCH)
#define WINDOW_5_5_INCH ([[UIScreen mainScreen] bounds].size.height == HEIGHT_5_5_INCH)

#define IOS_7_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_8_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS_9_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

#pragma mark - Frame

#define STATUES_HEIGHT 20 //默认状态栏高度
#define NAV_BAR_HEIGHT 44 //默认NavigationBar高度
#define TAB_BAR_HEIGHT 49 //默认TabBar高度

#define NAVIBAR_AND_STATUSBAR_HEIGHT 64

#define SCREEN_BOUNDS       [UIScreen mainScreen].bounds
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height

#define CGWidth(rect)       rect.size.width
#define CGHeight(rect)      rect.size.height
#define CGOriginX(rect)     rect.origin.x
#define CGOriginY(rect)     rect.origin.y
#define CGEndX(rect)        rect.origin.x + rect.size.width
#define CGEndY(rect)        rect.origin.y + rect.size.height

#define WIDTH_3_5_INCH  320.f
#define WIDTH_4_INCH    320.f
#define WIDTH_4_7_INCH  375.f
#define WIDTH_5_5_INCH  414.f
#define HEIGHT_3_5_INCH 480.f
#define HEIGHT_4_INCH   568.f
#define HEIGHT_4_7_INCH 667.f
#define HEIGHT_5_5_INCH 736.f

#pragma mark - Font

#define MainFontName @"HelveticaNeue"
//数字字体、英文字体
#define MainNumberFontName [UIFont systemFontOfSize:14].fontName




#pragma mark - Color

//UIColor 十六进制RGB_0x
#define UIColorFromRGB_0x(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//UIColor 十六进制RGBA_0x
#define UIColorFromRGBA_0x(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF000000) >> 24))/255.0 \
green:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
blue:((float)((rgbValue & 0xFF00) >>8 ))/255.0 \
alpha:((float)(rgbValue & 0xFF))/255.0]

//UIColor 十进制RGB_D
#define UIColorFromRGB_D(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

//UIColor 十进制RGBA_D
#define UIColorFromRGBA_D(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]

/************** CGColor *****************/
//CGColor 十六进制RGB_0x
#define CGColorFromRGB_0x(rgbValue) UIColorFromRGB_0x(rgbValue).CGColor

//CGColor 十六进制RGBA_0x
#define CGColorFromRGBA_0x(rgbValue) UIColorFromRGB_0x(rgbVaue).CGColor

//CGColor 十进制RGB_D
#define CGColorFromRGB_D(R, G, B) UIColorFromRGB_D(R, G, B).CGColor

//CGColor 十进制RGBA_D
#define CGColorFromRGBA_D(R, G, B, A) UIColorFromRGBA_D(R, G, B, A).CGColor

#define _UIKitTintColor_ [UIColor colorWithRed:0 green:0.4784314 blue:1.0 alpha:1.0]
//分割线颜色
#define _separatorLineColor_ [UIColor colorWithWhite:0.85 alpha:1.0]
#define _separatorLineWidth_ 0.7

//主要字体颜色
#define MainGrayColor [UIColor colorWithRed:102.0 / 255.0 green:102.0 / 255.0 blue:102.0 / 255.0 alpha:1.0] ///#666666
#define MainTextColor MainGrayColor

//导航栏背景颜色
#define _navigationBarBackgroundColor_ [UIColor whiteColor]

//导航栏的颜色
#define kDefaultColor [UIColor colorWithRed:237/255.0 green:101/255.0 blue:90/255.0 alpha:1.0]

//app主色调
#define _appMainColor_ WMRedColor
/**红色
 */
#define WMRedColor [UIColor colorFromHexadecimal:@"ED6655"]

#endif /* AppMacro_h */
