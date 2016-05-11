//
//  SeaTickerLabel.m

//

#import "SeaTickerLabel.h"

@implementation SeaTickerLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

//初始化
-(void)initialization
{
    _insets = UIEdgeInsetsZero;
    [self setClipsToBounds:YES];
    
    _tickerLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _tickerLabel.textColor = [UIColor blackColor];
    [_tickerLabel setBackgroundColor:[UIColor clearColor]];
    [_tickerLabel setNumberOfLines:1];
    [self addSubview:_tickerLabel];
    
    self.tickerSpeed = 60.0;
    self.loops = YES;
    self.direction = SeaTickerAnimatedDirectionLeftToRight;
}

#pragma mark- property

- (void)setInsets:(UIEdgeInsets)insets
{
    if(!UIEdgeInsetsEqualToEdgeInsets(_insets, insets))
    {
        _insets = insets;
        CGRect frame = _tickerLabel.frame;
        frame.origin.y = _insets.top;
        frame.size.height = self.bounds.size.height - _insets.top - _insets.bottom;
        _tickerLabel.frame = frame;
    }
}

#pragma mark- dealloc

- (void)dealloc
{
    
}

#pragma mark- animate

//滚动当前的文字
-(void)animateCurrentTickerString
{
    NSString *currentString = [_tickerStrings objectAtIndex:_currentIndex];
    
    //获取文本框大小
    CGSize textSize = [currentString stringSizeWithFont:_tickerLabel.font contraintWith:CGFLOAT_MAX];
    
    //设置起点和终点
    float startingX = 0.0f;
    float endX = 0.0f;
    switch (_direction) {
        case SeaTickerAnimatedDirectionRightToLeft :
            startingX = -textSize.width;
            endX = self.frame.size.width;
            break;
        case SeaTickerAnimatedDirectionLeftToRight :
        default:
            startingX = self.frame.size.width;
            endX = -textSize.width;
            break;
    }
    
    //设置起点
    [_tickerLabel setFrame:CGRectMake(startingX, _tickerLabel.frame.origin.y, textSize.width, _tickerLabel.bounds.size.height)];
    [_tickerLabel setText:currentString];
    
    //计算动画时间
    float duration = (textSize.width + self.frame.size.width) / _tickerSpeed;

    //创建动画
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(tickerMoveAnimationDidStop:finished:context:)];
    
    //设置终点位置
    CGRect tickerFrame = _tickerLabel.frame;
    tickerFrame.origin.x = endX;
    [_tickerLabel setFrame:tickerFrame];
    
    [UIView commitAnimations];
}

//动画结束
-(void)tickerMoveAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    _currentIndex++;
    
    if(_currentIndex >= [_tickerStrings count])
    {
        _currentIndex = 0;
        if(!_loops)
        {
            _running = NO;
            return;
        }
    }
    [self animateCurrentTickerString];
}

#pragma mark - Ticker Animation Handling

-(void)start
{
    _currentIndex = 0;
    _running = YES;
    [self animateCurrentTickerString];
}

-(void)pause
{
    if(_running)
    {
        [self pauseLayer:self.layer];
        _running = NO;
    }
}

-(void)resume
{
    if(!_running)
    {
        [self resumeLayer:self.layer];
        _running = YES;
    }
}

#pragma mark - UIView layer animations utilities

//暂停动画
-(void)pauseLayer:(CALayer *)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

//恢复动画
-(void)resumeLayer:(CALayer *)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}


@end
