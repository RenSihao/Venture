//
//  SeaMenuBarItem.h

//

#import <UIKit/UIKit.h>

@class SeaNumberBadge;

/**条形菜单按钮
 */
@interface SeaMenuBarItem : UIView

/**按钮
 */
@property(nonatomic,readonly) UIButton *button;

/**边缘数字
 */
@property(nonatomic,readonly) SeaNumberBadge *numberBadge;

/**是否显示边缘数字 default is 'NO'
 */
@property(nonatomic,assign) BOOL enableBadgeValue;

/**分隔符
 */
@property(nonatomic,readonly) UIView *separator;

/**构造方法
 *@param frame 位置大小
 *@param target 方法执行者
 *@param action 方法
 *@return 已初始化的 SeaMenuBarItem
 */
- (id)initWithFrame:(CGRect)frame target:(id) target action:(SEL) action;

@end
