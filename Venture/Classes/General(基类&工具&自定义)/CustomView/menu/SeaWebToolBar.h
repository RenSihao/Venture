//
//  SeaWebToolBar.h

//

#import <Foundation/Foundation.h>

@class SeaWebViewController;

/**网页工具条，具有前进，后退，刷新，分享功能
 */
@interface SeaWebToolBar : NSObject

/**工具条
 */
@property(nonatomic,readonly) UIToolbar *toolBar;

/**构造方法
 *@param webViewController 浏览器
 *@return 一个实例
 */
- (id)initWithWebViewController:(SeaWebViewController*)  webViewController;

/**刷新工具条功能
 */
- (void)refreshToolBar;

@end
