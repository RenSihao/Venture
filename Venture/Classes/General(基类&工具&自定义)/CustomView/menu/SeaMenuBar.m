//
//  UBMenuBar.m

//

#import "SeaMenuBar.h"
#import "SeaMenuBarItem.h"

#define _startTag_ 2000

@interface SeaMenuBar ()

//滚动视图
@property(nonatomic,strong) UIScrollView *scrollView;

//菜单按钮数量
@property(nonatomic,assign) NSInteger menuItemCount;

//选中的下划线
@property(nonatomic,strong) UIView *lineView;

//标题宽度 数组元素是 NSNumber ,float值
@property(nonatomic,strong) NSMutableArray *titleWidthArray;

@end

@implementation SeaMenuBar

/**构造方法
 *@param frame 位置大小
 *@param titles 菜单按钮标题，数组元素是 NSString
 *@param style 样式
 *@return 已初始化的 UBMenuBar
 */
- (id)initWithFrame:(CGRect)frame titles:(NSArray*) titles style:(SeaMenuBarStyle) style
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.menuItemCount = titles.count;
        [self initialization];
        
        
        _style = style;
        _selectedIndex = NSNotFound;
        self.backgroundColor = [UIColor whiteColor];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.scrollsToTop = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        self.titleWidthArray = [NSMutableArray arrayWithCapacity:_menuItemCount];
        
        //计算文本宽度
        for(NSString *title in titles)
        {
            CGFloat titleWidth = [title stringSizeWithFont:_titleFont contraintWith:frame.size.width].width;
            [self.titleWidthArray addObject:[NSNumber numberWithFloat:titleWidth]];
        }
        
        //创建按钮
        for(NSInteger i = 0;i < _menuItemCount;i++)
        {
            NSString *title = [titles objectAtIndex:i];
            
            CGRect btnFrame = CGRectZero;
            btnFrame.size.height = frame.size.height;
            
            SeaMenuBarItem *item = [[SeaMenuBarItem alloc] initWithFrame:btnFrame target:self action:@selector(menuItemDidSelect:)];
            [item.button setTitle:title forState:UIControlStateNormal];
            [item.button setTitleColor:_selectedColor forState:UIControlStateSelected];
            [item.button setTitleColor:_titleColor forState:UIControlStateNormal];
            [item.button.titleLabel setFont:_titleFont];
            item.tag = _startTag_ + i;
            [self.scrollView addSubview:item];
        }
        
        [self layoutItems];
        
        ///选中的下划线
        CGFloat lineHeight = 2.0;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - lineHeight, 0, lineHeight)];
        line.backgroundColor = _selectedColor;
        [self.scrollView addSubview:line];
        self.lineView = line;
        
        self.selectedIndex = 0;
        
        ///顶部分割线
        _topSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, _separatorLineWidth_)];
        _topSeparatorLine.backgroundColor = _separatorLineColor_;
        [self addSubview:_topSeparatorLine];
        
        //底部分割线
        _separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - _separatorLineWidth_, self.width, _separatorLineWidth_)];
        _separatorLine.backgroundColor = _separatorLineColor_;
        [self addSubview:_separatorLine];
    }
    return self;
}

///初始化
- (void)initialization
{
    _titleColor = MainGrayColor;
    _titleFont = [UIFont fontWithName:MainFontName size:13];
    _selectedColor = _appMainColor_;
    _buttonInterval = 0;
    _buttonWidthExtension = 20.0;
    _showSeparator = NO;
    _contentInsets = UIEdgeInsetsZero;
}

#pragma mark- property

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.scrollView.frame = self.bounds;
}



///设置按钮标题颜色
- (void)setTitleColor:(UIColor *)titleColor
{
    if(![_titleColor isEqualToColor:titleColor])
    {
        if(titleColor == nil)
            titleColor = [UIColor blackColor];
        _titleColor = titleColor;
        
        for(NSInteger i = 0;i < _menuItemCount;i ++)
        {
            SeaMenuBarItem *item = [self menuBarItemForIndex:i];
            [item.button setTitleColor:_titleColor forState:UIControlStateNormal];
        }
    }
}

