//
//  SeaCountDownButton.m
//  Sea
//
//  Created by 罗海雄 on 15/9/14.
//  Copyright (c) 2015年 Sea. All rights reserved.
//

#import "SeaCountDownButton.h"

@interface SeaCountDownButton ()

/**计时器
 */
@property(nonatomic,strong) NSTimer *timer;

/**开始计时的时间
 */
@property(nonatomic,strong) NSDate *startDate;

/**当前时间
 */
@property(nonatomic,assign) int curTimeInterval;

@end

@implementation SeaCountDownButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initialization];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self initialization];
    }
    return self;
}

/**初始化
 */
- (void)initialization
{
    self.countdownTimeInterval = 60;
    self.normalBackgroundColor = WMRedColor;
    self.disableBackgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:MainFontName size:14.0];
    [self setTitle:@"60s" forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    /**添加进入前台通知
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma mark- property

/**正常时 UIControlStateNormal 按钮背景颜色
 */
- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor
{
    if(![_normalBackgroundColor isEqualToColor:normalBackgroundColor])
    {
        if(normalBackgroundColor == nil)
            normalBackgroundColor = WMRedColor;
        _normalBackgroundColor = normalBackgroundColor;
        if(!self.timing)
        {
            self.backgroundColor = _normalBackgroundColor;
        }
    }
}

/**倒计时 UIControlStateDisable 按钮背景颜色
 */
- (void)setDisableBackgroundColor:(UIColor *)disableBackgroundColor
{
    if(![_disableBackgroundColor isEqualToColor:disableBackgroundColor])
    {
        if(disableBackgroundColor == nil)
            disableBackgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
        _disableBackgroundColor = disableBackgroundColor;
        if(self.timing)
        {
            self.backgroundColor = _disableBackgroundColor;
        }
    }
}

#pragma mark- 通知

/**程序进入前台
 */
- (void)applicationDidBecomeActive:(NSNotification*) notification
{
    if(self.timing)
    {
        NSTimeInterval interval = fabs([self.startDate timeIntervalSinceNow]);
        self.curTimeInterval = self.countdownTimeInterval - interval;
        if(self.curTimeInterval < 0)
        {
            [self stopTimer];
        }
    }
}

#pragma mark- 计时器

/**是否正在计时
 */
- (BOOL)timing
{
    return self.timer != nil;
}

/**开始计时
 */
- (void)startTimer
{
    if(!self.timer)
    {
        self.startDate = [NSDate date];
        self.curTimeInterval = self.countdownTimeInterval;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
        [self.timer fire];
        self.enabled = NO;
        self.backgroundColor = self.disableBackgroundColor;
    }
}

/**停止计时
 */
- (void)stopTimer
{
    if(self.timer && [self.timer isValid])
    {
        [self.timer invalidate];
        self.timer = nil;
        self.enabled = YES;
        self.backgroundColor = self.normalBackgroundColor;
    }
}

/**倒计时
 */
- (void)countDown:(id) sender
{
    self.curTimeInterval --;
    if(self.curTimeInterval < 0)
    {
        [self stopTimer];
        return;
    }
    [self setTitle:[NSString stringWithFormat:@"%ds", self.curTimeInterval] forState:UIControlStateDisabled];
}


@end
