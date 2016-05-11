//
//  SeaSlideViewController.m
//  Sea

//

#import "SeaSlideViewController.h"

/**平滑方向
 */
typedef NS_ENUM(NSInteger, SeaPanDirection)
{
    SeaPanDirectionLeftToRight = 0, ///从左到右
    SeaPanDirectionRightToLeft = 1 ///从右到左
};


@interface SeaSlideViewController ()<UIGestureRecognizerDelegate>

/**滑动手势
 */
@property(nonatomic,retain) UIPanGestureRecognizer *panGestureRecognizer;

/**内容
 */
@property(nonatomic,retain) UIView *contentView;

/**middleViewController 起始位置
 */
@property(nonatomic,assign) CGFloat previousX;

/**中间视图 起始 size
 */
@property(nonatomic,assign) CGSize centerViewSize;

///平滑方向
@property(nonatomic,assign) SeaPanDirection panDirection;

///恢复点击手势
@property(nonatomic,strong) UITapGestureRecognizer *reconverPanGestrue;

@end

@implementation SeaSlideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        [self initialization];
    }
    
    return self;
}

/**构造方法
 *@param 中间视图 不能为空
 *@param 左边视图
 *@param 右边视图
 *@return 一个实例
 */
- (id)initWithMiddleViewController:(UIViewController*) middleViewController
                leftViewController:(UIViewController*) leftViewController
               rightViewController:(UIViewController*) rightViewController
{
    self = [super initWithNibName:nil bundle:nil];
    if(self)
    {
        [self initialization];
        self.middleViewController = middleViewController;
        self.leftViewController = leftViewController;
        self.rightViewController = rightViewController;
    }
    
    return self;
}

//初始化
- (void)initialization
{
    _controlByNavigationController = NO;
    _animatedDuration = 0.25;
    self.delegates = [NSMutableArray array];
    _position = SeaSlideViewPositionMiddle;
    _leftViewWidth = _rightViewWidth = 270.0 / 320.0 * SCREEN_WIDTH;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.backgroundColor = [UIColor whiteColor];
    self.contentView = view;
    
    _reconverPanGestrue = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleReconverTap:)];
    _reconverPanGestrue.enabled = NO;
}

///恢复视图位置
- (void)handleReconverTap:(UITapGestureRecognizer*) tap
{
    if(_position == SeaSlideViewPositionMiddle)
        return;
    [self setPosition:SeaSlideViewPositionMiddle animate:YES];
}

#pragma mark- dealloc

- (void)dealloc
{
    self.panGestureRecognizerInView = nil;
}

#pragma mark- 视图消失出现

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(_controlByNavigationController)
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if(_controlByNavigationController)
    {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
}

#pragma mark- 加载视图

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSAssert(_middleViewController != nil, @"middleViewController 不能为空");
    
    self.view = self.contentView;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
    pan.delegate = self;
    
    if(self.panGestureRecognizerInView != nil)
    {
        [self.panGestureRecognizerInView addGestureRecognizer:pan];
        [self.panGestureRecognizerInView addGestureRecognizer:self.reconverPanGestrue];
    }
    else
    {
        [self.view addGestureRecognizer:pan];
        [self.view addGestureRecognizer:self.reconverPanGestrue];
    }
    
    self.panGestureRecognizer = pan;
    [self.reconverPanGestrue requireGestureRecognizerToFail:self.reconverPanGestrue];
}

#pragma mark- property setup

///背景视图
- (void)setBackgroundView:(UIView *)backgroundView
{
    if(_backgroundView != backgroundView)
    {
        [_backgroundView removeFromSuperview];
        _backgroundView = backgroundView;
        if(_backgroundView)
        {
            _backgroundView.frame = self.contentView.bounds;
            [self.contentView insertSubview:_backgroundView atIndex:0];
        }
    }
}

#pragma mark- content viewController

/**中间视图 不能为空
 */
