//
//  SeaTabBar.m

//

#import "SeaTabBar.h"
#import "SeaTabBarItem.h"

@implementation SeaTabBar

/**构造方法
 *@param frame 位置大小
 *@param items 选项卡按钮 数值元素是 SeaTabBarItem
 *@return 一个实例
 */
- (id)initWithFrame:(CGRect)frame items:(NSArray*) items
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _items = [items copy];
        _selectedIndex = NSNotFound;
        
        for(NSInteger i = 0;i < _items.count;i ++)
        {
            SeaTabBarItem *item = [_items objectAtIndex:i];
            [item addTarget:self action:@selector(tabBarItemDidSelect:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:item];
        }
        
        _separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, _separatorLineWidth_)];
        _separatorLine.backgroundColor = _separatorLineColor_;
        _separatorLine.userInteractionEnabled = NO;
        [self addSubview:_separatorLine];
    }
    
    return self;
}

- (void)dealloc
{
   
}

#pragma mark- private method

//选中某个按钮
- (void)tabBarItemDidSelect:(SeaTabBarItem*) item
{
    if(item.selected == YES)
        return;
    
    BOOL shouldSelect = YES;
    if([self.delegate respondsToSelector:@selector(tabBar:shouldSelectItemAtIndex:)])
    {
        shouldSelect = [self.delegate tabBar:self shouldSelectItemAtIndex:[_items indexOfObject:item]];
    }
    
    if(shouldSelect)
    {
        self.selectedIndex = [_items indexOfObject:item];
    }
}

#pragma mark- property

//设置选中的
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if(_selectedIndex != selectedIndex)
    {
        if(_selectedIndex < _items.count)
        {
            SeaTabBarItem *item = [_items objectAtIndex:_selectedIndex];
            item.selected = NO;
        }
        
        _selectedIndex = selectedIndex;
        SeaTabBarItem *item = [_items objectAtIndex:_selectedIndex];
        item.selected = YES;
        
        if([self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)])
        {
            [self.delegate tabBar:self didSelectItemAtIndex:_selectedIndex];
        }
    }
}

//设置背景
- (void)setBackgroundView:(UIView *)backgroundView
{
    if(_backgroundView != backgroundView)
    {
        [_backgroundView removeFromSuperview];
        _backgroundView = backgroundView;
        
        if(_backgroundView != nil)
        {
            _backgroundView.frame = self.bounds;
            [self insertSubview:_backgroundView atIndex:0];
        }
    }
}

@end