///设置标题字体
- (void)setTitleFont:(UIFont *)titleFont
{
    if(![_titleFont isEqualToFont:titleFont])
    {
        if(titleFont == nil)
            titleFont = [UIFont fontWithName:MainFontName size:15.0];
        
        _titleFont = titleFont;
        [self.titleWidthArray removeAllObjects];
        
        
        ///重新计算文本宽度
        for(NSInteger i = 0;i < _menuItemCount;i ++)
        {
            SeaMenuBarItem *item = [self menuBarItemForIndex:i];
            CGFloat titleWidth = [[item.button titleForState:UIControlStateNormal] stringSizeWithFont:_titleFont contraintWith:self.frame.size.width].width;
            
            [self.titleWidthArray addObject:[NSNumber numberWithFloat:titleWidth]];
        }
        [self layoutItems];
    }
}

/**菜单按钮 选中颜色 default is '_appMainColor_'
 */
- (void)setSelectedColor:(UIColor *)selectedColor
{
    if(![_selectedColor isEqualToColor:selectedColor])
    {
        if(selectedColor == nil)
            selectedColor = _appMainColor_;
        _selectedColor = selectedColor;
        
        for(NSInteger i = 0;i < _menuItemCount;i ++)
        {
            SeaMenuBarItem *item = [self menuBarItemForIndex:i];
            [item.button setTitleColor:_selectedColor forState:UIControlStateSelected];
        }
        _lineView.backgroundColor = _selectedColor;
    }
}

/**按钮间隔 default is '0'
 */
- (void)setButtonInterval:(CGFloat)buttonInterval
{
    if(_buttonInterval != buttonInterval)
    {
        _buttonInterval = buttonInterval;
        [self layoutItems];
    }
}

/**按钮宽度延伸 defautl is '10.0'
 */
- (void)setButtonWidthExtension:(CGFloat)buttonWidthExtension
{
    if(_buttonWidthExtension != buttonWidthExtension)
    {
        _buttonWidthExtension = buttonWidthExtension;
        [self layoutItems];
    }
}

/**是否显示分隔符 default is 'NO'
 */
- (void)setShowSeparator:(BOOL)showSeparator
{
    if(_showSeparator != showSeparator)
    {
        _showSeparator = showSeparator;
        for(NSInteger i = 0;i < _menuItemCount;i ++)
        {
            SeaMenuBarItem *item = [self menuBarItemForIndex:i];
            item.separator.hidden = !_showSeparator;
        }
    }
}

/**内容边距 default is 'UIEdgeInsetsZero'
 */
- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    contentInsets.bottom = 0;
    contentInsets.top = 0;
    if(!UIEdgeInsetsEqualToEdgeInsets(contentInsets, _contentInsets))
    {
        _contentInsets = contentInsets;
        self.scrollView.contentInset = _contentInsets;
        if(_style != SeaMenuBarStyleItemWithRelateTitle)
        {
            [self layoutItems];
        }
    }
}

#pragma mark- private method

///重新布局按钮
- (void)layoutItems
{
    CGFloat x = 0;
    
    CGFloat menuItemWidth = (self.width - _contentInsets.left - _contentInsets.right) / _menuItemCount;
    for(NSInteger i = 0;i < _menuItemCount;i ++)
    {
        SeaMenuBarItem *item = [self menuBarItemForIndex:i];
        CGFloat titleWidth = [[self.titleWidthArray objectAtIndex:i] floatValue] + _buttonWidthExtension;
        
        CGRect frame = item.frame;
        switch (_style)
        {
            case SeaMenuBarStyleItemWithRelateTitle :
            {
                frame.origin.x = x;
                frame.size.width = titleWidth;
            }
                break;
            case SeaMenuBarStyleDefault :
            case SeaMenuBarStyleItemWithRelateTitleInFullScreen :
            {
                frame.size.width = menuItemWidth;
                frame.origin.x = x;
            }
                break;
        }
        
        item.frame = frame;
        x += frame.size.width + _buttonInterval;
    }
    
    if(_style == SeaMenuBarStyleItemWithRelateTitle)
    {
        SeaMenuBarItem *item = [self menuBarItemForIndex:_menuItemCount - 1];
        self.scrollView.contentSize = CGSizeMake(item.right, self.scrollView.height);
    }
    else
    {
        self.scrollView.contentSize = CGSizeZero;
    }
    
    NSInteger index = _selectedIndex;
    _selectedIndex = NSNotFound;
    self.selectedIndex = index;
}

