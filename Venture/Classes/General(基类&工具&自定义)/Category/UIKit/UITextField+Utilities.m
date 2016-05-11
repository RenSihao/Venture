//
//  UITextField+customTextField.m

//

#import "UITextField+Utilities.h"
#import <objc/runtime.h>

static NSString *const WMForbidSelectorsKey = @"WMForbidSelectorsKey";

@implementation UITextField (Utilities)

#pragma mark- 内嵌视图

/**设置输入框左边图标
 *@param imageName 图标名称
 *@param padding 图标与文字的间距
 */
- (void)setLeftViewWithImageName:(NSString*) imageName padding:(CGFloat)padding
{
    self.leftViewMode = UITextFieldViewModeAlways;
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.height - image.size.height) / 2.0, image.size.width + padding, image.size.height)];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.image = image;
    self.leftView = imageView;
}

/**设置输入框右边图标
 *@param imageName 图标名称
 *@param padding 图标与文字的间距
 */
- (void)setRightViewWithImageName:(NSString*) imageName padding:(CGFloat)padding
{
    self.rightViewMode = UITextFieldViewModeAlways;
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.height - image.size.height) / 2.0, image.size.width + padding, image.size.height)];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.image = image;
    self.rightView = imageView;
}

/**底部分割线
 *@param color 分割线颜色
 *@param height 分割线高度
 */
- (void)setSeparatorLineWithColor:(UIColor *)color height:(CGFloat)height
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - height, self.width, height)];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
}

#pragma mark- 文本限制

/**文本变化，在textDidChange中调用
 *@param count 输入框最大可输入字数
 */
- (void)textDidChangeWithLimitedCount:(NSInteger) count
{
    UITextRange *textRange = [self markedTextRange];
    if(textRange == nil && self.text.length > count)
    {
        self.text = [self.text substringWithRange:NSMakeRange(0, count)];
    }
}

/**在textField的代理中调用
 *@param range 文本变化的范围
 *@param string 替换的文字
 *@param count 输入框最大可输入字数
 */
- (BOOL)textShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string limitedCount:(NSInteger) count
{
    UITextRange *textRange = [self markedTextRange];
    
    NSString *markText = [self textInRange:textRange];
    
    NSString *new = [self.text stringByReplacingCharactersInRange:range withString:string];
    
    NSInteger length = new.length - (textRange.empty ? 0 : markText.length + 1);
    
    NSInteger res = count - length;
    
    
    if(res > 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = count - self.text.length;
        if(len < 0)
            len = 0;
        if(len > string.length)
            len = string.length;
        
        NSString *str = [self.text stringByReplacingCharactersInRange:range withString:[string substringWithRange:NSMakeRange(0, len)]];
        self.text = str;
        
        return NO;
    }
}

/**在textField的代理中调用,把中文当成两个字符
 *@param range 文本变化的范围
 *@param string 替换的文字
 *@param count 输入框最大可输入字数
 */
- (BOOL)textShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string limitedCountChinesseAsTwoChar:(NSInteger) count
{
    UITextRange *textRange = [self markedTextRange];
    
    NSString *markText = [self textInRange:textRange];
    
    NSString *new = [self.text stringByReplacingCharactersInRange:range withString:string];
    
    
    
    NSInteger length = new.lengthWithChineseAsTwoChar - (textRange.empty ? 0 : markText.lengthWithChineseAsTwoChar + 1);
    
    NSInteger res = count - length;
    
    
    if(res > 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = count - self.text.lengthWithChineseAsTwoChar;
        if(len < 0)
            len = 0;
        if(len > string.length)
            len = string.length;
        
        NSString *str = [self.text stringByReplacingCharactersInRange:range withString:[string substringWithRange:NSMakeRange(0, len)]];
        self.text = str;
        
        return NO;
    }
}


/**设置默认的附加视图
 *@param target 方法执行者
 *@param action 方法
 */
- (void)setDefaultInputAccessoryViewWithTarget:(id) target action:(SEL) action
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35.0)];
    view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    CGFloat buttonWidth = 60.0;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:_UIKitTintColor_ forState:UIControlStateNormal];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(SCREEN_WIDTH - buttonWidth, 0, buttonWidth, 35.0)];
    [view addSubview:button];
    self.inputAccessoryView = view;
}

/**在textField的代理中调用，限制只能输入一个小数点
 *@param range 文本变化的范围
 *@param string 替换的文字
 *@param limitedNum 输入框可输入的最大值
 */
- (BOOL)textShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string limitedNum:(double) limitedNum
{
    NSRange containRange = [string rangeOfString:@"."];
    
    if(containRange.location != NSNotFound)
    {
        //只能输入一个小数点
        containRange = [self.text rangeOfString:@"."];
        if(containRange.location != NSNotFound)
            return NO;
        
        //第一个输入不能是小数点
        if(self.text.length == 0)
        {
            if([string firstCharacter] == [@"." firstCharacter])
            {
                return NO;
            }
        }
    }
    
    
    NSString *new = [self.text stringByReplacingCharactersInRange:range withString:string];
    double value = [new doubleValue];
    
    return value <= limitedNum;
}

- (void)setForbidSelectors:(NSString *)forbidSelectors
{
    objc_setAssociatedObject(self, &WMForbidSelectorsKey, forbidSelectors, OBJC_ASSOCIATION_RETAIN);
}

- (NSArray*)forbidSelectors
{
    return objc_getAssociatedObject(self, &WMForbidSelectorsKey);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    NSArray *forbidSelectors = self.forbidSelectors;
    if(forbidSelectors.count > 0)
    {
        if([forbidSelectors containsObject:NSStringFromSelector(action)])
        {
            return NO;
        }
    }
    
    return YES;
}

@end
