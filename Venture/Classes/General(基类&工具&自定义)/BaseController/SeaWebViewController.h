//
//  SeaWebViewController.h

//

#import "SeaViewController.h"

/**工具条和导航栏隐藏状态 当页面滑动的时候
 */
typedef NS_ENUM(NSInteger, SeaWebViewBarHideStyle)
{
    SeaWebViewBarHideStyleNone = 0, ///不隐藏
    SeaWebViewBarHideStyleOnlyToolBar = 1, ///只隐藏工具条
    SeaWebViewBarHideStyleOnlyNavigationBar = 2, ///只隐藏导航栏
    SeaWebViewBarHideStyleAll = 3, /// 隐藏工具条和 导航栏
};


/**内嵌浏览器
 */
@interface SeaWebViewController : SeaViewController<UIWebViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate>

/**是否可以倒退
 */
@property(nonatomic,readonly) BOOL canGoBack;

/**是否可以前进
 */
@property(nonatomic,readonly) BOOL canGoForward;

/**工具条和导航栏隐藏状态 当页面滑动的时候 default is 'SeaWebViewBarHideStyleOnlyToolBar'
 */
@property(nonatomic,assign) SeaWebViewBarHideStyle barHideStyle;

/**是否使用自定义的长按手势 default is 'NO'
 */
@property(nonatomic,assign) BOOL useCumsterLongPressGesture;

/**当前链接
 */
@property(nonatomic,readonly) NSString *curURL;

/**将要打开的链接
 */
@property(nonatomic,copy) NSURL *URL;

/**将要打开的html
 */
@property(nonatomic,copy) NSString *htmlString;


/**构造方法
 *@param url 将要打开的链接
 *@return 一个实例
 */
- (id)initWithURL:(NSString*) url;

/**构造方法
 *@param htmlString 将要打开的html
 *@return 一个实例
 */
- (id)initWithHtmlString:(NSString*) htmlString;

/**后退
 */
- (void)goBack;

/**前进
 */
- (void)goForward;

/**刷新
 */
- (void)reload;

/**加载网页
 */
- (void)loadWebContent;

@end