///选择某个菜单按钮
- (void)menuItemDidSelect:(UIButton*) btn
{
    
    NSInteger index = btn.superview.tag - _startTag_;
    [self setSelectedIndex:index animated:YES];
}

///通过下标获取按钮
- (SeaMenuBarItem*)menuBarItemForIndex:(NSInteger) index
{
    SeaMenuBarItem *item = (SeaMenuBarItem*)[self.scrollView viewWithTag:_startTag_ + index];
    return item;
}

#pragma mark- public method

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if(_selectedIndex != selectedIndex)
    {
        [self setSelectedIndex:selectedIndex animated:NO];
    }
}

/**设置选中的菜单按钮
 *@param selectedIndex 菜单按钮下标
 *@param flag 是否动画
 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL) flag
{
    if(_selectedIndex == selectedIndex || selectedIndex >= self.titleWidthArray.count)
        return;
    
    //取消以前的选中状态
    SeaMenuBarItem *item = [self menuBarItemForIndex:_selectedIndex];
    item.button.selected = NO;
    
    _selectedIndex = selectedIndex;
    item = [self menuBarItemForIndex:_selectedIndex];
    
    item.button.selected = YES;
    
    CGRect frame = _lineView.frame;
    
    switch (_style)
    {
        case SeaMenuBarStyleDefault :
        {
            SeaMenuBarItem *item = [self menuBarItemForIndex:_selectedIndex];
            frame.origin.x = item.frame.origin.x;
            frame.size.width = item.width;
        }
            break;
        case SeaMenuBarStyleItemWithRelateTitle :
        {
            UIView *view = [self viewWithTag:_startTag_ + _selectedIndex];
            frame.origin.x = view.frame.origin.x;
            frame.size.width = view.frame.size.width;
            
            //判断是否是点击可见屏幕的最后一个
            
            //下一个
            NSInteger index = _selectedIndex + 1;
            if(index < self.titleWidthArray.count)
            {
                UIView *nextView = [self viewWithTag:index + _startTag_];
                if(nextView.right >= self.scrollView.contentOffset.x + self.scrollView.width)
                {
                    view = nextView;
                }
            }
            
            //判断是否是点击可见屏幕的第一个
            
            //上一个
            index = _selectedIndex - 1;
            if(index >= 0 && index < self.titleWidthArray.count)
            {
                UIView *preview = [self viewWithTag:index + _startTag_];
                if(preview.left <= self.scrollView.contentOffset.x)
                {
                    view = preview;
                }
            }
            
            
            [self.scrollView scrollRectToVisible:view.frame animated:YES];
            
        }
            break;
        case SeaMenuBarStyleItemWithRelateTitleInFullScreen :
        {
            SeaMenuBarItem *item = [self menuBarItemForIndex:_selectedIndex];
            CGFloat titleWidth = [[self.titleWidthArray objectAtIndex:_selectedIndex] floatValue];
            
            frame.origin.x = item.frame.origin.x + (item.frame.size.width - titleWidth) / 2.0;
            frame.size.width = titleWidth;
        }
            break;
        default:
            break;
    }
    
    if(flag)
    {
        [UIView animateWithDuration:kAnimatedDuration animations:^(void){
            
            _lineView.frame = frame;
        }];
    }
    else
    {
        _lineView.frame = frame;
    }
    
    
    if([self.delegate respondsToSelector:@selector(menuBar:didSelectItemAtIndex:)])
    {
        [self.delegate menuBar:self didSelectItemAtIndex:_selectedIndex];
    }
}


@end
