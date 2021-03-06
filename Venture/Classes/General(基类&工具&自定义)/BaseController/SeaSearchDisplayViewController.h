//
//  SeaSearchDisplayViewController.h
//  Sea

//

#import "SeaTableViewController.h"


/**搜索栏位置
 */
typedef NS_ENUM(NSInteger, SeaSearchBarPosition)
{
    SeaSearchBarPositionTableViewTop = 0, ///搜索栏在列表顶部
    SeaSearchBarPositionTableViewHeader = 1, ///搜索栏在表头
    
    SeaSearchBarPositionNavigationBar = 2, ///搜索栏在导航栏
    SeaSearchBarPositionShowWhenSearch = 3, ///搜索栏隐藏，当点击导航栏右边搜索按钮时，才显示搜索栏
};

/**可以搜索的控制视图
 *@warning 如果搜索栏位置是 SeaSearchBarPositionTableViewHeader 并且子类有重写 - (void)scrollViewDidScroll:(UIScrollView *)scrollView，必须调用super
 */
@interface SeaSearchDisplayViewController : SeaTableViewController<UISearchBarDelegate>

/**搜索栏，通过设置tintColor，可改变取消按钮的颜色
 */
@property(nonatomic,readonly) UISearchBar *searchBar;

/**搜索栏输入框
 */
@property(nonatomic,readonly) UITextField *searchTextField;

/**搜索栏取消按钮
 */
@property(nonatomic,readonly) UIButton *searchCancelButton;

/**搜索结果
 */
@property(nonatomic,readonly) NSMutableArray *searchResults;

/**是否正在搜索
 */
@property(nonatomic,readonly) BOOL searching;

/**在搜索期间是否隐藏导航栏，default is 'YES'，如果搜索栏的位置是 SeaSearchBarPositionNavigationBar，将忽略该值，如果搜索栏的位置是 SeaSearchBarPositionShowWhenSearch，此值一定为YES
 */
@property(nonatomic,assign) BOOL hideNavigationBarWhileSearching;

/**是否显示黑色半透明视图，在搜索期间并且没有输入搜索内容 default is 'YES'
 */
@property(nonatomic,assign) BOOL showBackgroundWhileSearchingAndEmptyInput;

/**是否隐藏隐藏键盘当开始滑动时 default is 'YES'
 */
@property(nonatomic,assign) BOOL hideKeyboardWhileScroll;

/**搜索栏位置 default is 'SeaSearchBarPositionTableViewTop'
 */
@property(nonatomic,readonly) SeaSearchBarPosition searchBarPosition;

/**构造方法
 *@param searchBarPosition 搜索栏位置
 *@return 一个初始化的 SeaSearchDisplayViewController
 */
- (id)initWithSearchBarPosition:(SeaSearchBarPosition) position;

/**搜索关键字改变 默认return NO，子类可重写该方法
 *@param string 当前搜索的关键字
 */
- (void)searchStringDidChangeWithString:(NSString*) string;

/**点击搜索按钮 默认不做任何事，子类可重写该方法
 *@param string 当前关键字
 */
- (void)searchButtonDidClickWithString:(NSString*) string;

/**点击取消搜索
 */
- (void)searchCancelDidClick;

/**取消搜索
 */
- (void)cancelSearch;

@end

