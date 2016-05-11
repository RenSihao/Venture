//
//  SeaMenuItemInfo.m

//

#import "SeaMenuItemInfo.h"

@implementation SeaMenuItemInfo

- (void)dealloc
{
    
}

/**构造方法
 *@param title 标题
 *@param icon 图标
 *@param bgImage 背景图片
 *@return 已初始化的 SeaMenuItemInfo
 */
+ (id)infoWithTitle:(NSString*) title icon:(UIImage*) icon backgroundImage:(UIImage*) bgImage
{
    SeaMenuItemInfo *info = [[SeaMenuItemInfo alloc] init];
    info.title = title;
    info.icon = icon;
    info.backgroundImage = bgImage;
    
    return info;
}

@end