- (void)setMiddleViewController:(UIViewController *)middleViewController
{
    NSAssert(middleViewController != nil, @"middleViewController 不能为空");
    
    if(_middleViewController != middleViewController)
    {
        if(_middleViewController != nil)
        {
            [_middleViewController.view removeFromSuperview];
            [_middleViewController removeFromParentViewController];
        }
        
        _middleViewController = middleViewController;
        
        if(_middleViewController != nil)
        {
            [_middleViewController willMoveToParentViewController:self];
            [self addChildViewController:_middleViewController];
            [self.contentView addSubview:_middleViewController.view];
            [self.contentView bringSubviewToFront:_middleViewController.view];
            [_middleViewController didMoveToParentViewController:self];
            _centerViewSize = _middleViewController.view.frame.size;
            [self setupShadow];
        }
    }
}

/**左边视图
 */
- (void)setLeftViewController:(UIViewController *)leftViewController
{
    if(_leftViewController != leftViewController)
    {
        if(_leftViewController != nil)
        {
            [_leftViewController.view removeFromSuperview];
            [_leftViewController removeFromParentViewController];
        }
        
        _leftViewController = leftViewController;
        
        if(_leftViewController != nil)
        {
            [_leftViewController willMoveToParentViewController:self];
            [self addChildViewController:_leftViewController];
            [self.contentView insertSubview:_leftViewController.view belowSubview:_middleViewController.view];
            [_leftViewController didMoveToParentViewController:self];
            
            [self layoutLeftView];
        }
    }
}

/**右边视图
 */
- (void)setRightViewController:(UIViewController *)rightViewController
{
    if(_rightViewController != rightViewController)
    {
        if(_rightViewController != nil)
        {
            [_rightViewController.view removeFromSuperview];
            [_rightViewController removeFromParentViewController];
        }
        
        _rightViewController = rightViewController;
        
        if(_rightViewController != nil)
        {
            [_rightViewController willMoveToParentViewController:self];
            [self addChildViewController:_rightViewController];
            [self.contentView insertSubview:_rightViewController.view belowSubview:_middleViewController.view];
            [_rightViewController didMoveToParentViewController:self];
            
            [self layoutRightView];
        }
    }
}

#pragma mark- content wdith

/**左边视图宽度 default is '260.0 / 320.0 * SCREEN_WIDTH'
 */
- (void)setLeftViewWidth:(CGFloat)leftViewWidth
{
    if(_leftViewWidth != leftViewWidth)
    {
        _leftViewWidth = leftViewWidth;
        [self layoutLeftView];
    }
}

/**左边视图宽度 default is '260.0 / 320.0 * SCREEN_WIDTH'
 */
- (void)setRightViewWidth:(CGFloat)rightViewWidth
{
    if(_rightViewWidth != rightViewWidth)
    {
        _rightViewWidth = rightViewWidth;
        [self layoutRightView];
    }
}

/**调整左边视图
 */
- (void)layoutLeftView
{
    CGRect frame = _leftViewController.view.frame;
    frame.size.width = _leftViewWidth;
    _leftViewController.view.frame = frame;
}

/**调整右边视图
 */
- (void)layoutRightView
{
    CGRect frame = _rightViewController.view.frame;
    frame.size.width = _rightViewWidth;
    frame.origin.x = self.view.width - _rightViewWidth;
    _rightViewController.view.frame = frame;
}

#pragma mark- shadow

- (void)setupShadow
{
    if(_middleViewController.view)
    {
        CALayer *layer = _middleViewController.view.layer;
        layer.masksToBounds = NO;
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOpacity = 0.5;
        layer.shadowOffset = CGSizeMake(1.0, 0);
        layer.shadowRadius = 2.0;
    }
}

#pragma mark- position

- (void)setPosition:(SeaSlideViewPosition)position
{
    if(_position != position)
    {
        [self setPosition:position animate:NO];
    }
}

/**动画设置当前显示的视图位置
 *@param position 新的位置
 *@param flag 是否动画
 */
