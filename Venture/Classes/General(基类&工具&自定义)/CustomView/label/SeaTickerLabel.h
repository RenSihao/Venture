//
//  SeaTickerLabel.h

//

#import <UIKit/UIKit.h>

//文字滚动方向
typedef NS_ENUM(NSInteger, SeaTickerAnimatedDirection)
{
    SeaTickerAnimatedDirectionLeftToRight = 0, ///从左到右
    SeaTickerAnimatedDirectionRightToLeft = 1, ///从右到左
};

@interface SeaTickerLabel : UIView

/**边距 default is 'UIEdgeInsetsZero'
 */
@property(nonatomic,assign) UIEdgeInsets insets;

/**滚动的label
 */
@property(nonatomic,readonly) UILabel *tickerLabel;

/**要滚动的文字内容，数组元素是 NSString 
 */
@property(nonatomic,strong) NSArray *tickerStrings;

/**滚动速度 default is '60.0'
 */
@property(nonatomic,assign) float tickerSpeed;

/**当前滚动到的位置
 */
@property(nonatomic,readonly) NSInteger currentIndex;

/**是否循环滚动 default is 'YES'
 */
@property(nonatomic,assign) BOOL loops;

/**滚动方向 default is 'SeaTickerAnimatedDirectionLeftToRight'
 */
@property(nonatomic,assign) SeaTickerAnimatedDirection direction;

/**是否正在滚动
 */
@property(nonatomic,readonly) BOOL running;

/**开始
 */
-(void)start;

/**暂停
 */
-(void)pause;

/**回复动画
 */
-(void)resume;

@end
