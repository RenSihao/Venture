//
//  UBMenuBar.h

//

#import <UIKit/UIKit.h>

//默认高度
#define _SeaMenuBarHeight_ 40.0

//SeaMenuBar 样式
typedef NS_ENUM(NSInteger, SeaMenuBarStyle)
{
    SeaMenuBarStyleDefault = 0, ///默认样式，每个按钮的宽度一样
    SeaMenuBarStyleItemWithRelateTitle = 1, //按钮的宽度和标题宽度对应
    SeaMenuBarStyleItemWithRelateTitleInFullScreen = 2, //按钮的宽度和标题宽度对应,菜单按钮占满菜单栏
};

@class SeaMenuBar;

/**条形菜单代理
 */
@protocol SeaMenuBarDelegate <NSObject>

- (void)menuBar:(SeaMenuBar*) menu didSelectItemAtIndex:(NSInteger) index;

@end

/**条形菜单 当菜单按钮数量过多时，可滑动查看更多的按钮
 */
@interface SeaMenuBar : UIView

/**菜单按钮字体颜色 default is '[UIColor blackColor]'
 */
@property(nonatomic,strong) UIColor *titleColor;

/**菜单字体
 */
@property(nonatomic,strong) UIFont *titleFont;

/**菜单按钮 选中颜色 default is '_appMainColor_'
 */
@property(nonatomic,strong) UIColor *selectedColor;

/**当前选中的菜单按钮下标 default is '0'
 */
@property(nonatomic,assign) NSInteger selectedIndex;

/**底部分割线
 */
@property(nonatomic,readonly) UIView *separatorLine;

/**顶部分割线
 */
@property(nonatomic,readonly) UIView *topSeparatorLine;

/**样式 default is 'SeaMenuBarStyleDefault'
 */
@property(nonatomic,readonly) SeaMenuBarStyle style;

/**按钮间隔 default is '0'
 */
@property(nonatomic,assign) CGFloat buttonInterval;

/**按钮宽度延伸 defautl is '20.0'
 */
@property(nonatomic,assign) CGFloat buttonWidthExtension;

/**是否显示分隔符 default is 'NO'
 */
@property(nonatomic,assign) BOOL showSeparator;

/**内容边距 default is 'UIEdgeInsetsZero'
 */
@property(nonatomic,assign) UIEdgeInsets contentInsets;

@property(nonatomic,weak) id<SeaMenuBarDelegate> delegate;

/**构造方法
 *@param frame 位置大小
 *@param titles 菜单按钮标题，数组元素是 NSString
 *@param style 样式
 *@return 已初始化的 UBMenuBar
 */
- (id)initWithFrame:(CGRect)frame titles:(NSArray*) titles style:(SeaMenuBarStyle) style;

/**设置选中的菜单按钮
 *@param selectedIndex 菜单按钮下标
 *@param flag 是否动画
 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL) flag;



@end
