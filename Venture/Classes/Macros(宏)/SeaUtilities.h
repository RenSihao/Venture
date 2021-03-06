//
//  SeaUtilities.h
//  Sea

//

#import <Foundation/Foundation.h>

/**实用工具
 */

/**获取圆上的坐标点
 *@param center 圆心坐标
 *@param radius 圆半径
 *@param arc 要获取坐标的弧度
 */
UIKIT_EXTERN CGPoint PointInCircle(CGPoint center, CGFloat radius, CGFloat arc);

/**获取app名称
 */
UIKIT_EXTERN NSString* appName();

BOOL isValidateStr(NSString* dest);

/**当前app版本
 */
UIKIT_EXTERN NSString* appVersion();

/**注册推送通知
 */
UIKIT_EXTERN void registerRemoteNotification();

/**取消注册推送通知
 */
UIKIT_EXTERN void unregisterRemoteNotification();

/**打开系统设置
 */
UIKIT_EXTERN void openSystemSettings();

/**商品价格格式化
 */
UIKIT_EXTERN NSString* formatFloatPrice(float price);

/**商品价格格式化
 */
UIKIT_EXTERN NSString* formatStringPrice(NSString* price);

/**前往商城首页
 */
UIKIT_EXTERN void goToMallHome();

