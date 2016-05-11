//
//  SeaMenuItemInfo.h

//

#import <Foundation/Foundation.h>

/**菜单按钮信息
 */
@interface SeaMenuItemInfo : NSObject

/**标题
 */
@property(nonatomic,copy) NSString *title;

/**按钮图标
 */
@property(nonatomic,strong) UIImage *icon;

/**按钮背景图片
 */
@property(nonatomic,strong) UIImage *backgroundImage;

/**构造方法
 *@param title 标题
 *@param icon 图标
 *@param bgImage 背景图片
 *@return 已初始化的 SeaMenuItemInfo
 */
+ (id)infoWithTitle:(NSString*) title icon:(UIImage*) icon backgroundImage:(UIImage*) bgImage;

@end
