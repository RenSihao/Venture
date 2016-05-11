//
//  SeaNavigationController.m
//  Sea

//
//

#import "SeaNavigationController.h"
#import "SeaViewController.h"

@interface SeaNavigationController ()

/**原来的样式
 */
@property(nonatomic,assign) UIStatusBarStyle orgStyle;

@end

@implementation SeaNavigationController


+ (void)initialize
{
    //设置默认导航条
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedIn:[SeaNavigationController class], nil];
    
    NSDictionary *dic = nil;
    

    dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont fontWithName:MainFontName size:20.0], NSFontAttributeName, nil];

    
   // navigationBar.translucent = NO;
    UIColor *color = _navigationBarBackgroundColor_;
    
    navigationBar.barTintColor = color;
    
    navigationBar.tintColor = [UIColor blackColor];

    [navigationBar setTitleTextAttributes:dic];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _targetStatusBarStyle = UIStatusBarStyleDefault;
        self.orgStyle = [UIApplication sharedApplication].statusBarStyle;
    }
    return self;
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//   
//    //这里要把状态栏样式还原
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //设置选项卡和隐藏状态
    if([viewController isKindOfClass:[SeaViewController class]])
    {
        SeaViewController *tmp = [self.viewControllers lastObject];
        if([tmp isKindOfClass:[SeaViewController class]])
        {
            SeaViewController *vc = (SeaViewController*)viewController;
            vc.hidesBottomBarWhenPushed = tmp.hidesBottomBarWhenPushed;
            vc.Sea_TabBarController = tmp.Sea_TabBarController;
        }
    }
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
}

- (void)setTargetStatusBarStyle:(UIStatusBarStyle)targetStatusBarStyle
{
    _targetStatusBarStyle = targetStatusBarStyle;
    self.modalPresentationCapturesStatusBarAppearance = YES;
    [self setNeedsStatusBarAppearanceUpdate];

}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.targetStatusBarStyle;
}


- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    SeaViewController *vc = [self.viewControllers lastObject];
    
    UIViewController *viewController = viewControllerToPresent;
    
    if([viewController isKindOfClass:[UINavigationController class]])
    {
        viewController = [[(UINavigationController*)viewControllerToPresent viewControllers] lastObject];
    }
    
    if([vc isKindOfClass:[SeaViewController class]] && [viewController isKindOfClass:[SeaViewController class]])
    {
        SeaViewController *tmp = (SeaViewController*)viewController;
        tmp.Sea_TabBarController = vc.Sea_TabBarController;
    }
    
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}


@end
