//
//  SeaMenuBarItem.m

//

#import "SeaMenuBarItem.h"
#import "SeaNumberBadge.h"

@implementation SeaMenuBarItem

/**构造方法
 *@param frame 位置大小
 *@param target 方法执行者
 *@param action 方法
 *@return 已初始化的 SeaMenuBarItem
 */
- (id)initWithFrame:(CGRect)frame target:(id) target action:(SEL) action
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = self.bounds;
        [_button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        
        CGFloat height = frame.size.height / 2.0;
        CGFloat width = 1.0;
        
        _separator = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - width, (frame.size.height - height) / 2.0, width, height)];
        _separator.backgroundColor = [UIColor colorWithWhite:0.90 alpha:0.5];
        _separator.userInteractionEnabled = NO;
        _separator.hidden = YES;
        [self addSubview:_separator];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _button.frame = self.bounds;
    if(_enableBadgeValue)
    {
        _numberBadge.left = self.width - _numberBadge.width;
    }
    _separator.frame = CGRectMake(self.width - _separator.width, (self.height - _separator.height) / 2.0, _separator.width, _separator.height);
}

//设置是否显示边缘数据
- (void)setEnableBadgeValue:(BOOL)enableBadgeValue
{
    if(_enableBadgeValue != enableBadgeValue)
    {
        _enableBadgeValue = enableBadgeValue;
        if(_enableBadgeValue)
        {
            if(!_numberBadge)
            {
                _numberBadge = [[SeaNumberBadge alloc] initWithFrame:CGRectMake(self.width - _badgeViewWidth_, 0, _badgeViewWidth_, _badgeViewHeight_)];
                [self addSubview:_numberBadge];
            }
            
            if([_numberBadge.value integerValue] > 0)
            {
                _numberBadge.hidden = NO;
            }
        }
        else
        {
            _numberBadge.hidden = YES;
        }
    }
}

@end