- (void)setPosition:(SeaSlideViewPosition)position animate:(BOOL) flag
{
    switch (position)
    {
        case SeaSlideViewPositionLeft :
        {
            NSAssert(_leftViewController != nil, @"leftViewController = nil, 无法设置 SeaSlideViewPositionLeft");
        }
            break;
        case SeaSlideViewPositionRight :
        {
            NSAssert(_rightViewController != nil, @"rightViewController = nil, 无法设置 SeaSlideViewPositionRight");
        }
            break;
        default:
            break;
    }
    
    SeaSlideViewPosition fromPosition = _position;
    _position = position;
    
    if(fromPosition != position && self.delegates.count > 0)
    {
        for(id<SeaSlideViewControllerDelegate> delegate in _delegates)
        {
            if([delegate respondsToSelector:@selector(slideViewController:willTransitionPosition:toPosition:)])
            {
                [delegate slideViewController:self willTransitionPosition:fromPosition toPosition:position];
            }
        }
    }
    
    
    CGAffineTransform transfrom;
    
    switch (_position)
    {
        case SeaSlideViewPositionLeft :
        {
            _reconverPanGestrue.enabled = YES;
            if(_rightViewController)
            {
                [self.view sendSubviewToBack:_rightViewController.view];;
            }
            
            CGFloat width = _centerViewSize.width;
            CGFloat height = _centerViewSize.height;
            CGFloat margin = self.middleViewTopMargin;
            
            CGFloat scale = (((height - margin * 2)) / height);
            
            transfrom = CGAffineTransformMakeScale(scale, scale);
            transfrom = CGAffineTransformTranslate(transfrom, _rightViewWidth + (width * (1 - scale) / 2.0), 0);
        }
            break;
        case SeaSlideViewPositionMiddle :
        {
            transfrom = CGAffineTransformIdentity;
            _reconverPanGestrue.enabled = NO;
        }
            break;
        case SeaSlideViewPositionRight :
        {
            _reconverPanGestrue.enabled = YES;
            if(_leftViewController)
            {
                [self.view sendSubviewToBack:_leftViewController.view];
            }
            
            CGFloat width = _centerViewSize.width;
            CGFloat height = _centerViewSize.height;
            CGFloat margin = self.middleViewTopMargin;
            
            CGFloat scale = (height - margin * 2) / height;
            
            transfrom = CGAffineTransformMakeScale(scale, scale);
            transfrom = CGAffineTransformTranslate(transfrom, - _rightViewWidth - (width * (1 - scale) / 2.0), 0);
        }
            break;
    }
    
    if(flag)
    {
        [UIView animateWithDuration:_animatedDuration animations:^(void){
            
            _middleViewController.view.transform = transfrom;
            
        }completion:^(BOOL finish){
            
            if(fromPosition != position && _delegates.count > 0)
            {
                for(id<SeaSlideViewControllerDelegate> delegate in _delegates)
                {
                    if([delegate respondsToSelector:@selector(slideViewController:didTransitionPosition:toPosition:)])
                    {
                        [delegate slideViewController:self didTransitionPosition:fromPosition toPosition:position];
                    }
                }
            }
        }];
    }
    else
    {
        _middleViewController.view.transform = transfrom;
        if(fromPosition != position && _delegates.count > 0)
        {
            for(id<SeaSlideViewControllerDelegate> delegate in _delegates)
            {
                if([delegate respondsToSelector:@selector(slideViewController:didTransitionPosition:toPosition:)])
                {
                    [delegate slideViewController:self didTransitionPosition:fromPosition toPosition:position];
                }
            }
        }
    }
}

#pragma mark- UIPanGestureRecognizer

/**添加滑动手势的 view , default is 'nil', 在 SeaSlideViewController.view 中添加
 */
- (void)setPanGestureRecognizerInView:(UIView *)panGestureRecognizerInView
{
    if(_panGestureRecognizerInView != panGestureRecognizerInView)
    {
        if(_panGestureRecognizerInView && self.panGestureRecognizer)
        {
            [_panGestureRecognizerInView removeGestureRecognizer:self.panGestureRecognizer];
            [_panGestureRecognizerInView removeGestureRecognizer:self.reconverPanGestrue];
        }
        else if(self.panGestureRecognizer)
        {
            [self.view removeGestureRecognizer:self.panGestureRecognizer];
            [self.view removeGestureRecognizer:self.reconverPanGestrue];
        }
        
        _panGestureRecognizerInView = panGestureRecognizerInView;
        
        if(self.panGestureRecognizer)
        {
            [_panGestureRecognizerInView addGestureRecognizer:self.panGestureRecognizer];
            [_panGestureRecognizerInView addGestureRecognizer:self.reconverPanGestrue];
        }
    }
}

