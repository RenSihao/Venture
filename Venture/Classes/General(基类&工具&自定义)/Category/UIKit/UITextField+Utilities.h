//
//  UITextField+customTextField.h

//

#import <UIKit/UIKit.h>

@interface UITextField (Utilities)

#pragma mark- 内嵌视图

/**设置输入框左边图标
 *@param imageName 图标名称
 *@param padding 图标与文字的间距
 */
- (void)setLeftViewWithImageName:(NSString*) imageName padding:(CGFloat) padding;

/**设置输入框右边图标
 *@param imageName 图标名称
 *@param padding 图标与文字的间距
 */
- (void)setRightViewWithImageName:(NSString*) imageName padding:(CGFloat) padding;

/**底部分割线
 *@param color 分割线颜色
 *@param height 分割线高度
 */
- (void)setSeparatorLineWithColor:(UIColor*) color height:(CGFloat) height;

#pragma mark- 文本限制

/**文本变化，在textDidChange中调用
 *@param count 输入框最大可输入字数
 */
- (void)textDidChangeWithLimitedCount:(NSInteger) count;

/**在textField的代理中调用
 *@param range 文本变化的范围
 *@param string 替换的文字
 *@param count 输入框最大可输入字数
 */
- (BOOL)textShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string limitedCount:(NSInteger) count;

/**在textField的代理中调用,把中文当成两个字符
 *@param range 文本变化的范围
 *@param string 替换的文字
 *@param count 输入框最大可输入字数
 */
- (BOOL)textShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string limitedCountChinesseAsTwoChar:(NSInteger) count;

/**设置默认的附加视图
 *@param target 方法执行者
 *@param action 方法
 */
- (void)setDefaultInputAccessoryViewWithTarget:(id) target action:(SEL) action;

/**在textField的代理中调用，限制只能输入一个小数点，并且第一个输入不能是小数点
 *@param range 文本变化的范围
 *@param string 替换的文字
 *@param limitedNum 输入框可输入的最大值
 */
- (BOOL)textShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string limitedNum:(double) limitedNum;

/**禁止的方法列表，如复制，粘贴，通过 NSStringFromSelector 把需要禁止的方法传进来，如禁止粘贴，可传 NSStringFromSelector(paste:) default is 'nil'
 */
@property(nonatomic,strong) NSArray *forbidSelectors;

@end
