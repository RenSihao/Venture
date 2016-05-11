//
//  SeaWebToolBar.m

//

#import "SeaWebToolBar.h"
#import "SeaWebViewController.h"
#import "SeaButton.h"

@interface SeaWebToolBar ()

//浏览器
@property(nonatomic,weak) SeaWebViewController *webViewController;

//前进按钮
@property(nonatomic,strong) SeaButton *forwrodButton;

//后退按钮
@property(nonatomic,strong) SeaButton *backwordButton;

//刷新按钮
@property(nonatomic,strong) SeaButton *refreshButton;

//分享
@property(nonatomic,strong) SeaButton *shareButton;

@end

@implementation SeaWebToolBar

/**构造方法
 *@param webViewController 浏览器
 *@return 一个实例
 */
- (id)initWithWebViewController:(SeaWebViewController*)  webViewController
{
    self = [super init];
    if(self)
    {
        self.webViewController = webViewController;
        
        //创建工具条按钮
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:4];
        
        CGFloat width = 64.0;

        CGFloat height = self.webViewController.toolBarHeight;
        
        //后退按钮
        SeaButton *btn = [[SeaButton alloc] initWithFrame:CGRectMake(0, 0, width, height) buttonType:SeaButtonTypeLeftArrow];
        btn.lineColor = _UIKitTintColor_;
        [btn addTarget:self action:@selector(backword:) forControlEvents:UIControlEventTouchUpInside];
        self.backwordButton = btn;
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.backwordButton];
        [items addObject:item];
        
        item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [items addObject:item];
        
        //前进按钮
        btn = [[SeaButton alloc] initWithFrame:CGRectMake(0, 0, width, height) buttonType:SeaButtonTypeRightArrow];
        btn.lineColor = _UIKitTintColor_;
        [btn addTarget:self action:@selector(forwrod:) forControlEvents:UIControlEventTouchUpInside];
        self.forwrodButton = btn;
        
        item = [[UIBarButtonItem alloc] initWithCustomView:self.forwrodButton];
        [items addObject:item];
        
        item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [items addObject:item];
        
        //刷新按钮
        btn = [[SeaButton alloc] initWithFrame:CGRectMake(0, 0, width, height) buttonType:SeaButtonTypeRefresh];
        btn.lineColor = _UIKitTintColor_;
        [btn addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
        self.refreshButton = btn;
        
        item = [[UIBarButtonItem alloc] initWithCustomView:self.refreshButton];
        [items addObject:item];
        
        item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [items addObject:item];
        
        //分享按钮
        btn = [[SeaButton alloc] initWithFrame:CGRectMake(0, 0, width, height) buttonType:SeaButtonTypeUpload];
        btn.lineColor = _UIKitTintColor_;
        [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        self.shareButton = btn;
        
        item = [[UIBarButtonItem alloc] initWithCustomView:self.shareButton];
        [items addObject:item];
        
        item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [items addObject:item];
        
        self.webViewController.navigationController.toolbar.translucent = YES;
        self.webViewController.navigationController.toolbarHidden = NO;
        self.webViewController.toolbarItems = items;
        
        [self refreshToolBar];
    }
    return self;
}

#pragma mark- dealloc

- (void)dealloc
{
   
}

#pragma mark- public method

- (UIToolbar*)toolBar
{
    return self.webViewController.navigationController.toolbar;
}

//刷新工具条功能
- (void)refreshToolBar
{
    self.backwordButton.enabled = self.webViewController.canGoBack;
    self.forwrodButton.enabled = self.webViewController.canGoForward;
}

#pragma mark- private method

//后退
- (void)backword:(SeaButton*) btn
{
    [self.webViewController goBack];
    [self refreshToolBar];
}

//前进
- (void)forwrod:(SeaButton*) btn
{
    [self.webViewController goForward];
    [self refreshToolBar];
}

//刷新
- (void)refresh:(SeaButton*) btn
{
    [self.webViewController reload];
}

//分享
- (void)share:(SeaButton*) btn
{
    
}

@end
