//
//  SeaLoadMoreControl.m
//  Sea

//

#import "SeaLoadMoreControl.h"

/**加载临界点 contentOffset
 */
static const CGFloat SeaLoadMoreControlCriticalPoint = 45.0;

/**文字提示内容改变
 */
static NSString *const SeaLoadMoreControlText = @"text";

/**UIScrollView 的内容大小
 */
static NSString *const SeaDataControlContentSize = @"contentSize";

@implementation SeaLoadMoreControl

- (id)initWithScrollView:(UIScrollView *)scrollView
{
    self = [super initWithScrollView:scrollView];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithWhite:0.99 alpha:1.0];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_activityIndicatorView];
        
        _remindLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _remindLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        _remindLabel.font = [UIFont fontWithName:MainFontName size:15.0];
        _remindLabel.backgroundColor = [UIColor clearColor];
        _remindLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [_remindLabel addGestureRecognizer:tap];
        
        [self addSubview:_remindLabel];
        
        //添加文字改变kvo
        [_remindLabel addObserver:self forKeyPath:SeaLoadMoreControlText options:NSKeyValueObservingOptionNew context:NULL];
        
        [self setState:SeaDataControlNormal];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //调整内容
    CGFloat margin = 5.0;
    CGFloat minHeight = SeaLoadMoreControlCriticalPoint;
    
    CGRect frame = self.frame;
    frame.size.height = MAX(minHeight, self.scrollView.contentOffset.y + self.scrollView.height - self.scrollView.contentSize.height);
    frame.origin.y = self.scrollView.contentSize.height;
    
    self.frame = frame;
    
    _activityIndicatorView.center = CGPointMake((self.width - _activityIndicatorView.width - _remindLabel.width - margin) / 2.0, minHeight / 2.0);
    
    frame = _remindLabel.frame;
    frame.origin.x = _activityIndicatorView.right + margin;
    frame.size.height = minHeight;
    _remindLabel.frame = frame;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if(newSuperview)
    {
        //添加 内容大小监听
        [newSuperview addObserver:self forKeyPath:SeaDataControlContentSize options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)removeFromSuperview
{
    [_remindLabel removeObserver:self forKeyPath:SeaLoadMoreControlText];
    [self.superview removeObserver:self forKeyPath:SeaDataControlContentSize];
    [super removeFromSuperview];
}

#pragma mark- dealloc

- (void)dealloc
{
    
}

#pragma mark- kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:SeaDataControlOffset])
    {
        if(self.state == SeaDataControlStateNoData || self.hidden || self.scrollView.contentSize.height == 0 || self.scrollView.contentOffset.y < self.scrollView.contentSize.height - self.scrollView.height || self.scrollView.contentSize.height < self.scrollView.height)
            return;
        
        if(self.state != SeaDataControlLoading)
        {
            if(self.scrollView.contentOffset.y >= self.scrollView.contentSize.height - self.scrollView.height && self.state != SeaDataControlLoading)
            {
                if(self.scrollView.dragging)
                {
                    if (self.scrollView.contentOffset.y == self.scrollView.contentSize.height - self.scrollView.height)
                    {
                        [self setState:SeaDataControlNormal];
                    }
                    else if (self.scrollView.contentOffset.y < self.scrollView.contentSize.height - self.scrollView.height + SeaLoadMoreControlCriticalPoint)
                    {
                        [self setState:SeaDataControlPulling];
                    }
                    else
                    {
                        [self setState:SeaDataControlReachCirticalPoint];
                    }
                }
                else if(self.scrollView.contentOffset.y >= self.scrollView.contentSize.height - self.scrollView.height + SeaLoadMoreControlCriticalPoint || self.state == SeaDataControlLoading)
                {
                    if(!self.animating)
                    {
                        [self beginLoadMore];
                    }
                }
            }
        }
        
        if(!self.animating)
        {
            [self setNeedsLayout];
        }
    }
    else if ([keyPath isEqualToString:SeaLoadMoreControlText])
    {
        //调整内容
        CGFloat margin = 5.0;
        CGFloat textWidth = [_remindLabel.text stringSizeWithFont:_remindLabel.font contraintWith:self.width - _activityIndicatorView.width - margin].width;
        _remindLabel.width = textWidth;
        [self setNeedsLayout];
    }
    else if ([keyPath isEqualToString:SeaDataControlContentSize])
    {
        [self setNeedsLayout];
    }
}

- (void)beginRefresh
{
    [self beginLoadMore];
}

/**开始加载更多
 */
- (void)beginLoadMore
{
    if(self.animating)
        return;
    
    self.animating = YES;
    [UIView animateWithDuration:kAnimatedDuration animations:^(void){
        
        UIEdgeInsets inset = self.originalContentInset;
        inset.bottom = SeaLoadMoreControlCriticalPoint;
        self.scrollView.contentInset = inset;
    }completion:^(BOOL finish){
        
        [self setState:SeaDataControlLoading];
        self.animating = NO;
    }];
}

#pragma mark- 设置滑动状态

- (void)setState:(SeaDataControlState) aState
{
    switch (aState)
    {
        case SeaDataControlNormal :
        {
            self.remindLabel.hidden = NO;
            self.remindLabel.userInteractionEnabled = YES;
            self.remindLabel.text = @"加载更多";
            [self.activityIndicatorView stopAnimating];
            self.scrollView.contentInset = self.originalContentInset;
        }
            break;
        case SeaDataControlLoading :
        {
            [self performSelector:@selector(startRefresh) withObject:nil afterDelay:self.refreshDelay];
        }
            break;
        case SeaDataControlPulling :
        {
            
        }
            break;
        case SeaDataControlReachCirticalPoint :
        {
            
        }
            break;
        case SeaDataControlStateNoData :
        {
            [_activityIndicatorView stopAnimating];
            self.remindLabel.text = @"已到底部";
            self.remindLabel.userInteractionEnabled = NO;
            self.remindLabel.hidden = YES;
            [UIView animateWithDuration:kAnimatedDuration animations:^(void){
                
                UIEdgeInsets inset = self.originalContentInset;
               // inset.bottom = SeaLoadMoreControlCriticalPoint;
                self.scrollView.contentInset = inset;
            }];
        }
            break;
    }
    
    [super setState:aState];
}

/**数据加载完成
 */
- (void)didFinishedLoading
{
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:self.stopDelay];
}

/**已经没有更多信息可以加载
 */
- (void)noMoreInfo
{
    [self performSelector:@selector(stopRefreshWithNoInfo) withObject:nil afterDelay:self.stopDelay];
}

- (void)stopRefreshWithNoInfo
{
    [self setState:SeaDataControlStateNoData];
}

//停止刷新
- (void)stopRefresh
{
    self.remindLabel.userInteractionEnabled = YES;
    [UIView animateWithDuration:kAnimatedDuration animations:^(void)
     {
         [self.scrollView setContentInset:self.originalContentInset];
     }
     completion:^(BOOL finish)
     {
         [self setState:SeaDataControlNormal];
     }];
}

//开始加载
- (void)startRefresh
{
    _remindLabel.userInteractionEnabled = NO;
    _remindLabel.text = @"加载中...";
    [_activityIndicatorView startAnimating];
    if(self.refreshBlock)
    {
        self.refreshBlock();
    }
}

#pragma mark- private method

- (void)handleTap:(UITapGestureRecognizer*) tap
{
    if(self.state != SeaDataControlLoading)
    {
        [self setState:SeaDataControlLoading];
    }
}

@end
