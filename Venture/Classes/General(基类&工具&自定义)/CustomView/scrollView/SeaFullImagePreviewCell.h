//
//  UBFullImagePreviewCell.h

//

#import "SeaScrollViewCell.h"

/**完整图片预览cell
 */
@interface SeaFullImagePreviewCell : UIScrollView<UIScrollViewDelegate>

/**图片
 */
@property(nonatomic,readonly) UIImageView *imageView;

@end