//滑动手势
- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer*) pan
{
    CGPoint point = [pan translationInView:pan.view];
    if(pan.state == UIGestureRecognizerStateBegan)
    {
        self.previousX = _middleViewController.view.left;
        
        if(_position != SeaSlideViewPositionMiddle && _middleViewTopMargin != 0)
        {
            switch (_position)
            {
                case SeaSlideViewPositionLeft :
                {
                    self.previousX = _leftViewWidth;
                }
                    break;
                case SeaSlideViewPositionRight :
                {
                    self.previousX = - _rightViewWidth;
                }
                    break;
                default:
                    break;
            }
        }
        
        if(point.x < 0)
        {
            self.panDirection = SeaPanDirectionRightToLeft;
        }
        else
        {
            self.panDirection = SeaPanDirectionLeftToRight;
        }
        
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        CGFloat x = point.x + self.previousX;
        
        if(x > _leftViewWidth)
        {
            x = _leftViewWidth;
        }
        else if(x < - _rightViewWidth)
        {
            x = - _rightViewWidth;
        }
        
        ///没有右边视图
        if(!_rightViewController && x < 0)
        {
            x = 0;
        }
        
        ///没有左边视图
        if(!_leftViewController && x > 0)
        {
            x = 0;
        }
        
        CGFloat margin = fabs(x) * (self.middleViewTopMargin / (x < 0 ? _rightViewWidth : _leftViewWidth));
        
        CGFloat scale = (_centerViewSize.height - margin * 2) / _centerViewSize.height;
        
        CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
        
        CGFloat offset = (_centerViewSize.width * (1 - scale)) / 2.0;
        if(x < 0)
        {
            offset = - offset;
        }
        transform = CGAffineTransformTranslate(transform, x + offset, 0);
        
        _middleViewController.view.transform = transform;
        
        if(x < 0)
        {
            [self.contentView sendSubviewToBack:_leftViewController.view];
        }
        else
        {
            [self.contentView sendSubviewToBack:_rightViewController.view];
        }
    }
    else
    {
        SeaSlideViewPosition targetPosition = SeaSlideViewPositionMiddle;
        
        if(_middleViewController.view.left <= 0)
        {
            if(_position == SeaSlideViewPositionMiddle)
            {
                if(point.x <= - _rightViewWidth / 3.0)
                {
                    targetPosition = SeaSlideViewPositionRight;
                }
            }
            else
            {
                if(!(point.x > 0 && fabs(point.x) >= _leftViewWidth / 3.0))
                {
                    targetPosition = SeaSlideViewPositionRight;
                }
            }
        }
        else
        {
            if(_position == SeaSlideViewPositionMiddle)
            {
                if(point.x >= _leftViewWidth / 3.0)
                {
                    targetPosition = SeaSlideViewPositionLeft;
                }
            }
            else
            {
                if(!(point.x < 0 && fabs(point.x) >= _leftViewWidth / 3.0))
                {
                    targetPosition = SeaSlideViewPositionLeft;
                }
            }
        }
        
        if(targetPosition == SeaSlideViewPositionLeft && !_leftViewController)
            return;
        if(targetPosition == SeaSlideViewPositionRight && !_rightViewController)
            return;
        
        [self setPosition:targetPosition animate:YES];
    }
}

#pragma mark- UIGestureRecognizer delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

@end


@implementation UIViewController (SeaSlideViewControllerExtentions)

/**获取侧滑菜单控制视图
 */
- (SeaSlideViewController*)slideViewController
{
    if([self.navigationController.parentViewController isKindOfClass:[SeaSlideViewController class]])
    {
        return (SeaSlideViewController*)self.navigationController.parentViewController;
    }
    
    if([self.parentViewController isKindOfClass:[SeaSlideViewController class]])
    {
        return (SeaSlideViewController*)self.parentViewController;
    }
    
    return nil;
}

@end
