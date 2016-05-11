//
//  UIView+Utilities.h

//

#import <UIKit/UIKit.h>

@interface UIView (Utilities)

/** get and set frame.origin.y
*/
@property (nonatomic) CGFloat top;

/** get and set (frame.origin.y + frame.size.height)
 */
@property (nonatomic) CGFloat bottom;

/** get and set (frame.origin.x + frame.size.width)
 */
@property (nonatomic) CGFloat right;

/** get and set frame.origin.x
 */
@property (nonatomic) CGFloat left;

/** get and set frame.size.width
 */
@property (nonatomic) CGFloat width;

/** get and set frame.size.height
 */
@property (nonatomic) CGFloat height;

@end
