//
//  SeaScrollViewController.h
//  Sea


#import "SeaViewController.h"
#import "UIScrollView+SeaDataControl.h"

/**滚动视图控制器，具有上拉加载和下拉刷新，键盘弹出时设置contentInset功能，防止键盘挡住输入框
 */
@interface SeaScrollViewController : SeaViewController


/**滚动视图 default is 'nil'
 */
@property(nonatomic,strong) UIScrollView *scrollView;

/**是否可以下拉刷新数据
 */
@property(nonatomic,assign) BOOL enableDropDown;

/**下拉刷新视图 如果 enableDropDown = NO，nil
 */
@property(nonatomic,readonly) SeaRefreshControl *refreshControl;

/**是否可以上拉加载数据 default is 'NO'
 */
@property(nonatomic,assign) BOOL enablePullUp;

/**上拉加载时的指示视图 如果 enablePullUp = NO，nil
 */
@property(nonatomic,readonly) SeaLoadMoreControl *loadMoreControl;

/**当前第几页 default is '1'
 */
@property(nonatomic,assign) int curPage;

/**刷新数据
 */
@property(nonatomic,assign) BOOL refreshing;

/**加载更多
 */
@property(nonatomic,assign) BOOL loadMore;

/**初始化视图 默认不做任何事 ，子类按需实现该方法
 */
- (void)initialization;

///以下的两个方法默认不做任何事，子类按需实现

/**开始下拉刷新
 */
- (void)beginDropDownRefresh;

/**开始上拉加载
 */
- (void)beginPullUpLoading;


///以下的两个方法，刷新结束或加载结束时调用，如果子类重写，必须调用 super方法

/**结束下拉刷新
 *@param msg 提示的信息，nil则提示 “刷新成功”
 */
- (void)endDropDownRefreshWithMsg:(NSString*) msg;

/**结束上拉加载
 *@param flag 是否还有更多信息
 */
- (void)endPullUpLoadingWithMoreInfo:(BOOL) flag;

/**手动调用下拉刷新，会有下拉动画
 */
- (void)refreshManually;

/**手动上拉加载，会有上拉动画
 */
- (void)loadMoreManually;


#pragma mark- 键盘

/**键盘是否隐藏
 */
@property(nonatomic,readonly) BOOL keyboardHidden;

/**键盘大小
 */
@property(nonatomic,readonly) CGRect keyboardFrame;

/**添加键盘监听
 */
- (void)addKeyboardNotification;

/**移除键盘监听
 */
- (void)removeKeyboardNotification;

/**键盘高度改变
 */
- (void)keyboardWillChangeFrame:(NSNotification*) notification;

/**键盘隐藏
 */
- (void)keyboardWillHide:(NSNotification*) notification;

/**键盘显示
 */
- (void)keyboardWillShow:(NSNotification*) notification;

@end
