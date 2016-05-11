//
//  SeaUtilities.m
//  Sea

//

#import "SeaUtilities.h"

/**获取圆上的坐标点
 *@param center 圆心坐标
 *@param radius 圆半径
 *@param arc 要获取坐标的弧度
 */
CGPoint PointInCircle(CGPoint center, CGFloat radius, CGFloat arc)
{
    CGFloat x = center.x + cos(arc) * radius;
    CGFloat y = center.y + sin(arc) * radius;
    
    
    return CGPointMake(x, y);
}

/**获取app名称
 */
NSString* appName()
{
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    
    return [dic objectForKey:@"CFBundleDisplayName"];
}

/**当前app版本
 */
NSString* appVersion()
{
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    
    return [dic objectForKey:@"CFBundleShortVersionString"];
}

/**注册推送通知
 */
void registerRemoteNotification()
{
    //ios 7.0以前和以后注册推送的方法不一样
    UIApplication *application = [UIApplication sharedApplication];
    
    if(![application.delegate respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)])
    {
        NSLog(@"需要在 appDelegate 中实现 'application:didRegisterForRemoteNotificationsWithDeviceToken:'");
        
        //在实现的方法中获取 token
//        NSString *pushToken = [[[[deviceToken description]
//                                 stringByReplacingOccurrencesOfString:@"<" withString:@""]
//                                stringByReplacingOccurrencesOfString:@">" withString:@""]
//                               stringByReplacingOccurrencesOfString:@" " withString:@""];
//        if(![NSString isEmpty:pushToken])
//        {
//            [[NSUserDefaults standardUserDefaults] setObject:pushToken forKey:_SeaDeviceToken_];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
    }
    
    if(IOS_8_OR_LATER && ![application.delegate respondsToSelector:@selector(application:didRegisterUserNotificationSettings:)])
    {
        NSLog(@"需要在 appDelegate 中实现 'application:didRegisterUserNotificationSettings:'");
        //在方法中调用
        //[application registerForRemoteNotifications];
    }
    
    if(IOS_8_OR_LATER)
    {
#ifdef __IPHONE_8_0
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        [application registerUserNotificationSettings:settings];
#endif
    }
    else
    {
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
}

/**取消注册推送通知
 */
void unregisterRemoteNotification()
{
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
}

BOOL isValidateStr(NSString* dest) {
    return !IsNull(dest) && !IsEmpty([dest description]);
}

/**打开系统设置
 */
void openSystemSettings()
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

/**商品价格格式化
 */
NSString* formatFloatPrice(float price){
    return [NSString stringWithFormat:@"%.2f",price];
}

/**商品价格格式化
 */
NSString* formatStringPrice(NSString* price){
    return [NSString stringWithFormat:@"%.2f",[price floatValue]];
}

/**前往商城首页  

 */
void goToMallHome(){
    NSLog(@"=======goToMallHome========");
}


