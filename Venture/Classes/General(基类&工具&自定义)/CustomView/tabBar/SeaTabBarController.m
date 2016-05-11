//
//  SeaTabBarViewController.m

//

#import "SeaTabBarController.h"
#import "SeaTabBar.h"
#import "SeaTabBarItem.h"
#import "SeaViewController.h"

@implementation SeaTabBarItemInfo

/**便利构造方法
 *@return 一个实例
 */
+ (SeaTabBarItemInfo*)infoWithTitle:(NSString*) title normalImage:(UIImage*) normalImage selectedImage:(UIImage*) selectedImage
{
    SeaTabBarItemInfo *info = [[SeaTabBarItemInfo alloc] init];
    info.title = title;
    info.normalImage = normalImage;
    info.selectedImage = selectedImage;
    
    return info;
}

- (void)dealloc
{
    
}

@end

@interface SeaTabBarController ()<SeaTabBarDelegate>

/**选中的视图 default is '0'
 */
@property(nonatomic,assign) NSInteger selectedItemIndex;

/**状态栏隐藏
 */
@property(nonatomic,assign) BOOL statusHidden;

/**系统状态栏样式
 */
@property(nonatomic,assign) UIStatusBarStyle statusStyle;

@end

@implementation SeaTabBarController

/**构造方法
 *@param viewControllers 需要展示的 视图控制器，数组元素是 UIVieController
 *@param items 选项卡按钮 数组元素是 SeaTabBarItemInfo
 *@return 一个实例
 */
- (id)initWithViewControllers:(NSArray*) viewControllers items:(NSArray*) items
{
    self = [super initWithNibName:nil bundle:nil];
    if(self)
    {
        _viewControllers = [viewControllers copy];
        
        //创建选项卡按钮
        NSMutableArray *tabbarItems = [NSMutableArray arrayWithCapacity:items.count];
        
        CGFloat width = SCREEN_WIDTH / items.count;
        
        for(NSInteger i = 0;i < viewControllers.count && i < items.count;i ++)
        {
            
            //创建选项卡按钮
            SeaTabBarItemInfo *info = [items objectAtIndex:i];
            SeaTabBarItem *item = [[SeaTabBarItem alloc] initWithFrame:CGRectMake(i * width, 0, width, TAB_BAR_HEIGHT) normalImage:info.normalImage selectedImage:info.selectedImage title:info.title];
            [tabbarItems addObject:item];
            
            
            //设置 tabBarController 属性
            UINavigationController *nav = [viewControllers objectAtIndex:i];
            
            if([nav isKindOfClass:[UINavigationController class]])
            {
                SeaViewController *vc = [nav.viewControllers firstObject];
                
                if([vc isKindOfClass:[SeaViewController class]])
                {
                    vc.Sea_TabBarController = self;
                }
            }
            else if([nav isKindOfClass:[SeaViewController class]])
            {
                SeaViewController *vc = (SeaViewController*)nav;
                vc.Sea_TabBarController = self;
            }
        }
        _tabBarItems = [tabbarItems copy];
        
        _selectedIndex = NSNotFound;
        _selectedItemIndex = NSNotFound;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIViewController *vc = self.selectedViewController;
    if([vc isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nav = (UINavigationController*)vc;
        vc = [nav.viewControllers lastObject];
    }
    
    if([vc isKindOfClass:[SeaViewController class]])
    {
        SeaViewController *sea_vc = (SeaViewController*)vc;
        [self setTabBarHidden:sea_vc.hideTabBar animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark- dealloc

- (void)dealloc
{
    
}

#pragma mark- public method

/**设置选项卡的状态
 *@param hidden 是否隐藏
 *@param animated 是否动画
 */
- (void)setTabBarHidden:(BOOL) hidden animated:(BOOL) animated
{
    if(hidden == self.tabBar.hidden)
        return;
    
    CGRect frame = self.tabBar.frame;
    frame.origin.y = hidden ? self.view.height : self.view.height - frame.size.height;
    
    if(animated)
    {
        [UIView animateWithDuration:kAnimatedDuration animations:^(void){
            
            self.tabBar.frame = frame;
        }completion:^(BOOL finish){
            self.tabBar.hidden = hidden;
        }];
    }
    else
    {
        self.tabBar.frame = frame;
    }
}

/**当前显示的ViewController
 */
- (UIViewController*)selectedViewController
{
    if(_selectedItemIndex < _viewControllers.count)
    {
        return [_viewControllers objectAtIndex:_selectedItemIndex];
    }
    
    return nil;
}

#pragma mark- 加载视图

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tabBar = [[SeaTabBar alloc] initWithFrame:CGRectMake(0, self.view.height - TAB_BAR_HEIGHT, SCREEN_WIDTH, TAB_BAR_HEIGHT) items:self.tabBarItems];
    _tabBar.delegate = self;
    [self.view addSubview:_tabBar];
    
    self.selectedIndex = 0;
    [self setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark- SeaTabBar delegate

- (void)tabBar:(SeaTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index
{
    self.selectedItemIndex = index;
}

- (BOOL)tabBar:(SeaTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index
{
    return YES;
}

#pragma mark- property setup

//设置选中的
- (void)setSelectedItemIndex:(NSInteger)selectedItemIndex
{
    if(_selectedItemIndex != selectedItemIndex)
    {
        UIViewController *viewController = [self selectedViewController];
  
        if(viewController)
        {
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
        }
        
        _selectedItemIndex = selectedItemIndex;
        _selectedIndex = _selectedItemIndex;
        
        viewController = [self selectedViewController];
        
        [viewController willMoveToParentViewController:self];
        [self addChildViewController:viewController];
        [self.view insertSubview:viewController.view belowSubview:self.tabBar];
        [viewController didMoveToParentViewController:self];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if(_selectedIndex != selectedIndex)
    {
        _selectedIndex = selectedIndex;
        self.tabBar.selectedIndex = _selectedIndex;
    }
}

#pragma mark- statusBar 

/**设置状态栏的隐藏状态
 */
- (void)setStatusBarHidden:(BOOL)hidden
{
    self.statusHidden = hidden;
    [self setNeedsStatusBarAppearanceUpdate];
}

/**设置状态栏样式
 */
- (void)setStatusBarStyle:(UIStatusBarStyle) style
{
    self.statusStyle = style;
    [self setNeedsStatusBarAppearanceUpdate];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusStyle;
}

- (BOOL)prefersStatusBarHidden
{
    return self.statusHidden;
}


@end
