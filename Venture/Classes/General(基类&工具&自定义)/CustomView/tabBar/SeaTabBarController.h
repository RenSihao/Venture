//
//  SeaTabBarViewController.h

//

#import <UIKit/UIKit.h>

/**选项卡按钮信息
 */
@interface SeaTabBarItemInfo : NSObject

/**按钮标题
 */
@property(nonatomic,strong) NSString *title;

/**按钮未选中图标
 */
@property(nonatomic,strong) UIImage *normalImage;

/**按钮选中图标
 */
@property(nonatomic,strong) UIImage *selectedImage;

/**便利构造方法
 *@return 一个实例
 */
+ (SeaTabBarItemInfo*)infoWithTitle:(NSString*) title normalImage:(UIImage*) normalImage selectedImage:(UIImage*) selectedImage;

@end

@class SeaTabBar;

/**选项卡控制器
 */
@interface SeaTabBarController : UIViewController

/**选中的视图 default is '0'
 */
@property(nonatomic,assign) NSInteger selectedIndex;

/**需要展示的 视图控制器，数组元素是 UIVieController
 */
@property(nonatomic,readonly,copy) NSArray *viewControllers;

/**当前显示的 viewController
 */
@property(nonatomic,readonly) UIViewController *selectedViewController;

/**选项卡按钮 数组元素是 SeaTabBarItem
 */
@property(nonatomic,readonly,copy) NSArray *tabBarItems;

/**选项卡
 */
@property(nonatomic,readonly) SeaTabBar *tabBar;

/**构造方法
 *@param viewControllers 需要展示的 视图控制器，数组元素是 UIVieController
 *@param items 选项卡按钮 数组元素是 SeaTabBarItemInfo
 *@return 一个实例
 */
- (id)initWithViewControllers:(NSArray*) viewControllers items:(NSArray*) items;

/**设置选项卡的状态
 *@param hidden 是否隐藏
 *@param animated 是否动画
 */
- (void)setTabBarHidden:(BOOL) hidden animated:(BOOL) animated;

#pragma mark- statusBar

/**设置状态栏的隐藏状态
 */
- (void)setStatusBarHidden:(BOOL)hidden;

/**设置状态栏样式
 */
- (void)setStatusBarStyle:(UIStatusBarStyle) style;

@end
