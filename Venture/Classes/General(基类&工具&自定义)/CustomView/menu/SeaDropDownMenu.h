//
//  SeaDropDownMenu.h
//  Sea
//
//  Created by 罗海雄 on 15/9/16.
//  Copyright (c) 2015年 Sea. All rights reserved.
//

#import <UIKit/UIKit.h>

//下拉菜单高度
#define SeaDropDownMenuHeight 45.0

/**下拉菜单按钮信息
 *@warning 下拉列表的的数量以titleLists为准
 */
@interface SeaDropDownMenuItem : NSObject

/**按钮标题，如果为空，将使用 [titleLists firstObject]
 */
@property(nonatomic,copy) NSString *title;

/**下拉的列表标题信息，数组元素是NSString
 */
@property(nonatomic,strong) NSArray *titleLists;

/**下拉的列表图标信息，数组元素是 UIImage
 */
@property(nonatomic,strong) NSArray *iconLists;

/**选中的列表标题
 */
@property(nonatomic,assign) NSInteger selectedIndex;

@end


/**下拉菜单按钮
 */
@interface SeaDropDownMenuCell : UIView

/**标题
 */
@property(nonatomic,readonly) UILabel *titleLabel;

/**指示图标
 */
@property(nonatomic,readonly) UIImageView *imageView;

/**分割线
 */
@property(nonatomic,readonly) UIView *separatorLine;

/**获取默认的三角形指示图标
 *@param color 图标颜色
 *@param size 图标大小
 */
+ (UIImage*)defaultIndicatorWithColor:(UIColor*) color size:(CGSize) size;

@end

@class SeaDropDownMenu;

/**下拉菜单代理
 */
@protocol SeaDropDownMenuDelegate <NSObject>

/**选中某个一级菜单
 */
- (void)dropDownMenu:(SeaDropDownMenu*) menu didSelectItem:(SeaDropDownMenuItem*) item;

/**选中某个二级菜单
 */
- (void)dropDownMenu:(SeaDropDownMenu *)menu didSelectItemWithSecondMenu:(SeaDropDownMenuItem *)item;

@end

/**下拉菜单，如果下拉列表的数量为0，将不显示三角箭头
 */
@interface SeaDropDownMenu : UIView

/**按钮字体
 */
@property(nonatomic,strong) UIFont *buttonTitleFont;

/**按钮字体颜色
 */
@property(nonatomic,strong) UIColor *buttonNormalTitleColor;

/**按钮字体高亮颜色
 */
@property(nonatomic,strong) UIColor *buttonHighlightTitleColor;

/**下拉列表字体
 */
@property(nonatomic,strong) UIFont *listTitleFont;

/**下拉列表字体颜色
 */
@property(nonatomic,strong) UIColor *listNormalTitleColor;

/**下拉列表字体高亮颜色
 */
@property(nonatomic,strong) UIColor *listHighLightColor;

/**下拉列表选中标识 default is 'nil'
 */
@property(nonatomic,strong) UIImage *indicatorImage;

/**选中的按钮 default is 'NSNotFound'
 */
@property(nonatomic,assign) NSInteger selectedIndex;

/**阴影颜色
 */
@property(nonatomic,strong) UIColor *shadowColor;

/**下拉列表的最大高度，default is 列表父视图的高度
 */
@property(nonatomic,assign) CGFloat listMaxHeight;

@property(nonatomic,weak) id<SeaDropDownMenuDelegate> delegate;

/**下拉列表的父视图，如果不设置，将视图菜单的俯视图
 *@warning 如果是把菜单放在导航栏上，最好设置该值，可设置当前viewController.view 作为下拉列表的俯视图
 */
@property(nonatomic,weak) UIView *listSuperview;

/**构造方法
 *@param items 按钮信息，数组元素是 SeaDropDownMenuItem
 */
- (id)initWithFrame:(CGRect)frame items:(NSArray*) items;

@end
